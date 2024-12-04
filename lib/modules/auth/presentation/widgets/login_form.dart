import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';

/// A form prompting the user to input their credentials.
class LoginForm extends StatefulWidget {
  /// A form prompting the user to input their credentials.
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool loggingIn = false;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      setState(() {});
    });

    usernameController.addListener(() {
      setState(() {});
    });
  }

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      return;
    }

    setState(() {
      loggingIn = true;
    });

    final auth = Modular.get<AuthRepository>();

    await auth.authenticate(username: username, password: password);

    setState(() {
      loggingIn = false;
    });

    if (auth.state.hasError) {
      return;
    }

    usernameFocusNode.requestFocus();
  }

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  bool doesNotHavePermissions(AuthRepository auth) {
    if (!auth.state.hasError) {
      return false;
    }

    final error = auth.state.error;

    if (error is AuthException) {
      return error.reason is InsuffcientPermissionsReason;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthRepository>();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Assets.logo.themed(context, height: 100),
            const SizedBox(height: 16),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: context.t.auth_username,
                errorText: auth.state.hasError && !doesNotHavePermissions(auth) ? context.t.auth_invalidCredentials : null,
              ),
              focusNode: usernameFocusNode,
              onSubmitted: (_) => passwordFocusNode.requestFocus(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: context.t.auth_password,
                suffixIcon: IconButton(
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  icon: Icon(
                    showPassword ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
                errorText: auth.state.hasError && !doesNotHavePermissions(auth) ? context.t.auth_invalidCredentials : null,
              ),
              focusNode: passwordFocusNode,
              onSubmitted: (_) => login(),
            ),
            if (auth.state.hasError) const SizedBox(height: 16) else const SizedBox(height: 40),
            ElevatedButton(
              onPressed: passwordController.text.isEmpty || usernameController.text.isEmpty ? null : login,
              child: loggingIn ? const CircularProgressIndicator().button() : Text(context.t.auth_login).bold(),
            ).stretch(),
          ].show(),
        ),
        const SizedBox(height: 8),
        if (!loggingIn && doesNotHavePermissions(auth))
          Text(
            context.t.auth_accessHint(kAppName),
            style: context.bodySmall?.copyWith(color: context.theme.colorScheme.error),
          ).animate().fadeIn(),
      ],
    );
  }
}
