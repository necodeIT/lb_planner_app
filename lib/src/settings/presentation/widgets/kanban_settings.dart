import 'package:eduplanner/eduplanner.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/kanban/kanban.dart';
import 'package:eduplanner/src/settings/presentation/widgets/generic_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Settings ui for the kanban board
class KanbanSettings extends StatelessWidget {
  /// Settings ui for the kanban board
  const KanbanSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();
    final settings = user.state.data;

    String translateColumn(KanbanColumn? column) {
      switch (column) {
        case KanbanColumn.backlog:
          return context.t.kanban_screen_backlog;
        case KanbanColumn.todo:
          return context.t.kanban_screen_toDo;
        case KanbanColumn.inprogress:
          return context.t.kanban_screen_inProgress;
        case KanbanColumn.done:
          return context.t.kanban_screen_done;
        case null:
          return context.t.kanban_settings_disabled;
      }
    }

    GenericSettingsItem autoMoveItem({required String name, required KanbanColumn? value, required void Function(KanbanColumn?) onChanged}) {
      return EnumSettingsItem<KanbanColumn?>(
        name: name,
        value: value,
        values: [null, ...KanbanColumn.values],
        itemBuilder: (context, value) => translateColumn(value),
        onChanged: onChanged,
        dropDownWidth: 125,
      );
    }

    return GenericSettings(
      title: 'Kanban',
      items: [
        autoMoveItem(
          name: context.t.kanban_settings_moveSubmittedTasks,
          value: settings?.autoMoveSubmittedTasksTo,
          onChanged: user.setAutoMoveSubmittedTasksTo,
        ),
        autoMoveItem(
          name: context.t.kanban_settings_moveOverdueTasks,
          value: settings?.autoMoveOverdueTasksTo,
          onChanged: user.setAutoMoveOverdueTasksTo,
        ),
        autoMoveItem(
          name: context.t.kanban_settings_moveCompletedTasks,
          value: settings?.autoMoveCompletedTasksTo,
          onChanged: user.setAutoMoveCompletedTasksTo,
        ),
        BooleanSettingsItem(
          name: context.t.kanban_settings_columnColors,
          value: settings?.showColumnColors ?? true,
          onChanged: user.setShowColumnColors,
        ),
      ],
    );
  }
}
