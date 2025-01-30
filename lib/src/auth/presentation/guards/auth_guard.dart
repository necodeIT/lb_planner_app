import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/auth/auth.dart';

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
    if (Modular.tryGet<AuthRepository>() == null) return false;

    await Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      return Modular.get<AuthRepository>().state.isLoading;
    });

    return Modular.get<AuthRepository>().isAuthenticated;
  }
}
