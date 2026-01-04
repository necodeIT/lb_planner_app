import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

/// A widget that shows the mapping between a course and a vintage.
class MappingWidget extends StatelessWidget {
  /// A widget that shows the mapping between a course and a vintage.
  const MappingWidget({super.key, required this.course, required this.vintage});

  /// The course to show.
  final MoodleCourse course;

  /// The vintage to show.
  final Vintage vintage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CourseTag(course: course),
        Spacing.xsHorizontal(),
        Text(course.name, overflow: TextOverflow.ellipsis).flexible(flex: 3),
        Spacing.smallHorizontal(),
        Text(vintage.humanReadable, overflow: TextOverflow.ellipsis).flexible(),
        // Spacing.mediumHorizontal(),
      ],
    );
  }
}
