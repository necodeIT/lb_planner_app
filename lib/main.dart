import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;

  // False positive as it's wrapped in a kDebugMode check
  // ignore: avoid_print
  if (kDebugMode) Logger.root.onRecord.listen(debugLogHandler);

  Modular.setInitialRoute('/dashboard');

  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

/// Root widget of the application.
class AppWidget extends StatelessWidget {
  /// Root widget of the application.
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeRepository>();

    return MaterialApp.router(
      theme: theme.state,
      title: kAppName,
      routerConfig: Modular.routerConfig,
      onGenerateTitle: (context) => kAppName,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      debugShowCheckedModeBanner: false,
    );
  }
}
