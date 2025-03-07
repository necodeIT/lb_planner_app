import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Renders the dashboard screen.
class DashboardScreen extends StatelessWidget with AdaptiveWidget {
  /// Renders the dashboard screen.
  const DashboardScreen({super.key});

  @override
  Widget buildDesktop(BuildContext context) {
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
                  child: const OverdueTasks().stretch(),
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
                  flex: 4,
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
                  child: const ReservedSlots().stretch(),
                ).show(stagger),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.4,
              width: context.width - PaddingAll().horizontal * 2,
              child: const StatusOverview(),
            ),
            const TodaysTasks().stretch(),
            const OverdueTasks().stretch(),
            const Exams().stretch(),
            const ReservedSlots().stretch().static(),
          ].show(),
        ),
      ),
    );
  }
}
