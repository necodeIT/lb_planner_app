import 'package:flutter/material.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:lb_planner/src/app/app.dart';

/// Displays a warning for mobile users.
class MobileScreen extends StatelessWidget {
  /// Displays a warning for mobile users.
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DesktopGuard.listen(context, invert: true, redirectTo: '/dashboard/');

    return Scaffold(
      body: Padding(
        padding: PaddingAll(),
        child: ImageMessage(
          message: context.t.mobile(kAppName),
          image: Assets.mobile,
        ),
      ),
    );
  }
}
