import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays the user's upcoming exams.
class Exams extends StatelessWidget with AdaptiveWidget {
  /// Displays the user's upcoming exams.
  const Exams({super.key});

  @override
  Widget buildDesktop(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>();

    final candidates = tasks.filter(
      type: {MoodleTaskType.exam},
      maxDeadlineDiff: const Duration(days: 7),
      minDeadlineDiff: Duration.zero,
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
                    for (final task in candidates)
                      MoodleTaskWidget(
                        task: task,
                        displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndDate,
                      ),
                  ].vSpaced(Spacing.smallSpacing).show(),
                ),
              ).expanded(),
            if (candidates.isEmpty)
              ImageMessage(
                message: context.t.dashboard_exams_noExams,
                image: Assets.dashboard.noExams,
              ).expanded(),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>();

    final candidates = tasks.filter(
      type: {MoodleTaskType.exam},
      maxDeadlineDiff: const Duration(days: 7),
      minDeadlineDiff: Duration.zero,
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
              Column(
                children: [
                  for (final task in candidates)
                    MoodleTaskWidget(
                      task: task,
                      displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndDate,
                    ),
                ].vSpaced(Spacing.smallSpacing).show(),
              ),
            if (candidates.isEmpty)
              SizedBox(
                height: 100,
                child: ImageMessage(
                  message: context.t.dashboard_exams_noExams,
                  image: Assets.dashboard.noExams,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
