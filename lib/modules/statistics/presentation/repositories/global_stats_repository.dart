import 'dart:async';

import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/statistics/statistics.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Repository responsible for providing global statistics for all tasks.
class GlobalStatsRepository extends Repository<AsyncValue<TaskAggregate>> {
  final MoodleTasksRepository _tasks;

  /// Repository responsible for providing global statistics for all tasks.
  GlobalStatsRepository(this._tasks) : super(AsyncValue.loading()) {
    watchAsync(_tasks);
  }

  @override
  FutureOr<void> build(Type trigger) async {
    if (!_tasks.state.hasData) return;

    data(
      TaskAggregate.fromTasks(
        _tasks.state.requireData,
      ),
    );
  }
}
