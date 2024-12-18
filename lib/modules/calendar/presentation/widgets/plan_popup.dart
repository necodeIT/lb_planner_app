import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Plan management popup.
class PlanPopup extends StatefulWidget {
  /// Plan management popup.
  const PlanPopup({super.key, required this.close, required this.dragWidth});

  /// The width of a task when dragging.
  final double dragWidth;

  /// Closes the popup.
  final Function() close;

  @override
  State<PlanPopup> createState() => _PlanPopupState();
}

class _PlanPopupState extends State<PlanPopup> with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingAll(Spacing.smallSpacing),
      decoration: ShapeDecoration(
        color: context.theme.cardColor,
        shape: squircle(),
        shadows: kElevationToShadow[16],
      ),
      child: Column(
        children: [
          Row(
            children: [
              TabBar(
                controller: controller,
                tabs: const [
                  Tab(
                    text: 'Tasks',
                  ),
                  Tab(
                    text: 'Members',
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    controller.index = index;
                  });
                },
              ).expanded(),
              Spacing.smallHorizontal(),
              IconButton(
                icon: const Icon(Icons.close),
                color: context.theme.colorScheme.error,
                onPressed: widget.close,
              ),
            ],
          ),
          Padding(
            padding: PaddingTop(Spacing.mediumSpacing),
            child: controller.index == 0
                ? PlanPopupTasks(
                    dragWidth: widget.dragWidth,
                  )
                : const PlanPopupMembers(),
          ).expanded(),
        ],
      ),
    );
  }
}
