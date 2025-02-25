import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:context_menus/context_menus.dart';
import 'package:device_preview/device_preview.dart';
import 'package:echidna_flutter/echidna_flutter.dart';
import 'package:eduplanner/config/echidna.dart';
import 'package:eduplanner/config/posthog.dart';
import 'package:eduplanner/config/sentry.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';
import 'package:posthog_dart/posthog_dart.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A list of all keys that should be censored in log messages.
const sensitiveKeys = kDebugMode
    ? []
    : [
        'wstoken',
        'token',
        'apikey',
        'secret',
        'password',
        'key',
        'access_token',
        'refresh_token',
        'client_secret',
        'clientkey',
        'clientid',
        'api_key',
        'username',
        'firstname',
        'lastname',
        'email',
        'id',
        'vintage',
        'language',
        'profileImageUrl',
        'colorblindness',
        'colorblindnessString',
        'displaytaskcount',
        'userid',
      ];

/// Censores sensitive data in log messages.
String scrubSensitiveData(String message) {
  var scrubbed = message;

  final patterns = [
    // Key-Value Pairs
    for (final key in sensitiveKeys) RegExp(r'(\b' + key + r'\b\s*=\s*)([^&\s,]*)', caseSensitive: false, multiLine: true),

    // Json values
    for (final key in sensitiveKeys) RegExp(r'(\b' + key + r'\b\s*:\s*)([^&\s,}]*)', caseSensitive: false, multiLine: true),

    // Bearer Tokens
    RegExp(r'(Bearer\s+)([^\s]*)', caseSensitive: false),
    // Basic Auth
    RegExp(r'(Basic\s+)([^\s]*)', caseSensitive: false),
    // JWT Tokens
    RegExp(r'(JWT\s+)([^\s]*)', caseSensitive: false),
  ];

  for (final pattern in patterns) {
    scrubbed = scrubbed.replaceAllMapped(pattern, (match) {
      final key = match.group(1);
      final value = match.group(2);

      final length = value?.length ?? 1;

      return '$key${'*' * length}';
    });
  }

  return scrubbed;
}

String _prevRoute = '/';

void main() async {
  Logger.root.level = Level.ALL;

  DeclarativeEdgeInsets.defaultPadding = Spacing.mediumSpacing;
  CoreModule.isWeb = kIsWeb;
  CoreModule.debugMode = kDebugMode;

  Adaptive.ignoreHeight = true;

  setPathUrlStrategy();

  initializeEchidnaApi(baseUrl: kEchidnaHost, clientKey: kEchidnaClientKey, clientId: kEchidnaClientID);

  for (final locale in AppLocalizations.supportedLocales) {
    await initializeDateFormatting(locale.languageCode);
  }

  CoreModule.onInitDio = (dio) {
    dio.addSentry();

    dio.options.validateStatus = (_) => true;
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = null;
    if (!kIsWeb) dio.options.sendTimeout = const Duration(seconds: 30);
  };

  Logger.root.onRecord.listen((record) {
    final scrubbed = LogRecord(
      record.level,
      scrubSensitiveData(record.message),
      record.loggerName,
      record.error,
      record.stackTrace,
      record.zone,
      record.object,
    );

    final handler = Modular.tryGet<LogHandlerService>();

    handler?.call(scrubbed);

    if (record.level >= Level.SEVERE && record.error != null) {
      final logs = (handler?.flush() ?? []).join('\n');

      final bytes = utf8.encode(logs);
      final byteData = ByteData.view(bytes.buffer, bytes.offsetInBytes, bytes.length);

      Sentry.captureException(
        record.error,
        stackTrace: record.stackTrace,
        hint: Hint.withAttachment(
          SentryAttachment.fromByteData(
            byteData,
            '${DateTime.now().toIso8601String()}.log',
          ),
        ),
        withScope: (scope) async {
          await scope.setContexts('Logger', {
            'Name': record.loggerName,
            'Level': record.level.name,
            'Message': record.message,
          });
        },
      );
    }
  });

  Modular
    ..setInitialRoute('/dashboard/')
    ..to.setObservers([
      LogObserver(),
      SentryNavigatorObserver(),
      kRouteObserver,
    ]);

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

      log(msg);
    }

    log(msg);
  });

  await Sentry.init(
    (options) => options
      ..dsn = kDebugMode ? '' : kSentryDSN
      ..environment = kInstalledRelease.channel.name
      ..release = kInstalledRelease.version.toString()
      ..tracesSampleRate = 1
      ..tracePropagationTargets.clear()
      ..debug = kDebugMode
      ..logger = (SentryLevel level, String message, {String? logger, Object? exception, StackTrace? stackTrace}) =>
          Logger('Sentry${logger != null ? '.$logger' : ''}').finest(message, exception, stackTrace),
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();

      if (!kIsWeb) await windowManager.ensureInitialized();
      if (kIsWeb) await BrowserContextMenu.disableContextMenu();

      if (!await FlutterSingleInstance().isFirstInstance()) {
        Logger(kAppName).info('App is already running');

        final err = await FlutterSingleInstance().focus();

        if (err != null) {
          Logger(kAppName).severe('Failed to focus app: $err');
        }

        exit(0);
      }

      await PostHog.init(
        apiKey: kPostHogAPIkey,
        host: kPostHogHost,
        debug: kDebugMode,
        version: kInstalledRelease.toString(),
      );

      if (kDebugMode) {
        PostHog().disable();
      }

      Modular.to.addListener(() async {
        final message = 'Route changed: $_prevRoute --> ${Modular.to.path}';

        Logger('Modular').finest(message);

        await PostHog().screen(Modular.to.path);
        await Sentry.addBreadcrumb(
          Breadcrumb(
            message: message,
            category: 'navigation',
            data: {'from': _prevRoute, 'to': Modular.to.path},
          ),
        );

        _prevRoute = Modular.to.path;
      });

      runApp(
        ModularApp(
          module: AppModule(),
          debugMode: false,
          child: const SentryScreenshotWidget(child: AppWidget()),
        ),
      );
    },
  );
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

    await auth.ready;

    if (auth.isAuthenticated) return;

    if (Modular.to.isActive('/auth')) return;

    Modular.to.navigate('/auth/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeRepository>();

    return DevicePreview(
      // false positive
      // ignore: avoid_redundant_argument_values
      enabled: kDebugMode,
      builder: (_) => Theme(
        data: theme.state,
        child: ContextMenuOverlay(
          buttonBuilder: (context, config, [style]) => HoverBuilder(
            builder: (context, isHovering) => TextButton(
              onPressed: config.onPressed,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                overlayColor: WidgetStateProperty.all(Colors.transparent),
              ),
              child: IconTheme(
                data: context.theme.iconTheme.copyWith(color: context.theme.colorScheme.onSurface, size: 15),
                child: Row(
                  children: [
                    if (config.icon != null) isHovering ? config.iconHover ?? config.icon! : config.icon!,
                    if (config.icon != null) Spacing.xsHorizontal(),
                    Text(
                      config.label,
                      style: TextStyle(color: context.theme.colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ),
          ),
          cardBuilder: (context, children) => Container(
            padding: PaddingAll(Spacing.xsSpacing),
            decoration: ShapeDecoration(
              color: theme.state.cardColor,
              shape: squircle(),
              shadows: kElevationToShadow[8],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: children,
            ),
          ),
          child: ConditionalWrapper(
            condition: kInstalledRelease.channel != ReleaseChannel.stable || kDebugMode,
            wrapper: (context, child) => Banner(
              message: kInstalledRelease.channel.name.toUpperCase(),
              location: BannerLocation.topEnd,
              color: theme.state.colorScheme.error,
              child: child,
            ),
            child: SkeletonizerConfig(
              data: SkeletonizerConfigData(
                containersColor: theme.state.disabledColor.withValues(alpha: 0.1),
              ),
              child: MaterialApp.router(
                theme: theme.state,
                title: kAppName,
                debugShowCheckedModeBanner: false,
                routerConfig: Modular.routerConfig,
                onGenerateTitle: (context) => kAppName,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                builder: (context, child) => ScrollConfiguration(behavior: const CupertinoScrollBehavior(), child: child!),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
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
