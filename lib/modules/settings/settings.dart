import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module implementing the settings screen.
class SettingsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        MoodleModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<TitleBuilder>(() => (BuildContext context) => context.t.settings_title);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => const SettingsScreen(),
      transition: TransitionType.custom,
      customTransition: defaultTransition,
    );
  }
}
