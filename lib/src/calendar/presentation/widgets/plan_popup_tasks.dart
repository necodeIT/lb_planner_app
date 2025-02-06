import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:lb_planner/src/moodle/moodle.dart';

/// Tasks tab in the [PlanPopup].
class PlanPopupTasks extends StatefulWidget {
  /// Tasks tab in the [PlanPopup].
  const PlanPopupTasks({super.key, required this.dragWidth});

  /// The width of a task when dragging.
  final double dragWidth;

  @override
  State<PlanPopupTasks> createState() => _PlanPopupTasksState();
}

class _PlanPopupTasksState extends State<PlanPopupTasks> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  Future<void> clearPlan() async {
    final plan = context.read<CalendarPlanRepository>();

    final confirmed = await showConfirmationDialog(
      context,
      title: context.t.calendar_clearPlan_title,
      message: context.t.calendar_clearPlan_message,
    );

    if (confirmed) await plan.clear();
  }

  @override
  Widget build(BuildContext context) {
    final plan = context.watch<CalendarPlanRepository>();
    final user = context.watch<UserRepository>();

    if (!plan.state.hasData || !user.state.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredTasks = plan.getUnplannedTasks().filter(
      query: searchController.text,
      type: {
        MoodleTaskType.required,
        MoodleTaskType.participation,
        if (user.state.requireData.optionalTasksEnabled) MoodleTaskType.optional,
      },
    ).toList();

    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            hintText: context.t.calendar_searchTasks,
            prefixIcon: const Icon(Icons.search),
            fillColor: context.theme.scaffoldBackgroundColor,
            isDense: true,
            contentPadding: PaddingAll(Spacing.xsSpacing),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ).stretch(),
        Spacing.smallVertical(),
        ListView(
          children: [
            ...filteredTasks
                .map(
                  (t) {
                    return ConditionalWrapper(
                      condition: plan.canModifiy,
                      wrapper: (context, child) => Draggable<MoodleTask>(
                        data: t,
                        feedback: Material(
                          color: Colors.transparent,
                          child: Theme(
                            data: context.theme,
                            child: SizedBox(
                              width: widget.dragWidth - PlanCell.padding * 2,
                              child: child,
                            ),
                          ),
                        ),
                        childWhenDragging: const SizedBox.shrink(),
                        child: child,
                      ),
                      child: MoodleTaskWidget(
                        task: t,
                        displayMode: MoodleTaskWidgetDisplayMode.nameAndCourseAndIcon,
                      ),
                    );
                  },
                )
                .toList()
                .vSpaced(Spacing.smallSpacing),
            Spacing.mediumVertical(),
            ElevatedButton(
              onPressed: clearPlan,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.theme.colorScheme.error,
              ),
              child: Row(
                children: [
                  Text(context.t.calendar_clearPlan),
                  const Spacer(),
                  const Icon(Icons.delete),
                ],
              ),
            ),
          ],
        ).expanded(),
      ],
    );
  }
}
