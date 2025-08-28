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
}

enum KanbanColumn {
  backlog,
  todo,
  inProgress,
  done,
}
