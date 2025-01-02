import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders the given [task].
class MoodleTaskWidget extends StatelessWidget {
  /// Renders the given [task] and the given [displayMode].
  const MoodleTaskWidget({
    super.key,
    required this.task,
    this.displayMode = MoodleTaskWidgetDisplayMode.nameAndCourse,
    this.enableContextMenu = true,
    this.additionalContextMenuItems = const [],
  });

  /// The task to render.
  final MoodleTask task;

  /// The display mode of the widget.
  final MoodleTaskWidgetDisplayMode displayMode;

  /// Whether the context menu is enabled.
  final bool enableContextMenu;

  /// Additional context menu items.
  final List<ContextMenuButtonConfig> additionalContextMenuItems;

  static const double _height = 35;

  /// Used to format the date of the task when [displayMode] is [MoodleTaskWidgetDisplayMode.nameAndCourseAndDate].
  static final formatter = DateFormat('dd.MM.yyyy');

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<MoodleCoursesRepository>();

    return courses.state.when(
      data: (_) {
        final parent = courses.filter(id: task.courseId).firstOrNull;

        if (parent == null) return _skeleton(context);

        return ConditionalWrapper(
          condition: enableContextMenu,
          wrapper: (context, child) => ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  'Open in Moodle',
                  onPressed: () => launchUrl(Uri.parse(task.url)),
                  icon: const Icon(Icons.link),
                  iconHover: Icon(Icons.link, color: context.theme.colorScheme.primary),
                ),
                ...additionalContextMenuItems,
              ],
            ),
            child: child,
          ),
          child: Container(
            height: _height,
            padding: PaddingHorizontal(Spacing.xsSpacing),
            decoration: ShapeDecoration(
              color: context.theme.scaffoldBackgroundColor,
              shape: squircle(),
            ),
            child: Row(
              children: [
                if (displayMode != MoodleTaskWidgetDisplayMode.nameAndCheckmark) CourseTag(course: parent),
                Spacing.xsHorizontal(),
                Text(
                  task.name,
                  overflow: TextOverflow.ellipsis,
                ).withTooltip(task.name).expanded(),
                if (displayMode != MoodleTaskWidgetDisplayMode.nameAndCourse) Spacing.xsHorizontal(),
                switch (displayMode) {
                  MoodleTaskWidgetDisplayMode.nameAndCourse => const SizedBox.shrink(),
                  MoodleTaskWidgetDisplayMode.nameAndCheckmark => Checkbox(
                      value: task.status == MoodleTaskStatus.uploaded || task.status == MoodleTaskStatus.done,
                      onChanged: (_) {},
                      mouseCursor: MouseCursor.defer,
                    ),
                  MoodleTaskWidgetDisplayMode.nameAndCourseAndCheckmark => Checkbox(
                      value: task.status == MoodleTaskStatus.uploaded || task.status == MoodleTaskStatus.done,
                      onChanged: (_) {},
                      mouseCursor: MouseCursor.defer,
                    ),
                  MoodleTaskWidgetDisplayMode.nameAndCourseAndIcon => Container(
                      height: 15,
                      width: 15,
                      decoration: ShapeDecoration(
                        shape: squircle(
                          radius: 4,
                          side: task.status == MoodleTaskStatus.pending
                              ? BorderSide(color: context.theme.taskStatusTheme.pendingColor)
                              : BorderSide.none,
                        ),
                        color: switch (task.status) {
                          MoodleTaskStatus.done => context.theme.taskStatusTheme.doneColor,
                          MoodleTaskStatus.uploaded => context.theme.taskStatusTheme.uploadedColor,
                          MoodleTaskStatus.pending => Colors.transparent,
                          MoodleTaskStatus.late => context.theme.taskStatusTheme.lateColor,
                        },
                      ),
                      child: task.status == MoodleTaskStatus.pending
                          ? null
                          : Icon(
                              switch (task.status) {
                                MoodleTaskStatus.done => FontAwesome5Solid.check,
                                MoodleTaskStatus.uploaded => FontAwesome5Solid.minus,
                                _ => FontAwesome5Solid.exclamation,
                              },
                              size: 8,
                              color: context.theme.colorScheme.onPrimary,
                            ),
                    ),
                  MoodleTaskWidgetDisplayMode.nameAndCourseAndDate => Text(
                      formatter.format(task.deadline ?? DateTime.now()),
                      style: TextStyle(color: context.theme.disabledColor),
                    ),
                },
              ],
            ),
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

  /// Displays the task's name and the [CourseTag] of its parent course, plus the task's [MoodleTask.deadline]
  nameAndCourseAndDate,

  /// Same as [nameAndCourseAndCheckmark], but without the course tag.
  nameAndCheckmark,
}
