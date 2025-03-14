import 'dart:async';

import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Repository responsible for providing global statistics for all tasks.
class GlobalStatsRepository extends Repository<AsyncValue<TaskAggregate>> with Tracable {
  final MoodleTasksRepository _tasks;
  final UserRepository _user;

  /// Repository responsible for providing global statistics for all tasks.
  GlobalStatsRepository(this._tasks, this._user) : super(AsyncValue.loading()) {
    watchAsync(_tasks);
    watchAsync(_user);
  }

  @override
  FutureOr<void> build(Trigger trigger) async {
    if (!_tasks.state.hasData) return;

    final transaction = startTransaction('loadGlobalStats');

    try {
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
    } catch (e, s) {
      log('Failed to load statistics.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }
}
