import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/auth/infra/services/moodle_auth_service.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Handles the authentication of users.
class AuthModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) => i
    ..add<AuthService>(MoodleAuthService.new)
    ..addRepository(AuthRepository.new)
    ..addRepository(UserRepository.new);

  @override
  void exportedBinds(Injector i) => i
    ..add<AuthService>(MoodleAuthService.new)
    ..addRepository(UserRepository.new)
    ..addRepository(AuthRepository.new);

  @override
  void routes(RouteManager r) {}
}
