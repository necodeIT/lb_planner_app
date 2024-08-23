import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Displays a chart overview of the user's tasks status.
class StatusOverview extends StatelessWidget {
  /// Displays a chart overview of the user's tasks status.
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
            const Row(),
          ],
        ),
      ),
    );
  }
}
