import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class SlotDataPopOver extends StatefulWidget {
  const SlotDataPopOver({super.key, required this.contentList});

  final List<Widget> contentList;

  @override
  State<SlotDataPopOver> createState() => _SlotDataPopOverState();
}

class _SlotDataPopOverState extends State<SlotDataPopOver> {
  BuildContext? popupContext;
  bool parentHover = true;
  bool childHover = true;

  void closePopUp({bool forceClose = false}) {
    if (popupContext == null) return;

    if ((parentHover || childHover) && !forceClose) return;

    Navigator.of(popupContext!).pop();

    popupContext = null;
  }

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: SystemMouseCursors.basic,
      builder: (context, isHovering) {
        parentHover = isHovering;
        Future.delayed(const Duration(milliseconds: 300), closePopUp);
        if (widget.contentList.isEmpty) {
          closePopUp(forceClose: true);
          return const SizedBox.shrink();
        }
        return Row(
          children: [
            Expanded(
              child: widget.contentList[0],
            ),
            if (widget.contentList.length > 1) ...[
              Spacing.xsHorizontal(),
              GestureDetector(
                // ignore: sort_child_properties_last
                child: Chip(
                  label: Text('+${widget.contentList.length - 1}'),
                ),
                onTap: widget.contentList.length > 1
                    ? () {
                        if (popupContext != null) {
                          closePopUp(forceClose: true);
                          return;
                        }
                        showPopover(
                          context: context,
                          bodyBuilder: (context) {
                            popupContext = context;
                            return HoverBuilder(
                              cursor: SystemMouseCursors.basic,
                              builder: (context, isHovering) {
                                childHover = isHovering;
                                Future.delayed(const Duration(milliseconds: 300), closePopUp);
                                return Card(
                                  elevation: 16,
                                  shape: squircle(side: BorderSide(color: context.theme.dividerColor)),
                                  color: context.theme.cardColor,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: widget.contentList.spaced(Spacing.smallSpacing),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          arrowHeight: 0,
                          arrowWidth: 0,
                          allowClicksOnBackground: true,
                          direction: PopoverDirection.bottom,
                          transition: PopoverTransition.other,
                          // contentDxOffset: -width + (context.size?.width ?? 0),
                          barrierDismissible: true,
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.transparent,
                          transitionDuration: const Duration(milliseconds: 300),
                          popoverTransitionBuilder: (animation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: animation.drive(
                                  Tween<Offset>(
                                    begin: const Offset(0, -0.02),
                                    end: Offset.zero,
                                  ),
                                ),
                                child: child,
                              ),
                            );
                          },
                        );
                      }
                    : null,
              ),
            ],
          ],
        );
      },
    );
  }
}
