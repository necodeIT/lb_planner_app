import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides all tasks from Moodle with the latest updates.
class MoodleTasksRepository extends Repository<AsyncValue<List<MoodleTask>>> {
  final MoodleTaskDatasource _tasks;
  final AuthRepository _auth;

  final MoodleCoursesRepository _courses;

  /// Provides all tasks from Moodle with the latest updates.
  MoodleTasksRepository(this._tasks, this._auth, this._courses) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watchAsync(_courses);
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  @override
  Future<void> build(Type trigger) async {
    final tokens = waitForData(_auth);

    await guard(() => _tasks.getTasks(tokens[Webservice.lb_planner_api]));
  }

  /// Filters all [MoodleTask]s based on the provided criteria.
  ///
  /// Returns a list of tasks that match all the specified filters. If no filters
  /// are provided, all tasks are returned.
  ///
  /// The available filters are:
  ///
  /// - [query]: A substring that must be present in the task's name (case-insensitive).
  /// - [courseId]: The course ID that the task must belong to.
  /// - [deadlineDiff]: The exact difference between the task's deadline and the current time.
  /// - [minDeadlineDiff]: The minimum allowed difference between the task's deadline and the current time.
  /// - [maxDeadlineDiff]: The maximum allowed difference between the task's deadline and the current time.
  /// - [status]: A set of acceptable task statuses. If provided, the task's status must be one of these.
  /// - [type]: A set of acceptable task types. If provided, the task's type must be one of these.
  ///
  /// If [state] does not contain data, an empty list is returned.
  List<MoodleTask> filter({
    String? query,
    int? courseId,
    Set<int>? courseIds,
    int? taskId,
    Set<int>? taskIds,
    Duration? deadlineDiff,
    Duration? minDeadlineDiff,
    Duration? maxDeadlineDiff,
    Set<MoodleTaskStatus> status = const {},
    Set<MoodleTaskType> type = const {},
  }) {
    if (!state.hasData) return [];

    return state.requireData.filter(
      query: query,
      courseId: courseId,
      courseIds: courseIds,
      taskId: taskId,
      taskIds: taskIds,
      deadlineDiff: deadlineDiff,
      minDeadlineDiff: minDeadlineDiff,
      maxDeadlineDiff: maxDeadlineDiff,
      status: status,
      type: type,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _tasks.dispose();
  }
}

/// Extension methods for filtering tasks.
extension TasksFilterX on Iterable<MoodleTask> {
  /// Filters all [MoodleTask]s based on the provided criteria.
  ///
  /// Returns a list of tasks that match all the specified filters. If no filters
  /// are provided, all tasks are returned.
  ///
  /// The available filters are:
  ///
  /// - [query]: A substring that must be present in the task's name (case-insensitive).
  /// - [courseId]: The course ID that the task must belong to.
  /// - [deadlineDiff]: The exact difference between the task's deadline and the current time.
  /// - [minDeadlineDiff]: The minimum allowed difference between the task's deadline and the current time.
  /// - [maxDeadlineDiff]: The maximum allowed difference between the task's deadline and the current time.
  /// - [status]: A set of acceptable task statuses. If provided, the task's status must be one of these.
  /// - [type]: A set of acceptable task types. If provided, the task's type must be one of these.
  ///
  List<MoodleTask> filter({
    String? query,
    int? courseId,
    Set<int>? courseIds,
    int? taskId,
    Set<int>? taskIds,
    Duration? deadlineDiff,
    Duration? minDeadlineDiff,
    Duration? maxDeadlineDiff,
    Set<MoodleTaskStatus> status = const {},
    Set<MoodleTaskType> type = const {},
  }) {
    final now = DateTime.now();

    return where((task) {
      if (courseId != null && task.courseId != courseId) return false;
      if (taskId != null && task.id != taskId) return false;

      if (task.deadline == null && (deadlineDiff != null || minDeadlineDiff != null || maxDeadlineDiff != null)) return false;

      if (task.deadline != null) {
        if (deadlineDiff != null && task.deadline!.difference(now) != deadlineDiff) return false;
        if (minDeadlineDiff != null && task.deadline!.difference(now) < minDeadlineDiff) return false;
        if (maxDeadlineDiff != null && task.deadline!.difference(now) > maxDeadlineDiff) return false;
      }

      if (status.isNotEmpty && !status.contains(task.status)) return false;
      if (type.isNotEmpty && !type.contains(task.type)) return false;
      if (query != null && !task.name.toLowerCase().contains(query.toLowerCase())) return false;
      if (courseIds != null && !courseIds.contains(task.courseId)) return false;
      if (taskIds != null && !taskIds.contains(task.id)) return false;

      return true;
    }).toList();
  }
}
