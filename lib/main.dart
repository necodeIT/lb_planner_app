import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;

  DeclarativeEdgeInsets.defaultPadding = Spacing.mediumSpacing;
  NetworkService.timeout = const Duration(seconds: 30);

  // False positive as it's wrapped in a kDebugMode check
  // ignore: avoid_print
  if (kDebugMode) Logger.root.onRecord.listen(debugLogHandler);
  if (kReleaseMode) Logger.root.onRecord.listen(debugLogHandler); // TODO(mcquenji): write to file

  Modular.setInitialRoute('/dashboard/');

  if (await FlutterSingleInstance.platform.isFirstInstance()) {
    runApp(ModularApp(module: AppModule(), child: const AppWidget()));
  } else {
    Logger.root.severe('App is already running');
  }
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
    );
  }
}
