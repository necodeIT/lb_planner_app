import 'package:eduplanner/eduplanner.dart';

/// Implementation of [KanbanDatasource] using the moodle api implemented in the [backend](https://github.com/necodeIT/lb_planner_plugin/pull/73)
class MoodleKanbanDatasource extends KanbanDatasource {
  final ApiService _api;

  /// Implementation of [KanbanDatasource] using the moodle api implemented in the [backend](https://github.com/necodeIT/lb_planner_plugin/pull/73)
  MoodleKanbanDatasource(this._api) {
    _api.parent = this;
  }

  @override
  void dispose() {
    super.dispose();
    _api.dispose();
  }

  @override
  Future<KanbanBoard> getBoard(String token, {List<int> backlogCandidates = const []}) async {
    final transaction = startTransaction('getBoard');

    log('fetching kanban board');

    try {
      final data = await _api.callFunction(function: 'local_lbplanner_kanban_get_board', token: token);

      data.assertJson();

      final board = KanbanBoard.fromJson(data.asJson);

      log('kanban board fetched');

      return board.copyWith(
        backlog: backlogCandidates.where((id) => !board.all.contains(id)).toList(),
      );
    } catch (e, s) {
      transaction.internalError(e);
      log('failed to fetch kanban board', e, s);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> move(String token, {required int taskId, required KanbanColumn to}) async {
    final transaction = startTransaction('move');

    log('moving task $taskId to $to');

    try {
      await _api.callFunction(
        function: 'local_lbplanner_kanban_move_module',
        token: token,
        body: {
          'cmid': taskId,
          'column': to.name,
        },
      );

      log('task $taskId moved to $to');
    } catch (e, s) {
      transaction.internalError(e);
      log('failed to move task $taskId to $to', e, s);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }
}
