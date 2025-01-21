import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:lb_planner/src/course_overview/course_overview.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A course tile for the course overview screen.
class CourseOverviewCourse extends StatelessWidget {
  /// A course tile for the course overview screen.
  const CourseOverviewCourse({super.key, required this.course});

  /// The course to display.
  final MoodleCourse course;

  @override
  Widget build(BuildContext context) {
    final stats = context.watch<CourseStatsRepository>();

    final data = (stats.getCourseStats(course.id) ?? TaskAggregate.dummy()).status;

    return SizedBox(
      width: 400,
      height: 250,
      child: Skeletonizer(
        enabled: !stats.state.hasData,
        child: OffsetOnHover(
          onTap: () {
            Modular.to.pushNamed('/course-overview/${course.id}');
          },
          offset: const Offset(0, -10),
          duration: const Duration(milliseconds: 200),
          child: Card(
            child: Padding(
              padding: PaddingAll(Spacing.mediumSpacing),
              child: Column(
                children: [
                  Row(
                    children: [
                      CourseTag(course: course),
                      Spacing.smallHorizontal(),
                      Text(course.name).bold(),
                      const Spacer(),
                      Text('${data.total} Tasks'),
                    ],
                  ),
                  Spacing.medium(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _legend(
                            status: MoodleTaskStatus.done,
                            color: context.taskStatusTheme.doneColor,
                            context: context,
                            amount: data.done,
                          ),
                          _legend(
                            status: MoodleTaskStatus.uploaded,
                            color: context.taskStatusTheme.uploadedColor,
                            context: context,
                            amount: data.uploaded,
                          ),
                          _legend(
                            status: MoodleTaskStatus.late,
                            color: context.taskStatusTheme.lateColor,
                            context: context,
                            amount: data.late,
                          ),
                          _legend(
                            status: MoodleTaskStatus.pending,
                            color: context.taskStatusTheme.pendingColor,
                            context: context,
                            amount: data.pending,
                          ),
                        ].vSpaced(Spacing.smallSpacing),
                      ),
                      Spacing.largeHorizontal(),
                      VerticalBarChart(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: Spacing.mediumSpacing,
                        data: [
                          ChartValue(
                            name: MoodleTaskStatus.done.translate(context),
                            value: data.done.toDouble(),
                            percentage: data.donePercentage,
                            color: context.taskStatusTheme.doneColor,
                          ),
                          ChartValue(
                            name: MoodleTaskStatus.uploaded.translate(context),
                            value: data.uploaded.toDouble(),
                            percentage: data.uploadedPercentage,
                            color: context.taskStatusTheme.uploadedColor,
                          ),
                          ChartValue(
                            name: MoodleTaskStatus.late.translate(context),
                            value: data.late.toDouble(),
                            percentage: data.latePercentage,
                            color: context.taskStatusTheme.lateColor,
                          ),
                          ChartValue(
                            name: MoodleTaskStatus.pending.translate(context),
                            value: data.pending.toDouble(),
                            percentage: data.pendingPercentage,
                            color: context.taskStatusTheme.pendingColor,
                          ),
                        ],
                        shape: squircle(),
                        thickness: 12,
                      ).expanded(),
                    ],
                  ).expanded(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _legend({required MoodleTaskStatus status, required Color color, required BuildContext context, required int amount}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(500),
          ),
        ),
        Spacing.smallHorizontal(),
        Text('${status.translate(context)}: $amount'),
      ],
    );
  }
}
