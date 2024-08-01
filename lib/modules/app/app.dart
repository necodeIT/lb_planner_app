library lb_planner.modules.app;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/domain/services/api_service.dart';
import 'package:lb_planner/modules/app/infra/services/moodle_api_service.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Root module of the application.
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<ApiService>(MoodleApiService.new);
  }

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
  }
}
