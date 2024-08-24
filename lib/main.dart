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

  // TODO(mcquenji): write to file in release mode
  if (kReleaseMode) Logger.root.onRecord.listen(debugLogHandler);

  Modular.setInitialRoute('/dashboard/');

  setPrintResolver((msg) {
    final logger = Logger('Modular');
    final parts = msg.split(' ');

    final log = logger.info;

    if (parts.length == 3 && parts[0] == '--') {
      final module = parts[1].replaceAll('Module', ' Module').toLowerCase();
      final action = parts[2];

      if (action == 'DISPOSED') {
        log('Disposed $module');
        return;
      }

      if (action == 'INITIALIZED') {
        log('Initilaized $module');
        return;
      }
    }

    log(msg);
  });

  if (await FlutterSingleInstance.platform.isFirstInstance()) {
    runApp(
      ModularApp(
        module: AppModule(),
        debugMode: false,
        child: const AppWidget(),
      ),
    );
  } else {
    Logger(kAppName).severe('App is already running');
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
