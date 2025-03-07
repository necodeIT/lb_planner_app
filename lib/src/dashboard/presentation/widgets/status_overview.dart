import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Displays a chart overview of the user's tasks status.
class StatusOverview extends StatelessWidget with AdaptiveWidget {
  /// Displays a chart overview of the user's tasks status.
  const StatusOverview({super.key});

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

  @override
  Widget buildDesktop(BuildContext context) {
    final repo = context.watch<GlobalStatsRepository>();

    final stats = repo.state.data ?? TaskAggregate.dummy();

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
                      name: MoodleTaskStatus.done.translate(context),
                      value: stats.status.done.toDouble(),
                      percentage: stats.status.donePercentage,
                      color: context.theme.taskStatusTheme.doneColor,
                    ),
                    ChartValue(
                      name: MoodleTaskStatus.uploaded.translate(context),
                      value: stats.status.uploaded.toDouble(),
                      percentage: stats.status.uploadedPercentage,
                      color: context.theme.taskStatusTheme.uploadedColor,
                    ),
                    ChartValue(
                      name: MoodleTaskStatus.late.translate(context),
                      value: stats.status.late.toDouble(),
                      percentage: stats.status.latePercentage,
                      color: context.theme.taskStatusTheme.lateColor,
                    ),
                    ChartValue(
                      name: MoodleTaskStatus.pending.translate(context),
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

  @override
  Widget buildMobile(BuildContext context) {
    final repo = context.watch<GlobalStatsRepository>();

    final stats = repo.state.data ?? TaskAggregate.dummy();

    final statusTheme = context.theme.taskStatusTheme;

    return Column(
      children: [
        Expanded(
          child: CircularChart(
            thickness: 10,
            delay: const Duration(milliseconds: 350),
            data: [
              ChartValue(
                name: MoodleTaskStatus.done.translate(context),
                value: stats.status.done.toDouble(),
                percentage: stats.status.donePercentage,
                color: statusTheme.doneColor,
              ),
              ChartValue(
                name: MoodleTaskStatus.uploaded.translate(context),
                value: stats.status.uploaded.toDouble(),
                percentage: stats.status.uploadedPercentage,
                color: statusTheme.uploadedColor,
              ),
              ChartValue(
                name: MoodleTaskStatus.late.translate(context),
                value: stats.status.late.toDouble(),
                percentage: stats.status.latePercentage,
                color: statusTheme.lateColor,
              ),
              ChartValue(
                name: MoodleTaskStatus.pending.translate(context),
                value: stats.status.pending.toDouble(),
                percentage: stats.status.pendingPercentage,
                color: statusTheme.pendingColor,
              ),
            ],
          ),
        ),
        Spacing.mediumVertical(),
        Wrap(
          runSpacing: Spacing.smallSpacing,
          spacing: Spacing.smallSpacing,
          children: [
            for (final status in MoodleTaskStatus.values)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    color: context.theme.taskStatusTheme.colorOf(status),
                    size: 10,
                  ),
                  Spacing.xsHorizontal(),
                  Text(status.translate(context)),
                ],
              ),
          ],
        ),
        Spacing.mediumVertical(),
      ],
    );
  }
}
