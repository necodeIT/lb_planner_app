import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Renders a burndown chart of the user's tasks.
class BurndownChart extends StatelessWidget {
  /// Renders a burndown chart of the user's tasks.
  const BurndownChart({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksRepo = context.watch<MoodleTasksRepository>();
    final plan = context.watch<CalendarPlanRepository>();
    final courses = context.watch<MoodleCoursesRepository>();
    final user = context.watch<UserRepository>();

    if (!tasksRepo.state.hasData || !plan.state.hasData || !courses.state.hasData || !user.state.hasData) {
      return _card(context, const CircularProgressIndicator().center());
    }

    final tasks = tasksRepo.filter(
      courseIds: courses.filter(enabled: true).map((e) => e.id).toSet(),
      type: {
        if (user.state.requireData.optionalTasksEnabled) MoodleTaskType.optional,
        MoodleTaskType.required,
        MoodleTaskType.participation,
      },
    );

    // Determine the start and end dates based on the current date.
    // If the current date is before February:
    //   - Use September of last year as the start date.
    //   - Use January of this year as the end date.
    // If the current date is after February but before September:
    //   - Use February of this year as the start date.
    //   - Use June of this year as the end date.
    // If the current date is in or after September:
    //   - Use September of this year as the start date.
    //   - Use January of next year as the end date.

    final now = DateTime.now();

    final DateTime startDate;
    final DateTime endDate;

    if (now.month < 2) {
      // Before February
      startDate = DateTime(now.year - 1, 9); // September of last year
      endDate = DateTime(now.year, 2, 0); // January of this year
    } else if (now.month >= 2 && now.month < 9) {
      // Between February and August
      startDate = DateTime(now.year, 2); // February of this year
      endDate = DateTime(now.year, 7, 0); // June of this year
    } else {
      // September or later
      startDate = DateTime(now.year, 9); // September of this year
      endDate = DateTime(now.year + 1, 2, 0); // January of next year
    }

    final plannedTasks = plan.filterDeadlines(
      betweenStart: startDate,
      betweenEnd: endDate,
    );

    final days = endDate.difference(startDate).inDays + 2; // add 2 to include the first and the last day

    /// determine how many tasks are left for each day since the start date

    var tasksLeft = tasks.length;

    final amountOfTasksLeftForEachDaySinceStart = List<int>.generate(
      days,
      (index) {
        final date = startDate.add(Duration(days: index));

        final tasksPlannedForDate = plannedTasks
            .where(
              (d) => d.end.isSameDate(date) && tasks.any((t) => t.id == d.id),
            )
            .length;

        return tasksLeft -= tasksPlannedForDate;
      },
    );

    final spots = <FlSpot>[];

    var previous = 0;

    for (var i = 0; i < amountOfTasksLeftForEachDaySinceStart.length; i++) {
      if (amountOfTasksLeftForEachDaySinceStart[i] != previous) {
        spots.add(FlSpot(i.toDouble(), amountOfTasksLeftForEachDaySinceStart[i].toDouble()));
        previous = amountOfTasksLeftForEachDaySinceStart[i];
      }
    }

    spots.add(FlSpot(days.toDouble(), amountOfTasksLeftForEachDaySinceStart.last.toDouble()));

    final actualDataColor = amountOfTasksLeftForEachDaySinceStart.last != 0 ? context.theme.colorScheme.error : context.taskStatusTheme.doneColor;

    final idealDataColor = context.theme.colorScheme.primary;

    final actualData = LineChartBarData(
      color: actualDataColor,
      spots: spots,
      barWidth: 5,
      isStrokeCapRound: true,
    );

    final idealAverage = tasks.length / days;

    final idealData = LineChartBarData(
      color: idealDataColor,
      spots: [
        FlSpot(0, tasks.length.toDouble()),
        FlSpot(days.toDouble(), 0),
      ],
      barWidth: 5,
      isStrokeCapRound: true,
    );

    return _card(
      context,
      Column(
        children: [
          LineChart(
            curve: Curves.easeInOut,
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => context.theme.scaffoldBackgroundColor,
                  tooltipRoundedRadius: 10,
                  fitInsideHorizontally: true,
                  fitInsideVertically: true,
                ),
              ),
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              maxY: tasks.length.toDouble(),
              maxX: days.toDouble(),
              lineBarsData: [
                actualData,
                idealData,
              ],
            ),
          ).expanded(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: actualDataColor,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                  Spacing.smallHorizontal(),
                  Text(context.t.dashboard_burnDownChart_plannedTrajectory),
                ],
              ),
              Spacing.mediumHorizontal(),
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: idealDataColor,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                  Spacing.smallHorizontal(),
                  Text(context.t.dashboard_burnDownChart_idealTrajectory(double.parse(idealAverage.toStringAsFixed(2)))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, Widget child) {
    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.t.dashboard_burnDownChart, style: context.textTheme.titleMedium?.bold).alignAtTopLeft(),
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: () {
                    showMarkdownDialog(
                      context,
                      title: context.t.dashboard_burnDownChart_explanation_title,
                      markdown: context.t.dashboard_burnDownChart_explanation_message,
                    );
                  },
                  icon: const Icon(Icons.help_outline),
                ),
              ],
            ),
            Spacing.medium(),
            child.expanded(),
          ],
        ),
      ),
    );
  }
}
