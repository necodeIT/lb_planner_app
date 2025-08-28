import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// A column within the Kanban board.
class KanbanColumnWidget extends StatefulWidget {
  /// A column within the Kanban board.
  const KanbanColumnWidget({super.key, required this.tasks, this.backgroundColor});

  /// The tasks assigned to this column.
  final List<int> tasks;

  /// The background color of this column.
  final Color? backgroundColor;

  @override
  State<KanbanColumnWidget> createState() => _KanbanColumnWidgetState();
}

class _KanbanColumnWidgetState extends State<KanbanColumnWidget> {
  @override
  Widget build(BuildContext context) {
    final tasksRepo = context.watch<MoodleTasksRepository>();

    final tasks = tasksRepo.filter(taskIds: widget.tasks.toSet());

    return ListView.separated(
      itemBuilder: (context, index) {
        final task = tasks[index];
        return KanbanCard(task: task);
      },
      separatorBuilder: (context, index) => Spacing.smallVertical(),
      itemCount: tasks.length,
    );
  }
}
