import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/statistics/statistics.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module implementing the dashboard feature.
class DashboardModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        MoodleModule(),
        StatisticsModule(),
        CalendarModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<TitleBuilder>(() => (BuildContext context) => context.t.dashboard_title);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const DashboardScreen(),
      transition: TransitionType.custom,
      customTransition: defaultTransition,
    );
  }
}
