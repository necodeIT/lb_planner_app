import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module that provides theming-related services.
class ThemingModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
      ];

  @override
  void exportedBinds(Injector i) {
    i
      ..add<ThemesDatasource>(StdThemesDatasource.new)
      ..add<ThemeGeneratorService<ThemeData>>(MaterialThemeGeneratorService.new)
      ..addRepository<ThemeRepository>(ThemeRepository.new);
  }

  @override
  void routes(RouteManager r) {}
}
