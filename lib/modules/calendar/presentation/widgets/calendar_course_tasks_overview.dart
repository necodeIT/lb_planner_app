import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';

/// Modules overview of a course.
class CalendarCourseTasksOverview extends StatelessWidget {
  /// Modules overview of a course.
  const CalendarCourseTasksOverview({Key? key, required this.course, required this.months}) : super(key: key);

  /// The id of the course to display.
  final MoodleCourse course;

  /// The months to display.
  final List<int> months;

  /// The height of the course label.
  static const courseHeight = 25.0;

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>().filter(courseId: course.id);

    return Column(
      children: [
        Container(
          color: course.color,
          height: courseHeight,
          width: CalendarTasksOverviewCell.width,
          child: Center(
            child: Text(
              course.shortname,
              style: TextStyle(
                color: context.theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              for (final month in months)
                Expanded(
                  child: CalendarTasksOverviewCell(
                    tasks: tasks.where((t) => t.deadline?.month == month).toList(),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
