import 'package:eduplanner/lb_planner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'infra/infra.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Implements the slot reservation feature.
class SlotsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
        MoodleModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<TitleBuilder>(() => (BuildContext context) => (context.t.slots_title, null))
      ..add<SlotsDatasource>(StdSlotsDatasource.new)
      ..addRepository<SlotsRepository>(SlotsRepository.new)
      ..addRepository<SlotMasterSlotsRepository>(SlotMasterSlotsRepository.new)
      ..addRepository<SlotMasterCoursesRepository>(SlotMasterCoursesRepository.new)
      ..addRepository<SupervisorSlotsRepository>(SupervisorSlotsRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        '/',
        child: (_) => const SlotMasterScreen(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
        guards: [
          CapabilityGuard({UserCapability.slotMaster}, redirectTo: '/slots/overview/'),
        ],
      )
      ..child(
        '/overview/',
        child: (_) => const SlotOverviewScreen(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
        guards: [
          CapabilityGuard({UserCapability.teacher}, redirectTo: '/slots/book/'),
        ],
      )
      ..child(
        '/overview/:id',
        child: (_) => SlotDetailsScreen(slotId: int.parse(r.args.params['id'])),
        guards: [
          CapabilityGuard({UserCapability.teacher}, redirectTo: '/slots/book/'),
        ],
      )
      ..child(
        '/book/',
        child: (_) => const SlotReservationScreen(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
        guards: [
          CapabilityGuard({UserCapability.student}, redirectTo: '/slots/'),
        ],
      );
  }
}
