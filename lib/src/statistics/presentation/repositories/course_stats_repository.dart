import 'dart:async';

import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Repository responsible for providing statistics on a per-course basis.
///
/// The [state] is a Map of course IDs to their respective statistics.
class CourseStatsRepository extends Repository<AsyncValue<Map<int, TaskAggregate>>> with Tracable {
  final MoodleCoursesRepository _courses;
  final MoodleTasksRepository _tasks;

  /// Repository responsible for providing statistics on a per-course basis.
  ///
  /// The [state] is a Map of course IDs to their respective statistics.
  CourseStatsRepository(this._courses, this._tasks) : super(AsyncValue.loading()) {
    watchAsync(_courses);
    watchAsync(_tasks);
  }

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    if (!_courses.state.hasData || !_tasks.state.hasData) return;

    final transaction = startTransaction('loadCourseStats');

    try {
      final courses = _courses.state.requireData;
      final tasks = _tasks.state.requireData;

      data(
        Map.fromEntries(
          courses.map(
            (course) => MapEntry(
              course.id,
              TaskAggregate.fromTasks(
                tasks.where((task) => task.courseId == course.id),
              ),
            ),
          ),
        ),
      );
    } catch (e, s) {
      log('Failed to load statistics.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Returns the statistics for the course with the given [courseId].
  TaskAggregate? getCourseStats(int courseId) => state.data?[courseId];
}
