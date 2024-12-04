import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';

/// Displays the user's tasks scheduled for today.
class TodaysTasks extends StatelessWidget {
  /// Displays the user's tasks scheduled for today.
  const TodaysTasks({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>();
    final plan = context.watch<CalendarPlanRepository>();

    final canditateIds = plan.filterDeadlines(plannedForToday: true).map((e) => e.id).toSet();
    final candidates = tasks.filter(taskIds: canditateIds);

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.dashboard_todaysTasks,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Spacing.mediumVertical(),
            if (candidates.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (final task in candidates)
                      MoodleTaskWidget(
                        task: task,
                        displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndCheckmark,
                      ),
                  ].vSpaced(Spacing.smallSpacing).show(),
                ),
              ).expanded(),
            if (candidates.isEmpty) Text(context.t.dashboard_todaysTasks_noTasks).center().expanded(),
          ],
        ),
      ),
    );
  }
}
