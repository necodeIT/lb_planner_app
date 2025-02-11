import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// Displays the shortname of the given [course] in a colored tag.
class CourseTag extends StatelessWidget {
  /// Displays the shortname of the given [course] in a colored tag.
  const CourseTag({super.key, required this.course});

  /// The course to display.
  final MoodleCourse course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: squircle(radius: 5),
        color: course.color,
      ),
      child: Padding(
        padding: PaddingAll(Spacing.xsSpacing),
        child: Text(course.shortname).color(context.theme.colorScheme.onPrimary).bold().fontSize(12),
      ),
    );
  }
}
