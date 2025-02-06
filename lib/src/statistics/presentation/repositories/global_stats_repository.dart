import 'dart:async';

import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/statistics/statistics.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Repository responsible for providing global statistics for all tasks.
class GlobalStatsRepository extends Repository<AsyncValue<TaskAggregate>> {
  final MoodleTasksRepository _tasks;
  final UserRepository _user;

  /// Repository responsible for providing global statistics for all tasks.
  GlobalStatsRepository(this._tasks, this._user) : super(AsyncValue.loading()) {
    watchAsync(_tasks);
    watchAsync(_user);
  }

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    if (!_tasks.state.hasData) return;

    final user = waitForData(_user);

    data(
      TaskAggregate.fromTasks(
        _tasks.filter(
          type: {
            MoodleTaskType.required,
            MoodleTaskType.participation,
            if (user.optionalTasksEnabled) MoodleTaskType.optional,
          },
        ),
      ),
    );
  }
}
