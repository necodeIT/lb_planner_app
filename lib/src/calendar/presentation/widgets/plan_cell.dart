import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:context_menus/context_menus.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
    final tasks = allTasks.filter(
      taskIds: deadlines.map((e) => e.id).toSet(),
      type: {
        MoodleTaskType.required,
        MoodleTaskType.participation,
        if (user.state.data?.optionalTasksEnabled ?? false) MoodleTaskType.optional,
      },
    );

    final exams = allTasks.filter(
      type: {MoodleTaskType.exam},
      test: (t) => t.deadline?.isSameDate(widget.date) ?? false,
    );

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
                ? context.theme.colorScheme.primary.withAlpha(51)
                : isCurrentMonth
                    ? null
                    : context.theme.disabledColor.withAlpha(
                        context.theme.brightness == Brightness.dark ? 2 : 6,
                      ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  if (user.state.data?.displayTaskCount ?? false)
                    Text(context.t.calendar_tasksCountLabel(tasks.length)).fontSize(12).color(context.theme.disabledColor),
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
                  ...exams.map(
                    (e) => MoodleTaskWidget(
                      task: e,
                      displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndIcon,
                      highlight: true,
                    ),
                  ),
                  if (exams.isNotEmpty) Spacing.smallVertical(),
                  ...tasks
                      .map(
                        (t) => LayoutBuilder(
                          builder: (context, size) {
                            return ConditionalWrapper(
                              condition: plan.canModifiy,
                              wrapper: (context, child) => Draggable(
                                data: t,
                                feedback: SizedBox(
                                  width: size.maxWidth - PlanCell.padding * 2,
                                  child: child,
                                ),
                                childWhenDragging: const SizedBox.shrink(),
                                child: child,
                              ),
                              child: MoodleTaskWidget(
                                task: t,
                                displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndIcon,
                                additionalContextMenuItems: [
                                  ContextMenuButtonConfig(
                                    context.t.calendar_removeDeadline,
                                    icon: const Icon(Icons.delete),
                                    iconHover: Icon(
                                      Icons.delete,
                                      color: context.theme.colorScheme.error,
                                    ),
                                    onPressed: () => plan.removeDeadline(t.id),
                                  ),
                                ],
                              ),
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
