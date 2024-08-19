import 'package:lb_planner/modules/moodle/moodle.dart';

/// Standard implementation of [MoodleCourseDatasource].
class StdMoodleTaskDatasource extends MoodleTaskDatasource {
  final ApiService _apiService;

  @override
  void dispose() {
    _apiService.dispose();
  }

  /// Standard implementation of [MoodleCourseDatasource].
  StdMoodleTaskDatasource(this._apiService);

  @override
  Future<MoodleTask> getTask(String token, int id) async {
    log('Fetching task with id $id');

    try {
      final response = await _apiService.callFunction(
        token: token,
        function: 'local_lbplanner_modules_get_module',
        body: {
          'moduleid': id,
        },
      );

      response.assertJson();

      log('Fetched task with id $id');

      return MoodleTask.fromJson(response.asJson);
    } catch (e, s) {
      log('Failed to fetch task with id $id', e, s);
      rethrow;
    }
  }

  @override
  Future<List<MoodleTask>> getTasks(String token, {int? courseId}) async {
    final all = courseId == null;

    log(all ? 'Fetching all tasks' : 'Fetching tasks for course with id $courseId');

    try {
      final response = await _apiService.callFunction(
        token: token,
        function: all ? 'local_lbplanner_modules_get_all_modules' : 'local_lbplanner_modules_get_all_course_modules',
        body: {
          'courseid': courseId,
        },
      );

      response.assertJson();

      log('Fetched ${response.asList.length} tasks');

      return response.asList.map(MoodleTask.fromJson).toList();
    } catch (e, s) {
      log(all ? 'Failed to fetch all tasks' : 'Failed to fetch tasks for course with id $courseId', e, s);
      rethrow;
    }
  }
}
