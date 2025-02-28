import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';

/// Standard implementation of [MoodleCourseDatasource].
class StdMoodleCourseDatasource extends MoodleCourseDatasource {
  final ApiService _apiService;

  /// Standard implementation of [MoodleCourseDatasource].
  StdMoodleCourseDatasource(this._apiService) {
    _apiService.parent = this;
  }

  @override
  Future<List<MoodleCourse>> getCourses(String token) async {
    final transaction = startTransaction('getCourses');

    try {
      final response = await _apiService.callFunction(
        token: token,
        function: 'local_lbplanner_courses_get_my_courses',
        body: {},
      );

      response.assertList();

      return response.asList.map(MoodleCourse.fromJson).toList();
    } catch (e, s) {
      log('Failed to fetch courses', e, s);
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<List<MoodleCourse>> getAllCourses(String token) async {
    final transaction = startTransaction('getAllCourses');

    try {
      final response = await _apiService.callFunction(
        token: token,
        function: 'local_lbplanner_courses_get_all_courses',
        body: {},
      );

      response.assertList();

      return response.asList.map(MoodleCourse.fromJson).toList();
    } catch (e, s) {
      log('Failed to fetch courses', e, s);
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<MoodleCourse> updateCourse(String token, MoodleCourse course) async {
    final transaction = startTransaction('updateCourse');

    try {
      await _apiService.callFunction(
        token: token,
        function: 'local_lbplanner_courses_update_course',
        body: course.toJson()..remove('name'),
      );

      return course;
    } catch (e, s) {
      log('Failed to update course', e, s);
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }
}
