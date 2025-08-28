import 'package:eduplanner/eduplanner.dart';

/// Implementation of [KanbanDatasource] for local development using a static [KanbanBoard].
///
/// **DO NOT USE IN PROD** This is just for development of the UI until the backend is ready.
class LocalKanbanDatasource extends KanbanDatasource {
  static KanbanBoard? _board;

  /// The datasource used to synthesis the boards backlog.
  final MoodleTaskDatasource tasks;

  /// Implementation of [KanbanDatasource] for local development using a static [KanbanBoard].
  ///
  /// **DO NOT USE IN PROD** This is just for development of the UI until the backend is ready.
  LocalKanbanDatasource(this.tasks);

  @override
  Future<KanbanBoard> getBoard(String token) async {
    return _board ??= KanbanBoard(
      backlog: (await tasks.getTasks(token)).map((t) => t.id).toList(),
      todo: [],
      inProgress: [],
      done: [],
    );
  }

  @override
  Future<void> move(String token, {required int taskId, required KanbanColumn to}) async {
    if (_board == null) return;

    _board = _board!.copyWith(
      backlog: _board!.backlog.where((id) => id != taskId).toList(),
      todo: _board!.todo.where((id) => id != taskId).toList(),
      inProgress: _board!.inProgress.where((id) => id != taskId).toList(),
      done: _board!.done.where((id) => id != taskId).toList(),
    );
    switch (to) {
      case KanbanColumn.backlog:
        _board = _board!.copyWith(backlog: [..._board!.backlog, taskId]);
        break;
      case KanbanColumn.todo:
        _board = _board!.copyWith(todo: [..._board!.todo, taskId]);
        break;
      case KanbanColumn.inProgress:
        _board = _board!.copyWith(inProgress: [..._board!.inProgress, taskId]);
        break;
      case KanbanColumn.done:
        _board = _board!.copyWith(done: [..._board!.done, taskId]);
        break;
    }
  }
}
