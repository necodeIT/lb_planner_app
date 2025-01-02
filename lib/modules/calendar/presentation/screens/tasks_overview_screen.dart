import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Displays the monthly distribution of tasks.
class TasksOverviewScreen extends StatefulWidget {
  /// Displays the monthly distribution of tasks.
  const TasksOverviewScreen({super.key});

  @override
  State<TasksOverviewScreen> createState() => _TasksOverviewScreenState();
}

class _TasksOverviewScreenState extends State<TasksOverviewScreen> {
  final winterKey = GlobalKey();

  final summerKey = GlobalKey();

  final scrollController = ScrollController();

  // A list of months which are in the winter (the first) semester of school.
  static const winterMonths = [DateTime.september, DateTime.october, DateTime.november, DateTime.december, DateTime.january, DateTime.february];

  /// A list of months which are in the summer (the second) semester of school.
  static const summerMonths = [DateTime.february, DateTime.march, DateTime.april, DateTime.may, DateTime.june, DateTime.july];

  void scrollToSummer() {
    if (summerMonths.contains(DateTime.now().month)) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(
        summerKey.currentContext!,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final enabledCourses = context.watch<MoodleCoursesRepository>().filter(enabled: true);

    return ClipPath(
      clipper: ShapeBorderClipper(shape: squircle(topLeft: false, topRight: false)),
      child: CustomScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        slivers: [
          SliverStickyHeader(
            key: winterKey,
            header: const CalendarTasksOverviewMonthHeader(months: winterMonths),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  for (final course in enabledCourses) CalendarCourseTasksOverview(course: course, months: winterMonths),
                ],
              ),
            ),
          ),
          SliverStickyHeader(
            key: summerKey,
            header: const CalendarTasksOverviewMonthHeader(months: summerMonths),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  for (final course in enabledCourses) CalendarCourseTasksOverview(course: course, months: summerMonths),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
