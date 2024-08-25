import 'dart:async';

import 'package:catcher_2/catcher_2.dart';
import 'package:catcher_2/model/platform_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

void main() async {
  final options = Catcher2Options(ShoutReportMode(), []);

  WidgetsFlutterBinding.ensureInitialized();

  Logger.root.level = Level.ALL;

  DeclarativeEdgeInsets.defaultPadding = Spacing.mediumSpacing;
  NetworkService.timeout = const Duration(seconds: 30);

  // False positive as it's wrapped in a kDebugMode check
  // ignore: avoid_print
  if (kDebugMode) Logger.root.onRecord.listen(debugLogHandler);

  // TODO(mcquenji): write to file in release mode
  if (kReleaseMode) Logger.root.onRecord.listen(debugLogHandler);

  Modular
    ..setInitialRoute('/dashboard/')
    ..setObservers([LogObserver()]);

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
    Catcher2(
      releaseConfig: options,
      debugConfig: options,
      rootWidget: ModularApp(
        module: AppModule(),
        debugMode: false,
        child: const AppWidget(),
      ),
      enableLogger: false,
    );
  } else {
    Logger(kAppName).severe('App is already running');
  }
}

/// Root widget of the application.
class AppWidget extends StatefulWidget {
  /// Root widget of the application.
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  late final StreamSubscription _authSubscription;

  @override
  void initState() {
    super.initState();

    _authSubscription = Modular.get<AuthRepository>().listen(_listener);
  }

  Future<void> _listener(AsyncValue<Set<Token>> state) async {
    final auth = Modular.get<AuthRepository>();

    await auth.loadStoredTokens;

    if (auth.isAuthenticated) return;

    if (Modular.to.isActive('/auth')) return;

    Modular.to.navigate('/auth/');
  }

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

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }
}

/// Uses [Logger.shout] to report errors.
class ShoutReportMode extends ReportMode {
  @override
  List<PlatformType> getSupportedPlatforms() => PlatformType.values;

  @override
  void requestAction(Report report, BuildContext? context) {
    Logger('Main').shout('Uncaught error', report.error, report.stackTrace);
  }
}

/// Logs navigation events.
class LogObserver extends NavigatorObserver {
  /// Logs navigation events.
  void log(Route<dynamic> route, Route<dynamic>? previousRoute, String action) {
    final logger = Logger('Modular');

    if (previousRoute != null) {
      logger.finest('$action from ${previousRoute.settings.name} to ${route.settings.name}');
    } else {
      logger.finest('$action to ${route.settings.name}');
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(route, previousRoute, 'Pushed');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(route, previousRoute, 'Popped');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    log(newRoute!, oldRoute, 'Replaced');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(route, previousRoute, 'Removed');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    log(route, previousRoute, 'Started user gesture');
  }

  @override
  void didStopUserGesture() {
    Logger('Modular').finest('Stopped user gesture');
  }
}
