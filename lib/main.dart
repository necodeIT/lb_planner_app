import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';

void main() async {
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

/// Root widget of the application.
class AppWidget extends StatelessWidget {
  /// Root widget of the application.
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // todo offline check

    return MaterialApp.router(
      title: kAppName,
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
