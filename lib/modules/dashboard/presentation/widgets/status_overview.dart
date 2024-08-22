import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lb_planner/modules/app/app.dart';

class StatusOverview extends StatelessWidget {
  const StatusOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  context.t.dashboard_statusOverview,
                  style: context.textTheme.titleMedium?.bold,
                ).alignAtTopLeft(),
              ],
            ),
            Row(),
          ],
        ),
      ),
    );
  }
}
