import 'package:awesome_extensions/awesome_extensions.dart';
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
    final tasks = context.watch<MoodleTasksRepository>();
    final plan = context.watch<CalendarPlanRepository>();

    final startDate = DateTime.now().copyWith(month: 9, day: 1);
    final endDate = DateTime.now().copyWith(month: 12, day: 0);

    final plannedTasks = plan.filterDeadlines(
      betweenStart: startDate,
      betweenEnd: endDate,
    );

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(context.t.dashboard_burnDownChart, style: context.textTheme.titleMedium?.bold).alignAtTopLeft(),
          ],
        ),
      ),
    );
  }
}
