import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Shows all kanban columns and their tasks.
class KanbanScreen extends StatefulWidget {
  /// Shows all kanban columns and their tasks.
  const KanbanScreen({super.key});

  @override
  State<KanbanScreen> createState() => _KanbanScreenState();
}

class _KanbanScreenState extends State<KanbanScreen> with AdaptiveState, NoMobile {
  final animationDuration = 300.ms;

  bool showBacklog = false;

  void toggleBacklog() {
    setState(() {
      showBacklog = !showBacklog;
    });
  }

  @override
  Widget buildDesktop(BuildContext context) {
    final repo = context.watch<KanbanRepository>();

    final board = repo.state.data ?? KanbanBoard.scaffold();

    return Padding(
      padding: PaddingAll(),
      child: Row(
        spacing: Spacing.smallSpacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: toggleBacklog,
              child: showBacklog
                  ? const Icon(Icons.folder)
                  : const Icon(
                      Icons.folder_open,
                    ),
            ),
          ),
          if (showBacklog)
            KanbanColumnWidget(
              name: 'Backlog',
              tasks: board.backlog,
              color: context.theme.taskStatusTheme.pendingColor,
              column: KanbanColumn.backlog,
            ),
          KanbanColumnWidget(
            name: 'To Do',
            tasks: board.todo,
            color: context.theme.colorScheme.primary,
            column: KanbanColumn.todo,
          ).expanded(),
          KanbanColumnWidget(
            name: 'In Progress',
            tasks: board.inProgress,
            column: KanbanColumn.inprogress,
            color: context.theme.taskStatusTheme.uploadedColor,
          ).expanded(),
          KanbanColumnWidget(
            name: 'Done',
            tasks: board.done,
            column: KanbanColumn.done,
            color: context.theme.taskStatusTheme.doneColor,
          ).expanded(),
        ],
      ).expanded(),
    );
  }
}
