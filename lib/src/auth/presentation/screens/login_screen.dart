import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:lb_planner/lb_planner.dart';

/// Presents an authentication form to the user.
class LoginScreen extends StatelessWidget {
  /// Presents an authentication form to the user.
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();
    final auth = context.watch<AuthRepository>();

    if (auth.isAuthenticated && user.state.hasData) {
      Modular.to.navigate('/dashboard/');
    }

    DesktopGuard.listen(context);

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
                child: LoginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
