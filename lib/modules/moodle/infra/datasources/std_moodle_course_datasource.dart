import 'package:lb_planner/modules/moodle/moodle.dart';

/// Standard implementation of [MoodleCourseDatasource].
class StdMoodleCourseDatasource extends MoodleCourseDatasource {
  final ApiService _apiService;

  /// Standard implementation of [MoodleCourseDatasource].
  StdMoodleCourseDatasource(this._apiService);

  @override
  void dispose() {}

  @override
  Future<List<MoodleCourse>> getCourses(String token) async {
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
      rethrow;
    }
  }

  @override
  Future<MoodleCourse> updateCourse(String token, MoodleCourse course) async {
    try {
      await _apiService.callFunction(
        token: token,
        function: 'local_lbplanner_courses_update_course',
        body: course.toJson()..remove('name'),
      );

      return course;
    } catch (e, s) {
      log('Failed to update course', e, s);
      rethrow;
    }
  }
}
