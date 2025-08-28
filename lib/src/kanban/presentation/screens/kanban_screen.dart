import 'dart:js_interop';

import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:eduplanner/src/kanban/kanban.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class KanbanScreen extends StatelessWidget {
  const KanbanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<KanbanRepository>();

    final board = repo.state.data ?? KanbanBoard.scaffold();

    return Padding(
      padding: PaddingAll(),
      child: Row(
        children: [
          KanbanColumnWidget(
            name: 'Backlog',
            tasks: board.backlog,
            color: context.theme.taskStatusTheme.pendingColor,
            column: KanbanColumn.backlog,
          ).expanded(),
          Spacing.mediumHorizontal(),
          KanbanColumnWidget(
            name: 'To Do',
            tasks: board.todo,
            color: context.theme.colorScheme.primary,
            column: KanbanColumn.todo,
          ).expanded(),
          Spacing.mediumHorizontal(),
          KanbanColumnWidget(
            name: 'In Progress',
            tasks: board.inProgress,
            column: KanbanColumn.inProgress,
            color: context.theme.taskStatusTheme.uploadedColor,
          ),
          Spacing.mediumHorizontal(),
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
