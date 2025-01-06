import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/auth/auth.dart';

/// Guard that checks if the user has the required capabilities.
class CapabilityGuard extends RouteGuard {
  /// The required capabilities.
  final Set<UserCapability> capabilities;

  /// Guard that checks if the user has the required capabilities.
  CapabilityGuard(this.capabilities, {super.redirectTo});

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final user = Modular.get<UserRepository>();

    if (!user.state.hasData) {
      return false;
    }

    return capabilities.every(user.state.data!.hasCapability);
  }
}
