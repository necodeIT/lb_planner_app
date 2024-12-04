import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';

/// Displays the user's upcoming exams.
class Exams extends StatelessWidget {
  /// Displays the user's upcoming exams.
  const Exams({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>();

    final candidates = tasks.filter(
      type: {MoodleTaskType.exam},
      maxDeadlineDiff: const Duration(days: 7),
    );

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.dashboard_exams,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Spacing.mediumVertical(),
            if (candidates.isNotEmpty)
              SingleChildScrollView(
                child: Column(
                  children: [
                    for (final task in candidates) MoodleTaskWidget(task: task),
                  ].vSpaced(Spacing.smallSpacing).show(),
                ),
              ).expanded(),
            if (candidates.isEmpty) Text(context.t.dashboard_exams_noExams).center().expanded(),
          ],
        ),
      ),
    );
  }
}
