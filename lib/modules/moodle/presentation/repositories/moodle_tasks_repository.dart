import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides all tasks from Moodle with the latest updates.
class MoodleTasksRepository extends Repository<AsyncValue<List<MoodleTask>>> {
  final MoodleTaskDatasource _tasks;
  final AuthRepository _auth;
  final Ticks _ticks;

  final MoodleCoursesRepository _courses;

  /// Provides all tasks from Moodle with the latest updates.
  MoodleTasksRepository(this._tasks, this._auth, this._ticks, this._courses) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watchAsync(_courses);
    watch(_ticks);
  }

  @override
  Future<void> build(Type trigger) async {
    final tokens = _auth.state.requireData;

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

    final tasks = state.requireData;

    return tasks.where((task) {
      if (courseId != null && task.courseId != courseId) return false;
      if (taskId != null && task.id != taskId) return false;

      if (task.deadline != null) {
        if (deadlineDiff != null && task.deadline!.difference(DateTime.now()) == deadlineDiff) return false;
        if (minDeadlineDiff != null && task.deadline!.difference(DateTime.now()) < minDeadlineDiff) return false;
        if (maxDeadlineDiff != null && task.deadline!.difference(DateTime.now()) > maxDeadlineDiff) return false;
      }

      if (status.isNotEmpty && !status.contains(task.status)) return false;
      if (type.isNotEmpty && !type.contains(task.type)) return false;
      if (query != null && !task.name.toLowerCase().contains(query.toLowerCase())) return false;
      if (courseIds != null && !courseIds.contains(task.courseId)) return false;
      if (taskIds != null && !taskIds.contains(task.id)) return false;

      return true;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _tasks.dispose();
  }
}
