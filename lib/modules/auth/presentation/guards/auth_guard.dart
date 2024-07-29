import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/auth/auth.dart';

/// Guard that checks if the user is authenticated.
///
/// You must import [AuthModule] in the module using this guard.
class AuthGuard extends RouteGuard {
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    return Modular.get<AuthRepository>().state.data?.isNotEmpty ?? false;
  }
}
