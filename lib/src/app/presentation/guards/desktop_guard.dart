import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Ensures that the user is on a desktop device.
class DesktopGuard extends RouteGuard {
  /// Whether to invert the guard.
  final bool invert;

  /// Ensures that the user is on a desktop device.
  DesktopGuard({this.invert = false, super.redirectTo = '/mobile'});

  /// The minimum window size to be considered a desktop device.
  static const minWindowSize = Size(1024, 768);

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final size = MediaQueryData.fromView(PlatformDispatcher.instance.views.first).size;

    return invert ? size < minWindowSize : size >= minWindowSize;
  }

  /// Listens for window size changes and redirects the user if necessary.
  static void listen(BuildContext context, {bool invert = false, String redirectTo = '/mobile'}) {
    final size = MediaQuery.sizeOf(context);

    if (invert ? size >= minWindowSize : size < minWindowSize) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Modular.to.navigate(redirectTo);
      });
    }
  }
}
