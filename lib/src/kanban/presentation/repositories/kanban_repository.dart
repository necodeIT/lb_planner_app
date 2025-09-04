import 'dart:async';

import 'package:eduplanner/eduplanner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Repository for managing the Kanban board.
class KanbanRepository extends Repository<AsyncValue<KanbanBoard>> with Tracable {
  final KanbanDatasource _datasource;
  final AuthRepository _auth;
  final MoodleTasksRepository _tasks;

  /// Repository for managing the Kanban board.
  KanbanRepository(this._datasource, this._auth, this._tasks) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watchAsync(_tasks);

    _datasource.parent = this;
  }

  @override
  FutureOr<void> build(Trigger trigger) async {
    final token = waitForData(_auth).pick(Webservice.lb_planner_api);
    final tasks = waitForData(_tasks).map((e) => e.cmid).toList();

    log('Loading kanban board with ${tasks.length} backlog candidates');

    final transaction = startTransaction('loadKanbanBoard');

    try {
      final board = await _datasource.getBoard(token, backlogCandidates: tasks);

      data(board);
      log('Kanban board loaded');
    } catch (e, s) {
      log('Error loading kanban board', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Moves the given [taskId] to the specified [to] column.
  Future<void> move({required int taskId, required KanbanColumn to, ISentrySpan? span}) async {
    if (!state.hasData) {
      log('Cannot move task: No board data available');
      return;
    }

    final transaction = span?.startChild('moveKanbanTask') ?? startTransaction('moveKanbanTask');

    final token = _auth.state.requireData.pick(Webservice.lb_planner_api);

    try {
      final old = state.requireData;

      var _board = old.copyWith(
        backlog: old.backlog.where((id) => id != taskId).toList(),
        todo: old.todo.where((id) => id != taskId).toList(),
        inProgress: old.inProgress.where((id) => id != taskId).toList(),
        done: old.done.where((id) => id != taskId).toList(),
      );
      switch (to) {
        case KanbanColumn.backlog:
          _board = _board.copyWith(backlog: [..._board.backlog, taskId]);
          break;
        case KanbanColumn.todo:
          _board = _board.copyWith(todo: [..._board.todo, taskId]);
          break;
        case KanbanColumn.inprogress:
          _board = _board.copyWith(inProgress: [..._board.inProgress, taskId]);
          break;
        case KanbanColumn.done:
          _board = _board.copyWith(done: [..._board.done, taskId]);
          break;
      }

      data(_board);

      log('Moving task $taskId to $to');

      await _datasource.move(
        token,
        taskId: taskId,
        to: to,
      );

      log('Task $taskId moved to $to');

      await captureEvent(
        'kanban_task_moved',
        properties: {
          'taskId': taskId,
          'to': to.name,
        },
      );

      await refresh(this);
    } catch (e, st) {
      transaction.internalError(e);
      log('Error moving task', e, st);
    } finally {
      await transaction.commit();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _datasource.dispose();
  }
}
