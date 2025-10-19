import 'dart:async';

import 'package:eduplanner/eduplanner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Repository for managing the Kanban board.
class KanbanRepository extends Repository<AsyncValue<KanbanBoard>> with Tracable {
  final KanbanDatasource _datasource;
  final AuthRepository _auth;
  final MoodleTasksRepository _tasks;
  final UserRepository _user;

  /// Repository for managing the Kanban board.
  KanbanRepository(this._datasource, this._auth, this._tasks, this._user) : super(AsyncValue.loading()) {
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

      error(e, s);
    } finally {
      await transaction.commit();
    }

    if (trigger is! _AutoMoveTrigger) {
      await autoMove();
    }
  }

  /// Moves the given [taskId] to the specified [to] column.
  Future<void> move({required int taskId, required KanbanColumn to, ISentrySpan? span, bool skipAnalytics = false, Trigger? trigger}) async {
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

      if (!skipAnalytics) {
        await captureEvent(
          'kanban_task_moved',
          properties: {
            'taskId': taskId,
            'to': to.name,
          },
        );
      }

      await refresh(trigger ?? this);
    } catch (e, st) {
      transaction.internalError(e);
      log('Error moving task', e, st);
    } finally {
      await transaction.commit();
    }
  }

  /// Automatically moves tasks based on user settings.
  Future<void> autoMove() async {
    if (_user.state.data == null) {
      log('Cannot auto-move tasks: No user data available');
      return;
    }

    if (!state.hasData) {
      log('Cannot auto-move tasks: No board data available');
      return;
    }

    log('Auto-moving tasks based on user settings');

    final settings = _user.state.data!;
    final board = state.requireData;

    final mapping = {
      MoodleTaskStatus.uploaded: settings.autoMoveSubmittedTasksTo,
      MoodleTaskStatus.late: settings.autoMoveOverdueTasksTo,
      MoodleTaskStatus.done: settings.autoMoveCompletedTasksTo,
    };

    final span = startTransaction('autoMoveTasks');

    await Future.wait([
      _autoMove(from: KanbanColumn.backlog, tasks: board.backlog, to: mapping, span: span),
      _autoMove(from: KanbanColumn.todo, tasks: board.todo, to: mapping, span: span),
      _autoMove(from: KanbanColumn.inprogress, tasks: board.inProgress, to: mapping, span: span),
      _autoMove(from: KanbanColumn.done, tasks: board.done, to: mapping, span: span),
    ]);
  }

  Future<void> _autoMove({
    required KanbanColumn from,
    required List<int> tasks,
    required Map<MoodleTaskStatus, KanbanColumn?> to,
    required ISentrySpan span,
  }) async {
    if (tasks.isEmpty) return;

    final transaction = span.startChild('autoMoveFrom${from.name}');

    log('Auto-moving tasks from $from: ${tasks.length} candidates');

    try {
      await Future.wait(
        tasks.map(
          (id) async {
            final status = _tasks.getByCmid(id)?.status;

            if (status == null) return;

            final target = to[status];

            if (target == null) return;

            log('Auto-moving task $id from $from to $target due to status $status');

            return move(
              taskId: id,
              to: target,
              skipAnalytics: true,
              span: transaction.startChild('autoMoveTask'),
              trigger: _AutoMoveTrigger(),
            );
          },
        ),
      );

      log('Auto-moving tasks from $from completed');
    } catch (e, s) {
      transaction.internalError(e);
      log('Error auto-moving tasks from $from', e, s);
    } finally {
      await transaction.finish();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _datasource.dispose();
  }
}

class _AutoMoveTrigger extends Trigger {}
