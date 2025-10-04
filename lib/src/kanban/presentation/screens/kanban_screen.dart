import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:data_widget/data_widget.dart';
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
  void didChangeDependencies() {
    super.didChangeDependencies();

    Data.of<TitleBarState>(context).setTrailingWidget(
      _BacklogToggle(
        initialValue: showBacklog,
        onChanged: (value) {
          setState(() {
            showBacklog = value;
          });
        },
      ),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    final repo = context.watch<KanbanRepository>();
    final user = context.watch<UserRepository>();

    final board = repo.state.data ?? KanbanBoard.scaffold();

    Color? applyColor(Color color) {
      if (!(user.state.data?.showColumnColors ?? true)) return null;

      return color;
    }

    return Padding(
      padding: PaddingAll(),
      child: Row(
        spacing: Spacing.smallSpacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBacklog)
            KanbanColumnWidget(
              name: context.t.kanban_screen_backlog,
              tasks: board.backlog,
              color: applyColor(context.theme.taskStatusTheme.pendingColor),
              column: KanbanColumn.backlog,
            ).expanded(),
          KanbanColumnWidget(
            name: context.t.kanban_screen_toDo,
            tasks: board.todo,
            color: applyColor(context.theme.colorScheme.primary),
            column: KanbanColumn.todo,
          ).expanded(),
          KanbanColumnWidget(
            name: context.t.kanban_screen_inProgress,
            tasks: board.inProgress,
            column: KanbanColumn.inprogress,
            color: applyColor(context.theme.taskStatusTheme.uploadedColor),
          ).expanded(),
          KanbanColumnWidget(
            name: context.t.kanban_screen_done,
            tasks: board.done,
            column: KanbanColumn.done,
            color: applyColor(context.theme.taskStatusTheme.doneColor),
          ).expanded(),
        ],
      ),
    );
  }
}

class _BacklogToggle extends StatefulWidget {
  const _BacklogToggle({super.key, this.onChanged, required this.initialValue});

  // ignore: avoid_positional_boolean_parameters
  final Function(bool value)? onChanged;

  final bool initialValue;

  @override
  State<_BacklogToggle> createState() => __BacklogToggleState();
}

class __BacklogToggleState extends State<_BacklogToggle> {
  late bool showBacklog = widget.initialValue;

  void toggleBacklog() {
    setState(() {
      showBacklog = !showBacklog;
      widget.onChanged?.call(showBacklog);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: toggleBacklog,
      child: Text(showBacklog ? context.t.kanban_screen_hideBacklog : context.t.kanban_screen_showBacklog),
    );
  }
}
