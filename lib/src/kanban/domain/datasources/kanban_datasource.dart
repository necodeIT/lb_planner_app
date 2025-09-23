import 'package:eduplanner/eduplanner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Datasource for the Kanban board feature.
abstract class KanbanDatasource extends Datasource with Tracable {
  @override
  String get name => 'Kanban';

  /// Fetches the Kanban board for the user associated with the given [token].
  ///
  /// Optionally, a list of [backlogCandidates] can be provided to suggest tasks that might belong in the backlog.
  /// These will be filtered to exclude tasks already present in other columns.
  ///
  /// **Note:** [KanbanBoard.backlog] will be empty if [backlogCandidates] is not provided as the backend does not store backlog tasks.
  Future<KanbanBoard> getBoard(String token, {List<int> backlogCandidates = const []});

  /// Moves the given [taskId] to the specified [to] column for the user associated with the given [token].
  Future<void> move(String token, {required int taskId, required KanbanColumn to});
}
