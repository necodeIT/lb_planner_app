import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// Displays the monthly distribution of tasks.
class TasksOverviewScreen extends StatefulWidget {
  /// Displays the monthly distribution of tasks.
  const TasksOverviewScreen({super.key});

  @override
  State<TasksOverviewScreen> createState() => _TasksOverviewScreenState();
}

class _TasksOverviewScreenState extends State<TasksOverviewScreen> {
  final scrollController = ScrollController();

  // A list of months which are in the winter (the first) semester of school.
  static const winterMonths = [DateTime.september, DateTime.october, DateTime.november, DateTime.december, DateTime.january, DateTime.february];

  /// A list of months which are in the summer (the second) semester of school.
  static const summerMonths = [DateTime.february, DateTime.march, DateTime.april, DateTime.may, DateTime.june, DateTime.july];

  @override
  Widget build(BuildContext context) {
    final enabledCourses = context.watch<MoodleCoursesRepository>().filter(enabled: true);

    final isSummer = summerMonths.contains(DateTime.now().month);

    final months = isSummer ? summerMonths : winterMonths;

    return ClipPath(
      clipper: ShapeBorderClipper(shape: squircle(topLeft: false, topRight: false)),
      child: Listener(
        onPointerSignal: (PointerSignalEvent event) {
          if (event is PointerScrollEvent) {
            scrollController.animateTo(
              scrollController.offset + event.scrollDelta.dy * 30, // multiply for increased sensitivity
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeOut,
            );
          }
        },
        child: CustomScrollView(
          controller: scrollController,
          scrollDirection: Axis.horizontal,
          slivers: [
            SliverStickyHeader(
              header: CalendarTasksOverviewMonthHeader(months: months),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    for (final course in enabledCourses) CalendarCourseTasksOverview(course: course, months: months),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
