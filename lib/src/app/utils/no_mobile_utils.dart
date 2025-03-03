import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Shows a mobile unsupported message for adaptive widgets when on mobile.
mixin NoMobile on Adaptive {
  @override
  Widget buildMobile(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PaddingAll(),
        child: Column(
          spacing: Spacing.mediumSpacing,
          children: [
            ImageMessage(
              message: context.t.app_noMobile_message,
              image: Assets.mobile,
            ).expanded(),
            ElevatedButton(
              onPressed: () => Modular.to.navigate('/dashboard/'),
              child: Text(context.t.app_noMobile_goBack),
            ),
          ],
        ),
      ),
    );
  }
}
