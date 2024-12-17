import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A cell in the plan grid.
class PlanCell extends StatefulWidget {
  /// A cell in the plan grid.
  const PlanCell({super.key, required this.date, required this.currentMonth});

  /// The date of the cell.
  final DateTime date;

  /// The current month displayed in the grid.
  final DateTime currentMonth;

  /// The padding of the cell.
  static double get padding => Spacing.xsSpacing;

  @override
  State<PlanCell> createState() => _PlanCellState();
}

class _PlanCellState extends State<PlanCell> {
  Future<void> addDeadline(MoodleTask task) => context.read<CalendarPlanRepository>().setDeadline(
        task.id,
        widget.date,
        widget.date,
      );

  @override
  Widget build(BuildContext context) {
    final isCurrentMonth = widget.date.month == widget.currentMonth.month;

    final plan = context.watch<CalendarPlanRepository>();
    final allTasks = context.watch<MoodleTasksRepository>();
    final user = context.watch<UserRepository>();

    final deadlines = plan.filterDeadlines(start: widget.date, end: widget.date);
    final tasks = allTasks.filter(taskIds: deadlines.map((e) => e.id).toSet());

    return DragTarget<MoodleTask>(
      onMove: (details) => true,
      onWillAcceptWithDetails: (details) => !tasks.contains(details.data),
      onAcceptWithDetails: (details) => addDeadline(details.data),
      builder: (context, draggedTasks, _) {
        return Container(
          padding: PaddingAll(PlanCell.padding),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: context.theme.dividerColor,
              ),
            ),
            color: widget.date.isToday
                ? context.theme.colorScheme.primary.withOpacity(0.2)
                : isCurrentMonth
                    ? null
                    : context.theme.disabledColor.withOpacity(
                        context.theme.brightness == Brightness.dark ? .00625 : 0.025,
                      ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  if (user.state.data?.displayTaskCount ?? false) Text('${tasks.length} Tasks').fontSize(12).color(context.theme.disabledColor),
                  const Spacer(),
                  Text(
                    widget.date.day.toString(),
                    style: TextStyle(
                      color: isCurrentMonth ? context.theme.textTheme.bodyMedium?.color : context.theme.disabledColor,
                    ),
                  ),
                ],
              ),
              Spacing.xsVertical(),
              ListView(
                children: [
                  ...draggedTasks
                      .whereType<MoodleTask>()
                      .map(
                        (t) => Skeletonizer(
                          child: MoodleTaskWidget(task: t, displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndIcon),
                        ),
                      )
                      .toList()
                      .vSpaced(Spacing.smallSpacing),
                  if (draggedTasks.isNotEmpty) Spacing.smallVertical(),
                  ...tasks
                      .map(
                        (t) => LayoutBuilder(
                          builder: (context, size) {
                            final widget = MoodleTaskWidget(
                              task: t,
                              displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndIcon,
                              additionalContextMenuItems: [
                                ContextMenuButtonConfig(
                                  'Remove deadline',
                                  icon: const Icon(Icons.delete),
                                  iconHover: Icon(
                                    Icons.delete,
                                    color: context.theme.colorScheme.error,
                                  ),
                                  onPressed: () => plan.removeDeadline(t.id),
                                ),
                              ],
                            );
                            return Draggable(
                              data: t,
                              feedback: SizedBox(
                                width: size.maxWidth - PlanCell.padding * 2,
                                child: widget,
                              ),
                              childWhenDragging: const SizedBox.shrink(),
                              child: widget,
                            );
                          },
                        ),
                      )
                      .toList()
                      .vSpaced(Spacing.smallSpacing),
                ],
              ).expanded(),
            ],
          ),
        );
      },
    );
  }
}
