import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module implementing the app's course overview feature.
class CourseOverviewModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        StatisticsModule(),
        CalendarModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<TitleBuilder>(() => (BuildContext context) => (context.t.courses_overview, null));
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r
      ..child(
        '/',
        child: (_) => const CoursesOverviewScreen(),
      )
      ..child(
        '/:id',
        child: (_) => CourseOverviewScreen(
          id: int.parse(r.args.params['id']),
        ),
      );
  }
}
