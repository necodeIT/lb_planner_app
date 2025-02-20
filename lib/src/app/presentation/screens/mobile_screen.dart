import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:flutter/material.dart';

/// Displays a warning for mobile users.
class MobileScreen extends StatelessWidget {
  /// Displays a warning for mobile users.
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
