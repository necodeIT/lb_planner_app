import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_utils/flutter_utils.dart';

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
        child: Text(course.shortname)
            .color(
              useWhiteForeground(course.color, bias: 70)
                  ? context.theme.colorScheme.onPrimary
                  : context.theme.brightness == Brightness.dark
                      ? context.theme.colorScheme.onSurface.darken(100)
                      : context.theme.colorScheme.onSurface,
            )
            .bold()
            .fontSize(12),
      ),
    );
  }
}
