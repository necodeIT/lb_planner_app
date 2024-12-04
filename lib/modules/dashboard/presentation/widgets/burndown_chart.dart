import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/app/app.dart';

/// Renders a burndown chart of the user's tasks.
class BurndownChart extends StatelessWidget {
  /// Renders a burndown chart of the user's tasks.
  const BurndownChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(context.t.dashboard_burnDownChart, style: context.textTheme.titleMedium?.bold).alignAtTopLeft(),
          ],
        ),
      ),
    );
  }
}
