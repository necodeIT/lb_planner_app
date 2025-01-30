library lb_planner.modules.app;

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';
import 'package:posthog_dart/posthog_dart.dart';

import 'infra/infra.dart';

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
        UpdaterModule(),
        MoodleModule(),
        CalendarModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<PostHog>(PostHog.new)
      ..setupReleasesRepository(
        appInfoService: StdAppInfoService.new,
        releasesDatasource: StdReleasesDatasource.new,
        patchService: switch (kDistributionType) {
          DistributionType.aur => AurParchService.new,
          DistributionType.msix => MsixPatchService.new,
          DistributionType.dmg => DmgPatchService.new,
          DistributionType.appImage => AppImagePatchService.new,
          DistributionType.web => WebPatchService.new,
        },
      );
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
      ..module(
        '/moodle',
        module: MoodleModule(),
        customTransition: defaultTransition,
        transition: TransitionType.custom,
        guards: [
          AuthGuard(redirectTo: '/auth/'),
        ],
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
            guards: [
              CapabilityGuard({UserCapability.student}, redirectTo: '/slots/'),
            ],
          ),
          ModuleRoute(
            '/calendar/',
            module: CalendarModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
            guards: [
              CapabilityGuard({UserCapability.student}, redirectTo: '/slots/'),
              // TODO: FeatureGuard([kCalendarPlanFeatureID]),
            ],
          ),
          ModuleRoute(
            '/settings/',
            module: SettingsModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
          ),
          ModuleRoute(
            '/slots/',
            module: SlotsModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
          ),
          ModuleRoute(
            '/course-overview/',
            module: CourseOverviewModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
            guards: [
              CapabilityGuard({UserCapability.student}, redirectTo: '/slots/'),
            ],
          ),
        ],
        customTransition: defaultTransition,
        transition: TransitionType.custom,
        guards: [
          AuthGuard(redirectTo: '/auth/'),
          HasCoursesGuard(),
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
