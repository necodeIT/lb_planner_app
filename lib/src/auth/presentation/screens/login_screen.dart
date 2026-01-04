import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// Presents an authentication form to the user.
class LoginScreen extends StatelessWidget with AdaptiveWidget {
  /// Presents an authentication form to the user.
  const LoginScreen({super.key});

  static void _onLogin() {
    Modular.to.navigate('/dashboard/');
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Assets.auth.background.themed(context, alignment: Alignment.bottomLeft),
          Positioned(
            left: 20,
            bottom: 20,
            child: Text(
              context.t.auth_version(kInstalledRelease.toString()),
            ).color(context.theme.colorScheme.onPrimary),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 150),
              child: SizedBox(
                width: 350,
                child: kInstalledRelease.channel == ReleaseChannel.demo
                    ? const DemoUserSelector(
                        onLogin: _onLogin,
                      )
                    : const LoginForm(onLogin: _onLogin),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: PaddingAll(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spacing.mediumSpacing,
          children: [
            if (kInstalledRelease.channel != ReleaseChannel.demo) const Spacer(),
            if (kInstalledRelease.channel == ReleaseChannel.demo)
              const Expanded(child: DemoUserSelector(onLogin: _onLogin))
            else
              const LoginForm(onLogin: _onLogin),
            if (kInstalledRelease.channel != ReleaseChannel.demo) const Spacer(),
            Text(
              context.t.auth_version(kInstalledRelease.toString()),
            ).color(context.theme.colorScheme.onPrimary),
          ],
        ),
      ),
    );
  }
}
