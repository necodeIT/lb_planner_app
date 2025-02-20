import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
            if (candidates.isEmpty)
              ImageMessage(
                message: context.t.dashboard_todaysTasks_noTasks,
                image: Assets.dashboard.nothingPlannedForToday,
              ).expanded(),
          ],
        ),
      ),
    );
  }
}
