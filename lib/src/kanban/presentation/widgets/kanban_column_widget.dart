import 'package:awesome_extensions/awesome_extensions_flutter.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A column within the Kanban board.
class KanbanColumnWidget extends StatefulWidget {
  /// A column within the Kanban board.
  const KanbanColumnWidget({super.key, required this.tasks, this.color, required this.name, required this.column});

  /// The tasks assigned to this column.
  final List<int> tasks;

  /// The color of this column.
  final Color? color;

  /// The name of this column.
  final String name;

  /// The type of column.
  final KanbanColumn column;

  @override
  State<KanbanColumnWidget> createState() => _KanbanColumnWidgetState();
}

class _KanbanColumnWidgetState extends State<KanbanColumnWidget> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final tasksRepo = context.watch<MoodleTasksRepository>();
    final board = context.read<KanbanRepository>();

    return DragTarget<MoodleTask>(
      onWillAcceptWithDetails: (details) => !widget.tasks.contains(details.data.cmid),
      onAcceptWithDetails: (d) => board.move(taskId: d.data.cmid, to: widget.column),
      builder: (context, candiates, _) {
        final tasks = tasksRepo.filter(cmids: widget.tasks.toSet(), query: searchController.text);

        final tasksWithDropCandidates = [...candiates.nonNulls, ...tasks];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.name} (${tasksWithDropCandidates.length})',
              style: context.theme.textTheme.titleLarge,
            ),
            Spacing.largeVertical(),
            TextField(
              controller: searchController,
              style: context.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: context.t.global_search,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: context.theme.colorScheme.surface,
                focusColor: context.theme.colorScheme.surface,
                hoverColor: context.theme.colorScheme.surface,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ).stretch(),
            Spacing.smallVertical(),
            Container(
              padding: PaddingAll(Spacing.smallSpacing),
              decoration: ShapeDecoration(
                shape: squircle(),
                color: widget.color?.withValues(alpha: 0.1),
              ),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final task = tasksWithDropCandidates[index];
                  return Draggable<MoodleTask>(
                    data: task,
                    feedback: Builder(
                      builder: (context) {
                        return SizedBox(
                          width: KanbanCard.lastKnownWidth,
                          child: KanbanCard(
                            task: task,
                          ),
                        );
                      },
                    ),
                    childWhenDragging: Skeletonizer(
                      child: KanbanCard(task: task),
                    ),
                    child: KanbanCard(
                      task: task,
                    ),
                  ).stretch();
                },
                separatorBuilder: (context, index) => Spacing.smallVertical(),
                itemCount: tasksWithDropCandidates.length,
              ),
            ).expanded(),
          ],
        );
      },
    );
  }
}
