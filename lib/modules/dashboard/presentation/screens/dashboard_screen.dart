import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Renders the dashboard screen.
class DashboardScreen extends StatelessWidget {
  /// Renders the dashboard screen.
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stagger = AnimationStagger(const Duration(milliseconds: 50));

    return Padding(
      padding: PaddingAll(),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: const TodaysTasks().stretch(),
                ).show(stagger),
                Spacing.medium(),
                Expanded(
                  child: const TodaysTasks().stretch(),
                ).show(stagger),
              ],
            ),
          ),
          Spacing.medium(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  child: const StatusOverview().stretch(),
                ).show(stagger),
                Spacing.medium(),
                Expanded(
                  flex: 3,
                  child: const BurndownChart().stretch(),
                ).show(stagger),
              ],
            ),
          ),
          Spacing.medium(),
          Expanded(
            child: Column(
              children: [
                Expanded(child: const Exams().stretch()).show(stagger),
                Spacing.medium(),
                Expanded(
                  child: const TodaysTasks().stretch().withTooltip('Bla bla'),
                ).show(stagger),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
