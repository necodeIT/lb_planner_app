import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

import 'infra/infra.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Handles the authentication of users.
class AuthModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        LocalStorageModule(),
      ];

  @override
  void binds(Injector i) => i
    ..add<ApiService>(MoodleApiService.new)
    ..add<AuthService>(MoodleAuthService.new)
    ..add<UserDatasource>(MoodleUserDatasource.new)
    ..addRepository<AuthRepository>(AuthRepository.new)
    ..addRepository<UserRepository>(UserRepository.new)
    ..addSerde<Token>(fromJson: Token.fromJson, toJson: (t) => t.toJson())
    ..addTickRepository(const TickInterval(milliseconds: kRefreshInterval))
    ..addSerde<User>(fromJson: User.fromJson, toJson: (u) => u.toJson());

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const LoginScreen());
  }
}
