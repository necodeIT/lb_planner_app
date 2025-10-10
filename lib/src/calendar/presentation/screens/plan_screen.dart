import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:data_widget/data_widget.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:popover/popover.dart';
import 'package:window_manager/window_manager.dart';

/// Displays a calendar view and allows the user to plan their tasks.
class PlanScreen extends StatefulWidget {
  /// Displays a calendar view and allows the user to plan their tasks.
  const PlanScreen({super.key});

  /// Formatter for the month.
  static final monthFormatter = DateFormat('MMMM yyyy');

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> with WindowListener, AdaptiveState, NoMobile {
  /// The first day of the month to currently display.
  DateTime currentMonth = DateTime.now();
  DateTime prevMonth = DateTime.now();

  CalendarScreenState? parent;
  BuildContext? popupContext;

  double cellWidth = 100;

  @override
  void onWindowResize() {
    closePlanPopup();
  }

  @override
  void onWindowResized() {
    closePlanPopup();
  }

  @override
  void onWindowMaximize() {
    closePlanPopup();
  }

  @override
  void onWindowUnmaximize() {
    closePlanPopup();
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);

    currentMonth = DateTime(currentMonth.year, currentMonth.month);
    prevMonth = DateTime(currentMonth.year, currentMonth.month - 1);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    closePlanPopup();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    parent = Data.of<CalendarScreenState>(context);
    parent!.setActionBuiler(actionBuiler);
  }

  void updateCellWidth(double width) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cellWidth != width) {
        setState(() {
          cellWidth = width;
        });
      }
    });
  }

  void nextMonth() {
    setState(() {
      prevMonth = currentMonth;

      // check if the next month is in the next year
      if (currentMonth.month == 12) {
        currentMonth = DateTime(currentMonth.year + 1);
      } else {
        currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      }
    });

    parent?.setActionBuiler(actionBuiler);
  }

  void previousMonth() {
    setState(() {
      prevMonth = currentMonth;

      // check if the previous month is in the previous year
      if (currentMonth.month == 1) {
        currentMonth = DateTime(currentMonth.year - 1, 12);
      } else {
        currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      }
    });

    parent?.setActionBuiler(actionBuiler);
  }

  void closePlanPopup() {
    if (popupContext == null) return;

    Navigator.of(popupContext!).pop();

    popupContext = null;

    parent?.setActionBuiler(actionBuiler);
  }

  void showPlanPopup(BuildContext context) {
    if (popupContext != null) return;

    final height = context.height * 0.6;
    final width = context.width * 0.2;

    showPopover(
      context: context,
      onPop: () {
        popupContext = null;
        parent?.setActionBuiler(actionBuiler);
      },
      bodyBuilder: (context) {
        popupContext = context;
        return PlanPopup(
          dragWidth: cellWidth,
          close: closePlanPopup,
        );
      },
      arrowHeight: 0,
      arrowWidth: 0,
      allowClicksOnBackground: true,
      direction: PopoverDirection.top,
      transition: PopoverTransition.other,
      contentDxOffset: -width + (context.size?.width ?? 0),
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
        minHeight: height,
        minWidth: width,
      ),
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

    parent?.setActionBuiler(actionBuiler);
  }

  void selectCurrentMonth() {
    final now = DateTime.now();

    setState(() {
      prevMonth = currentMonth;
      currentMonth = DateTime(now.year, now.month);
    });

    parent?.setActionBuiler(actionBuiler);
  }

  List<Widget> actionBuiler(BuildContext context) {
    return [
      Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: previousMonth,
              icon: const Icon(
                Icons.chevron_left,
              ),
            ),
            Spacing.xsHorizontal(),
            ConditionalWrapper(
              condition: currentMonth.month != DateTime.now().month,
              wrapper: (_, child) => TextButton(
                onPressed: selectCurrentMonth,
                child: child,
              ),
              child: Text(
                PlanScreen.monthFormatter.format(currentMonth),
              ),
            ),
            Spacing.xsHorizontal(),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: nextMonth,
              icon: const Icon(
                Icons.chevron_right,
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: Builder(
          builder: (context) {
            return IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onPressed: popupContext == null ? () => showPlanPopup(context) : null,
              icon: const Icon(Icons.more_horiz),
            );
          },
        ),
      ),
    ];
  }

  @override
  Widget buildDesktop(BuildContext context) {
    // fill in the days of the month so that the beginning and the end are full weeks (use previous and next month)
    final days = <DateTime>[];

    final lastDay = DateTime(currentMonth.year, currentMonth.month + 1, 0);

    // get the weekday of the first day of the month and fill in the days of the previous month
    for (var i = currentMonth.weekday - 1; i > 0; i--) {
      days.add(currentMonth.subtract(Duration(days: i)));
    }

    // fill in the days of the current month
    for (var i = 0; i < lastDay.day; i++) {
      // we have to copy with instead of just adding days because of daylight saving time
      days.add(currentMonth.copyWith(day: i + 1));
    }

    // get the weekday of the last day of the month and fill in the days of the next month
    for (var i = 0; i < 7 - lastDay.weekday; i++) {
      days.add(lastDay.add(Duration(days: i + 1)));
    }

    return Column(
      children: [
        Row(
          children: [
            for (var i = 0; i < 7; i++)
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat('E').format(days[i]),
                    style: context.theme.textTheme.titleSmall,
                  ),
                ),
              ),
          ],
        ).stretch(),
        Spacing.xsVertical(),
        LayoutBuilder(
          key: ValueKey(currentMonth),
          builder: (context, size) {
            // each row has 7 days
            final rows = days.length / 7;

            return AnimationLimiter(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  // calculate the height of each row
                  mainAxisExtent: size.maxHeight / rows,
                ),
                itemCount: days.length,
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, size) {
                    final day = days[index];

                    if (index == 0) {
                      updateCellWidth(size.maxWidth);
                    }

                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      columnCount: 7,
                      child: SlideAnimation(
                        horizontalOffset: 200 * (prevMonth.isBefore(currentMonth) ? 1 : -1),
                        child: FadeInAnimation(
                          child: PlanCell(date: day, currentMonth: currentMonth),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ).expanded(),
      ],
    );
  }
}
