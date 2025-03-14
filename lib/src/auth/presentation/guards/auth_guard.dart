import 'package:eduplanner/src/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Guard that checks if the user is authenticated.
///
/// You must import [AuthModule] in the module using this guard.
class AuthGuard extends RouteGuard with MiddlewareLogger {
  /// Guard that checks if the user is authenticated.
  ///
  /// You must import [AuthModule] in the module using this guard.
  AuthGuard({super.redirectTo});

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final auth = Modular.tryGet<AuthRepository>();

    if (auth == null) {
      log('AuthRepository not found');
      return false;
    }

    await auth.ready;

    log('Authenticated: ${auth.isAuthenticated}');

    return auth.isAuthenticated;
  }
}
