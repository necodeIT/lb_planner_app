part of lbplanner_routes;

/// Wraps the [ModuleWidget] in a [LongPressDraggable].
class DraggableModule extends StatelessWidget {
  /// Wraps the [ModuleWidget] in a [LongPressDraggable].
  const DraggableModule({Key? key, required this.moduleId}) : super(key: key);

  /// The id of the module to display.
  final int moduleId;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        var width = CalendarPlanCellState.currentWidth > 0 ? CalendarPlanCellState.currentWidth : box.maxWidth;

        return Draggable<int>(
          rootOverlay: true,
          // feedbackOffset: Offset(600, 0),
          data: moduleId,
          dragAnchorStrategy: (child, context, offset) => Offset(width / 2, ModuleWidget.height / 2),
          child: ModuleWidget.status(moduleId: moduleId),
          feedback: AnimatedPositioned(
            duration: kFastAnimationDuration,
            child: SizedBox(
              width: width,
              child: ModuleWidget.status(moduleId: moduleId),
            ),
          ),
          childWhenDragging: LpShimmer(),
        );
      },
    );
  }
}