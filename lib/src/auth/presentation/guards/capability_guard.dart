import 'dart:async';

import 'package:eduplanner/src/auth/auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Guard that checks if the user has the required capabilities.
class CapabilityGuard extends RouteGuard with MiddlewareLogger {
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

    log('User capabilities: ${user.state.data?.capabilities} ; Required: $capabilities');

    if (!user.state.hasData) {
      return false;
    }

    return capabilities.every(user.state.data!.hasCapability);
  }
}
