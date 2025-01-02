import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/statistics/statistics.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Displays a chart overview of the user's tasks status.
class StatusOverview extends StatelessWidget {
  /// Displays a chart overview of the user's tasks status.
  const StatusOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<GlobalStatsRepository>();

    final stats = repo.state.data ??
        const TaskAggregate(
          status: StatusAggregate(done: 1, pending: 1, uploaded: 1, late: 1),
          type: TypeAggregate(required: 1, optional: 1, compensation: 1, exam: 1, none: 1),
        );

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Skeletonizer(
          enabled: !repo.state.hasData,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.t.dashboard_statusOverview,
                    style: context.textTheme.titleMedium?.bold,
                  ).alignAtTopLeft(),
                  if (repo.state.hasData)
                    Row(
                      children: [
                        _square(stats.status.done, context.theme.taskStatusTheme.doneColor, context),
                        _square(stats.status.uploaded, context.theme.taskStatusTheme.uploadedColor, context),
                        _square(stats.status.late, context.theme.taskStatusTheme.lateColor, context),
                        _square(stats.status.pending, context.theme.taskStatusTheme.pendingColor, context),
                      ].hSpaced(Spacing.smallSpacing).show(),
                    ),
                ],
              ),
              Expanded(
                child: HorizontalBarChart(
                  thickness: 12,
                  data: [
                    ChartValue(
                      name: context.t.enum_taskStatus_done,
                      value: stats.status.done.toDouble(),
                      percentage: stats.status.donePercentage,
                      color: context.theme.taskStatusTheme.doneColor,
                    ),
                    ChartValue(
                      name: context.t.enum_taskStatus_uploaded,
                      value: stats.status.uploaded.toDouble(),
                      percentage: stats.status.uploadedPercentage,
                      color: context.theme.taskStatusTheme.uploadedColor,
                    ),
                    ChartValue(
                      name: context.t.enum_taskStatus_late,
                      value: stats.status.late.toDouble(),
                      percentage: stats.status.latePercentage,
                      color: context.theme.taskStatusTheme.lateColor,
                    ),
                    ChartValue(
                      name: context.t.enum_taskStatus_pending,
                      value: stats.status.pending.toDouble(),
                      percentage: stats.status.pendingPercentage,
                      color: context.theme.taskStatusTheme.pendingColor,
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _square(int count, Color? color, BuildContext context) => Container(
        height: 25,
        width: 25,
        decoration: ShapeDecoration(
          shape: squircle(radius: 5),
          color: color,
          shadows: kElevationToShadow[1],
        ),
        child: Text(count.toString()).color(context.theme.colorScheme.onPrimary).bold().center().withTooltip(count.toString()),
      );
}
