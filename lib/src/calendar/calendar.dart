import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module implementing the app's calendar feature.
class CalendarModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        MoodleModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<TitleBuilder>(() => (BuildContext context) => (context.t.calendar_title, 2))
      ..add<InvitesDatasource>(StdInvitesDatasource.new)
      ..add<DeadlinesDatasource>(StdDeadlinesDatasource.new)
      ..add<PlanDatasource>(StdPlanDatasource.new)
      ..addRepository<InvitesRepository>(InvitesRepository.new)
      ..addRepository<CalendarPlanRepository>(CalendarPlanRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const CalendarScreen(),
      transition: TransitionType.custom,
      customTransition: defaultTransition,
      children: [
        ChildRoute('/plan/', child: (_) => const PlanScreen()),
        ChildRoute('/tasks-overview/', child: (_) => const TasksOverviewScreen()),
      ],
    );
  }
}
