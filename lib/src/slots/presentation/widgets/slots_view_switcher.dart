import 'package:eduplanner/eduplanner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:eduplanner/src/slots/slots.dart';
import 'package:eduplanner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SlotsViewSwitcher extends StatelessWidget {
  const SlotsViewSwitcher({super.key});

  static const capabilityToRoute = {
    UserCapability.slotMaster: '/slots/',
    UserCapability.teacher: '/slots/overview/',
    UserCapability.student: '/slots/book/',
  };

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();

    return Container();
  }
}
