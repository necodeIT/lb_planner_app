import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module responsible for the statistics feature.
class StatisticsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AppModule(),
      ];

  @override
  void binds(Injector i) => i
    ..add<CourseStatsRepository>(CourseStatsRepository.new)
    ..add<GlobalStatsRepository>(GlobalStatsRepository.new);

  @override
  void routes(RouteManager r) {}
}
