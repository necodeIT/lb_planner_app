// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'kanban_board.freezed.dart';
part 'kanban_board.g.dart';

/// Kanban board model.
@freezed
class KanbanBoard with _$KanbanBoard {
  /// Kanban board model.
  const factory KanbanBoard({
    required List<int> backlog,
    required List<int> todo,
    @JsonKey(name: 'inprogress') required List<int> inProgress,
    required List<int> done,
  }) = _KanbanBoard;

  const KanbanBoard._();

  /// Kanbanboard from json.
  factory KanbanBoard.fromJson(Map<String, Object?> json) => _$KanbanBoardFromJson(json);

  /// Creates a scaffold Kanban board with sample data.
  ///
  /// All task ids are negative to avoid conflicts with real task ids.
  factory KanbanBoard.scaffold() => const KanbanBoard(
        backlog: [-8798739812, -829, -3983, -87893],
        todo: [-8798739812, -829, -3983, -87893],
        inProgress: [-8798739812, -829, -3983, -87893],
        done: [-8798739812, -829, -3983, -87893],
      );
}

/// The columns of the Kanban board.
enum KanbanColumn {
  /// The backlog column.
  ///
  /// This is where unassigned tasks live.
  backlog,

  /// The to-do column.
  ///
  /// This is where tasks that are planned to be done live.
  todo,

  /// The in-progress column.
  ///
  /// This is where tasks that are currently being worked on live.
  inProgress,

  /// The done column.
  ///
  /// This is where completed tasks live.
  done,
}
