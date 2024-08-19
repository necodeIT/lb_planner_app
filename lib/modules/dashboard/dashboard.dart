import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

class DashboardModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        MoodleModule(),
      ];

  @override
  void binds(Injector i) {}

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const DashboardScreen(),
      transition: TransitionType.downToUp,
    );
  }
}
