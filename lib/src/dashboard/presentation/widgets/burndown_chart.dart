import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:lb_planner/src/moodle/moodle.dart';

/// Renders a burndown chart of the user's tasks.
class BurndownChart extends StatelessWidget {
  /// Renders a burndown chart of the user's tasks.
  const BurndownChart({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksRepo = context.watch<MoodleTasksRepository>();
    final plan = context.watch<CalendarPlanRepository>();
    final courses = context.watch<MoodleCoursesRepository>();

    if (!tasksRepo.state.hasData || !plan.state.hasData || !courses.state.hasData) {
      return const CircularProgressIndicator().center();
    }

    final tasks = tasksRepo.filter(
      courseIds: courses.filter(enabled: true).map((e) => e.id).toSet(),
      type: {
        if (plan.state.requireData.optionalTasksEnabled) MoodleTaskType.optional,
        MoodleTaskType.required,
        MoodleTaskType.compensation,
      },
    );

    // if current date is before february, use september of last year as start date and january of this year as end date
    // else use february of this year as start date and june of this year as end date

    final now = DateTime.now();

    final startDate = now.month < 2 ? DateTime(now.year - 1, 9) : DateTime(now.year, 2);

    final endDate = now.month < 2 ? DateTime(now.year, 2, 0) : DateTime(now.year, 7, 0);

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

    final actualData = LineChartBarData(
      color: context.theme.colorScheme.primary,
      spots: spots,
      barWidth: 5,
      isStrokeCapRound: true,
    );

    final idealAverage = tasks.length / days;

    final idealData = LineChartBarData(
      color: context.taskStatusTheme.doneColor,
      spots: [
        FlSpot(0, tasks.length.toDouble()),
        FlSpot(days.toDouble(), 0),
      ],
      barWidth: 5,
      isStrokeCapRound: true,
    );

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
                      title: 'WTF is a burndown chart?',
                      markdown: '''
The **burndown chart** helps you visualize your progress toward completing tasks. 

- The **ideal trajectory** (straight line) shows how many tasks you should have left each day if you've planned your tasks in an ideal way to keep a steady workload.  
- The **actual trajectory** (curved line) shows how many tasks you're expected to have left based on when you've planned to complete them.  

This chart doesn’t track when tasks are actually completed—it's all about comparing your plan to the ideal pace so you can stay on track!
''',
                    );
                  },
                  icon: const Icon(Icons.help_outline),
                ),
              ],
            ),
            Spacing.medium(),
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
                        color: context.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    Spacing.smallHorizontal(),
                    Text('Planned trajectory'),
                  ],
                ),
                Spacing.mediumHorizontal(),
                Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: context.taskStatusTheme.doneColor,
                        borderRadius: BorderRadius.circular(1000),
                      ),
                    ),
                    Spacing.smallHorizontal(),
                    Text('Ideal trajectory (${idealAverage.toStringAsFixed(2)} tasks/day)'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
