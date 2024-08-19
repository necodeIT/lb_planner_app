import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/auth/auth.dart';

/// Guard that checks if the user is authenticated.
///
/// You must import [AuthModule] in the module using this guard.
class AuthGuard extends RouteGuard {
  /// Guard that checks if the user is authenticated.
  ///
  /// You must import [AuthModule] in the module using this guard.
  AuthGuard({super.redirectTo});

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final auth = Modular.get<AuthRepository>();

    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      return auth.state.isLoading;
    });

    return auth.isAuthenticated;
  }
}
