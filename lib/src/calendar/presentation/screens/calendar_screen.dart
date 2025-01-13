import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:data_widget/data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// Renders the UI of the calendar feature.
class CalendarScreen extends StatefulWidget {
  /// Renders the UI of the calendar feature.
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => CalendarScreenState();
}

/// State of the [CalendarScreen].
class CalendarScreenState extends State<CalendarScreen> {
  List<Widget> Function(BuildContext)? _actionBuilder;

  /// The current tab of the screen.
  CalendarScreenTab currentTab = CalendarScreenTab.plan;

  /// Sets the action builder of the screen.
  ///
  /// Actions are displayed at the top of the screen and placed inside a [Stack].
  void setActionBuiler(List<Widget> Function(BuildContext) builder) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() {
        _actionBuilder = builder;
      }),
    );
  }

  /// Switches the current tab of the screen.
  void switchTab(CalendarScreenTab tab) {
    if (currentTab == tab) return;

    setState(() {
      _actionBuilder = null;
      currentTab = tab;
    });

    Modular.to.navigate('/calendar/${tab == CalendarScreenTab.plan ? 'plan' : 'tasks-overview'}');
  }

  @override
  Widget build(BuildContext context) {
    final nextTab = currentTab == CalendarScreenTab.plan ? CalendarScreenTab.moduleOverview : CalendarScreenTab.plan;

    return Container(
      decoration: ShapeDecoration(
        color: context.theme.cardColor,
        shape: squircle(),
        shadows: kElevationToShadow[8],
      ),
      margin: PaddingAll(),
      child: Column(
        children: [
          Container(
            height: 60,
            padding: PaddingAll(Spacing.smallSpacing),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => switchTab(nextTab),
                    child: Text(
                      nextTab == CalendarScreenTab.plan ? 'Plan' : 'Tasks Overview',
                    ),
                  ),
                ),
                if (_actionBuilder != null) ..._actionBuilder!(context),
              ],
            ),
          ),
          Data.inherit(
            data: this,
            child: const RouterOutlet(),
          ).expanded(),
        ],
      ),
    );
  }
}

/// The tabs of the calendar screen.
enum CalendarScreenTab {
  /// Current tab is [PlanScreen].
  plan,

  /// Corrent tab is [TasksOverviewScreen].
  moduleOverview,
}
