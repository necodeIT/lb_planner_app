library lb_planner.modules.app;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/notifications/notifications.dart';
import 'package:lb_planner/modules/settings/settings.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:posthog_dart/posthog_dart.dart';
import 'package:posthog_flutter/posthog_flutter.dart';

import 'presentation/presentation.dart';

export 'package:flutter_utils/flutter_utils.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Global route observer for the application.
final kRouteObserver = RouteObserver();

/// Root module of the application.
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
        ThemingModule(),
        NotificationsModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<PostHog>(PostHog.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..module(
        '/auth',
        module: AuthModule(),
        customTransition: defaultTransition,
        transition: TransitionType.custom,
      )
      ..child(
        '/',
        child: (_) => const SidebarScreen(),
        children: [
          ModuleRoute(
            '/dashboard/',
            module: DashboardModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
          ),
          ModuleRoute(
            '/calendar/',
            module: CalendarModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
          ),
          ModuleRoute(
            '/settings/',
            module: SettingsModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
          ),
        ],
        customTransition: defaultTransition,
        transition: TransitionType.custom,
        guards: [
          AuthGuard(redirectTo: '/auth/'),
        ],
      );
  }
}

/// The default page transition for the application.
///
/// **Usage:**
///
/// ```dart
/// r.module(
///  '/my-module',
///   module: MyModule(),
///   customTransition: defaultTransition,
///   transition: TransitionType.custom,
/// );
///
/// r.child(
///   '/my-child',
///    child: (_) => const MyChild(),
///    customTransition: defaultTransition,
///    transition: TransitionType.custom,
/// );
/// ```
final defaultTransition = CustomTransition(
  transitionBuilder: (context, animation, secondaryAnimation, child) {
    return SharedAxisTransition(
      transitionType: SharedAxisTransitionType.vertical,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      fillColor: Colors.transparent,
      child: child,
    );
  },
);
