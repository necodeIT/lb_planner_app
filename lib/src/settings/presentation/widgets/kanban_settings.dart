import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/kanban/kanban.dart';
import 'package:eduplanner/src/settings/presentation/widgets/generic_settings.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:eduplanner/src/settings/settings.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class KanbanSettings extends StatelessWidget {
  const KanbanSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();
    final settings = user.state.data;

    String translateColumn(KanbanColumn? column) {
      switch (column) {
        case KanbanColumn.backlog:
          return 'Backlog';
        case KanbanColumn.todo:
          return 'Todo';
        case KanbanColumn.inprogress:
          return 'In Progress';
        case KanbanColumn.done:
          return 'Done';
        case null:
          return 'Disabled';
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
          name: 'Move Submitted Tasks',
          value: settings?.autoMoveSubmittedTasksTo,
          onChanged: user.setAutoMoveSubmittedTasksTo,
        ),
        autoMoveItem(
          name: 'Move Overdue Tasks',
          value: settings?.autoMoveOverdueTasksTo,
          onChanged: user.setAutoMoveOverdueTasksTo,
        ),
        autoMoveItem(
          name: 'Move Completed Tasks',
          value: settings?.autoMoveCompletedTasksTo,
          onChanged: user.setAutoMoveCompletedTasksTo,
        ),
        BooleanSettingsItem(
          name: 'Column Colors',
          value: settings?.showColumnColors ?? true,
          onChanged: user.setShowColumnColors,
        ),
      ],
    );
  }
}
