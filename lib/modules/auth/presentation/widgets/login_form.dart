import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
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

  bool loggingIn = false;
  bool showPassword = false;
  bool hasAttemptedLogin = false;

  Future<void> login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      loggingIn = true;
    });

    final auth = Modular.get<AuthRepository>();

    await auth.authenticate(username: username, password: password);

    setState(() {
      loggingIn = false;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Modular.get<AuthRepository>();

    if (auth.isAuthenticated) {
      Modular.to.navigate('/');
    }

    return Column();
  }
}
