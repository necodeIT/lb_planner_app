import 'package:echidna_flutter/echidna_flutter.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/lb_planner.dart';
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
        EchidnaModule(),
      ];

  @override
  void exportedBinds(Injector i) => i
    ..add<ApiService>(MoodleApiService.new)
    ..add<AuthService>(MoodleAuthService.new)
    ..add<UserDatasource>(MoodleUserDatasource.new)
    ..addRepository<AuthRepository>(AuthRepository.new)
    ..addRepository<UserRepository>(UserRepository.new)
    ..addSerde<Token>(fromJson: Token.fromJson, toJson: (t) => t.toJson())
    ..addSerde<User>(fromJson: User.fromJson, toJson: (u) => u.toJson())
    ..initializeLicenseRepo(EchidnaUserRepository.new);

  @override
  void routes(RouteManager r) {
    r
      ..child('/', child: (_) => const LoginScreen())
      ..wildcard(child: (_) => const NotFoundScreen());
  }
}
