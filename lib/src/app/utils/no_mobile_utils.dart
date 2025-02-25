import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

// TODO(MasterMarcoHD): Use this mixin in all routes that don't support mobile.

/// Shows a mobile unsupported message for adaptive widgets when on mobile.
mixin NoMobile on Adaptive {
  @override
  Widget buildMobile(BuildContext context) {
    // TODO(MasterMarcoHD): Localize messages.
    return Scaffold(
      body: Padding(
        padding: PaddingAll(),
        child: Column(
          spacing: Spacing.mediumSpacing,
          children: [
            const ImageMessage(
              message: 'This feature is not available on mobile devices.',
              image: Assets.mobile,
            ).expanded(),
            ElevatedButton(
              onPressed: () => Modular.to.navigate('/dashboard/'),
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
