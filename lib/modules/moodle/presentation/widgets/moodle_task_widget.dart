import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Renders the given [task].
class MoodleTaskWidget extends StatelessWidget {
  /// Renders the given [task] and the given [displayMode].
  const MoodleTaskWidget({
    super.key,
    required this.task,
    this.displayMode = MoodleTaskWidgetDisplayMode.nameAndCourse,
  });

  /// The task to render.
  final MoodleTask task;

  /// The display mode of the widget.
  final MoodleTaskWidgetDisplayMode displayMode;

  static const double _height = 35;

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<MoodleCoursesRepository>();

    return courses.state.when(
      data: (_) {
        final parent = courses.filter(id: task.courseId).firstOrNull;

        if (parent == null) return _skeleton(context);

        return Container(
          height: _height,
          padding: PaddingHorizontal(Spacing.xsSpacing),
          decoration: ShapeDecoration(
            color: context.theme.scaffoldBackgroundColor,
            shape: squircle(),
          ),
          child: Row(
            children: [
              CourseTag(course: parent),
              Spacing.xsHorizontal(),
              Text(
                task.name,
                overflow: TextOverflow.ellipsis,
              ).withTooltip(task.name).expanded(),
              if (displayMode != MoodleTaskWidgetDisplayMode.nameAndCourse) Spacing.xsHorizontal(),
              switch (displayMode) {
                MoodleTaskWidgetDisplayMode.nameAndCourse => const SizedBox.shrink(),
                MoodleTaskWidgetDisplayMode.nameAndCourseAndCheckmark => Checkbox(
                    value: task.status == MoodleTaskStatus.uploaded || task.status == MoodleTaskStatus.done,
                    onChanged: (_) {},
                    mouseCursor: MouseCursor.defer,
                  ),
                MoodleTaskWidgetDisplayMode.nameAndCourseAndIcon => Container(
                    height: 32,
                    width: 32,
                    decoration: ShapeDecoration(
                      shape: squircle(radius: 4),
                      color: switch (task.status) {
                        MoodleTaskStatus.done => context.theme.taskStatusTheme.doneColor,
                        MoodleTaskStatus.uploaded => context.theme.taskStatusTheme.uploadedColor,
                        MoodleTaskStatus.pending => context.theme.taskStatusTheme.pendingColor,
                        MoodleTaskStatus.late => context.theme.taskStatusTheme.lateColor,
                      },
                    ),
                  ),
              },
            ],
          ),
        );
      },
      loading: () => _skeleton(context),
      error: (_, __) => _skeleton(context),
    );
  }

  Widget _skeleton(BuildContext context) => Container(
        height: _height,
        decoration: ShapeDecoration(
          color: context.theme.scaffoldBackgroundColor,
          shape: squircle(),
        ),
      ).applyShimmerThemed(context);
}

/// Display mode for [MoodleTaskWidget].
enum MoodleTaskWidgetDisplayMode {
  /// Displays the task's name and the [CourseTag] of its parent course.
  nameAndCourse,

  /// Displays the task's name and the [CourseTag] of its parent course, plus a checkmark if the task is completed.
  ///
  /// [MoodleTaskStatus.uploaded] and [MoodleTaskStatus.done] are considered as completed.
  nameAndCourseAndCheckmark,

  /// Displays the task's name and the [CourseTag] of its parent course, plus a different icon depending on the task's status.
  nameAndCourseAndIcon,
}
