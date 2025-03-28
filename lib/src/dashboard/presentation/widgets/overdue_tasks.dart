import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays the user's tasks scheduled for today.
class OverdueTasks extends StatelessWidget with AdaptiveWidget {
  /// Displays the user's tasks scheduled for today.
  const OverdueTasks({super.key});

  @override
  Widget buildDesktop(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>();

    final candidates = tasks.filter(status: {MoodleTaskStatus.late});

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.dashboard_overdueTasks,
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
                      ),
                  ].vSpaced(Spacing.smallSpacing).show(),
                ),
              ).expanded(),
            if (candidates.isEmpty)
              ImageMessage(
                message: context.t.dashboard_noTasksOverdue,
                image: Assets.dashboard.noOverdueTasks,
              ).expanded(),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>();

    final candidates = tasks.filter(status: {MoodleTaskStatus.late});

    if (candidates.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        Text(
          context.t.dashboard_overdueTasks,
          style: context.textTheme.titleMedium?.bold,
        ).alignAtTopLeft(),
        Spacing.mediumVertical(),
        Column(
          children: [
            for (final task in candidates)
              MoodleTaskWidget(
                task: task,
              ),
          ].vSpaced(Spacing.smallSpacing).show(),
        ),
        Spacing.mediumVertical(),
      ],
    );
  }
}
