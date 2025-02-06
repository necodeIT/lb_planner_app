import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';

/// Cell for the modules overview.
class CalendarTasksOverviewCell extends StatelessWidget {
  /// Cell for the modules overview.
  const CalendarTasksOverviewCell({Key? key, required this.tasks}) : super(key: key);

  /// The modules to display.
  final List<MoodleTask> tasks;

  /// The width of the cell.
  static const width = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingAll(Spacing.xsSpacing),
      width: width,
      height: width,
      decoration: BoxDecoration(
        border: Border.all(
          color: context.theme.dividerColor,
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          if (tasks.isNotEmpty)
            Align(
              alignment: Alignment.topRight,
              child: Text(tasks.length.toString()),
            ),
          if (tasks.isNotEmpty) Spacing.xsVertical(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (final task in tasks)
                    MoodleTaskWidget(
                      task: task,
                      displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndCheckmark,
                    ),
                ].vSpaced(Spacing.xsSpacing).show(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
