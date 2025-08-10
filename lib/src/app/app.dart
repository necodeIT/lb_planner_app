library lb_planner.modules.app;

import 'package:animations/animations.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
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
          DistributionType.aur => AurPatchService.new,
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
              // apparently having a guard in a child route will override the parent's guard so we need it here too
              // Important to have this guard last as the order of guards is reversed
              AuthGuard(redirectTo: '/auth/'),
            ],
          ),
          ModuleRoute(
            '/calendar/',
            module: CalendarModule(),
            transition: TransitionType.custom,
            customTransition: defaultTransition,
            guards: [
              // FeatureGuard([kCalendarPlanFeatureID], redirectTo: '/settings/'),
              CapabilityGuard({UserCapability.student}, redirectTo: '/slots/'),
              AuthGuard(redirectTo: '/auth/'),
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
              AuthGuard(redirectTo: '/auth/'),
            ],
          ),
        ],
        customTransition: defaultTransition,
        transition: TransitionType.custom,
        guards: [
          HasCoursesGuard(),
          AuthGuard(redirectTo: '/auth/'),
        ],
      )
      ..module(
        '/auth',
        module: AuthModule(),
        customTransition: defaultTransition,
        transition: TransitionType.custom,
        guards: [],
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
      ..wildcard(child: (_) => const NotFoundScreen());
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
