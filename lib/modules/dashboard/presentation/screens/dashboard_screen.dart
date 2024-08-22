import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 200);

    final stagger = AnimationStagger(const Duration(milliseconds: 50));

    return Padding(
      padding: PaddingAll(Spacing.mediumSpacing),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: const TodaysTasks().stretch(),
                ).animate().scale(duration: duration, delay: stagger.add(), curve: Curves.easeOutCubic),
                Spacing.medium(),
                Expanded(
                  child: const TodaysTasks().stretch(),
                ).animate().scale(duration: duration, delay: stagger.add(), curve: Curves.easeOutCubic),
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
                ).animate().scale(duration: duration, delay: stagger.add(), curve: Curves.easeOutCubic),
                Spacing.medium(),
                Expanded(
                  flex: 3,
                  child: const BurndownChart().stretch(),
                ).animate().scale(duration: duration, delay: stagger.add(), curve: Curves.easeOutCubic),
              ],
            ),
          ),
          Spacing.medium(),
          Expanded(
            child: Column(
              children: [
                Expanded(child: const TodaysTasks().stretch()).animate().scale(duration: duration, delay: stagger.add(), curve: Curves.easeOutCubic),
                Spacing.medium(),
                Expanded(
                  child: const TodaysTasks().stretch(),
                ).animate().scale(duration: duration, delay: stagger.add(), curve: Curves.easeOutCubic),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
