import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Implements the slot reservation feature.
class SlotsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<TitleBuilder>(() => (BuildContext context) => ('Slots', null));
  }

  @override
  void exportedBinds(Injector i) {
    i
      ..add<SlotsDatasource>(StdSlotsDatasource.new)
      ..addRepository<SlotsRepository>(SlotsRepository.new);
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
          CapabilityGuard({UserCapability.slotMaster}),
        ],
      )
      ..child(
        '/overview',
        child: (_) => const SlotOverviewScreen(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
        guards: [
          CapabilityGuard({UserCapability.teacher}),
        ],
      )
      ..child(
        '/book',
        child: (_) => const SlotReservationScreen(),
        transition: TransitionType.custom,
        customTransition: defaultTransition,
        guards: [
          CapabilityGuard({UserCapability.student}, redirectTo: '/dashboard/'),
        ],
      );
  }
}
