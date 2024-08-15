import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
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
        AppModule(),
      ];

  @override
  void binds(Injector i) => i
    ..add<InvitesDatasource>(StdInvitesDatasource.new)
    ..add<DeadlinesDatasource>(StdDeadlinesDatasource.new)
    ..add<PlanDatasource>(StdPlanDatasource.new)
    ..addRepository<CalendarPlanRepository>(CalendarPlanRepository.new);

  @override
  void routes(RouteManager r) {}
}
