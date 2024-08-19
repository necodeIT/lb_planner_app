import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Datasource for fetching task data.
abstract class MoodleTaskDatasource extends Datasource {
  @override
  String get name => 'MoodleTask';

  /// Fetches all tasks.
  ///
  /// If [courseId] is provided, only tasks for that course are fetched.
  Future<List<MoodleTask>> getTasks(String token, {int? courseId});

  /// Gets a single task by its [id].
  Future<MoodleTask> getTask(String token, int id);
}
