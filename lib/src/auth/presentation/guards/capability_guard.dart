import 'package:eduplanner/src/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Guard that checks if the user has the required capabilities.
class CapabilityGuard extends RouteGuard {
  /// The required capabilities.
  final Set<UserCapability> capabilities;

  /// Guard that checks if the user has the required capabilities.
  CapabilityGuard(this.capabilities, {super.redirectTo});

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final user = Modular.tryGet<UserRepository>();

    if (user == null) {
      return false;
    }

    await user.ready;

    if (!user.state.hasData) {
      return false;
    }

    return capabilities.every(user.state.data!.hasCapability);
  }
}
