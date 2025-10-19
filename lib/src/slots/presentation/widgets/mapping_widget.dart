import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';

class MappingWidget extends StatelessWidget {
  const MappingWidget({super.key, required this.course, required this.vintage});

  final MoodleCourse course;

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
