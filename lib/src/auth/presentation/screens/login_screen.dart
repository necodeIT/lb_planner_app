import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Presents an authentication form to the user.
class LoginScreen extends StatelessWidget with AdaptiveWidget {
  /// Presents an authentication form to the user.
  const LoginScreen({super.key});

  static void _onLogin() {
    Modular.to.navigate('/dashboard');
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
          const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(right: 150),
              child: SizedBox(
                width: 350,
                child: LoginForm(
                  onLogin: _onLogin,
                ),
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
            const Spacer(),
            const LoginForm(
              onLogin: _onLogin,
            ),
            const Spacer(),
            Text(
              context.t.auth_version(kInstalledRelease.toString()),
            ).color(context.theme.colorScheme.onPrimary),
          ],
        ),
      ),
    );
  }
}
