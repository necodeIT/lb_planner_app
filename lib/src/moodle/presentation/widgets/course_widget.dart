import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';

/// Renders a given [MoodleCourse] as a widget.
class CourseWidget extends StatelessWidget {
  /// Renders a given [MoodleCourse] as a widget.
  const CourseWidget({super.key, required this.course});

  /// The course to render.
  final MoodleCourse course;

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<MoodleCoursesRepository>();

    return Row(
      children: [
        Checkbox(
          value: course.enabled,
          onChanged: (value) {
            courses.enableCourse(course, enabled: value ?? false);
          },
        ),
        Spacing.xsHorizontal(),
        CourseTag(course: course),
        Spacing.mediumHorizontal(),
        Expanded(
          child: Text(course.name).center(),
        ),
        Spacing.mediumHorizontal(),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: const Icon(Icons.more_horiz),
          onPressed: () => showAnimatedDialog(
            context: context,
            pageBuilder: (_, __, ___) => CourseCustomizer(course: course),
          ),
        ),
      ],
    );
  }
}
