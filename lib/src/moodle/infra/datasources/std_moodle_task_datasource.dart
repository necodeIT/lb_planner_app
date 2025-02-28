import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';

/// Standard implementation of [MoodleCourseDatasource].
class StdMoodleTaskDatasource extends MoodleTaskDatasource {
  final ApiService _apiService;

  @override
  void dispose() {
    super.dispose();
    _apiService.dispose();
  }

  /// Standard implementation of [MoodleCourseDatasource].
  StdMoodleTaskDatasource(this._apiService) {
    _apiService.parent = this;
  }

  @override
  Future<MoodleTask> getTask(String token, int id) async {
    final transaction = startTransaction('getTask');

    log('Fetching task with id $id');

    try {
      final response = await _apiService.callFunction(
        token: token,
        function: 'local_lbplanner_modules_get_module',
        body: {
          'moduleid': id,
          'ekenabled': 1,
        },
      );

      response.assertJson();

      log('Fetched task with id $id');

      return MoodleTask.fromJson(response.asJson);
    } catch (e, s) {
      log('Failed to fetch task with id $id', e, s);
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<List<MoodleTask>> getTasks(String token, {int? courseId}) async {
    final transaction = startTransaction('getTasks');

    final all = courseId == null;

    log(all ? 'Fetching all tasks' : 'Fetching tasks for course with id $courseId');

    try {
      final response = await _apiService.callFunction(
        token: token,
        function: all ? 'local_lbplanner_modules_get_all_modules' : 'local_lbplanner_modules_get_all_course_modules',
        body: {
          'courseid': courseId,
          'ekenabled': 1,
        },
      );

      response.assertList();

      log('Fetched ${response.asList.length} tasks');

      return response.asList.map(MoodleTask.fromJson).toList();
    } catch (e, s) {
      log(all ? 'Failed to fetch all tasks' : 'Failed to fetch tasks for course with id $courseId', e, s);
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }
}
