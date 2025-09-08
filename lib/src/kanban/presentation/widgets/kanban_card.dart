import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:context_menus/context_menus.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart';
import 'package:url_launcher/url_launcher.dart';

/// A card within a kanban column.
class KanbanCard extends StatelessWidget {
  /// A card within a kanban column.
  const KanbanCard({super.key, required this.task});

  /// The task represented by this card.
  final MoodleTask task;

  /// Used to keep the same size when [Draggable] is activated.
  static double lastKnownWidth = 300;

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<MoodleCoursesRepository>();
    final calendar = context.watch<CalendarPlanRepository>();

    final course = courses.getById(task.courseId);

    final planned = calendar.filterDeadlines(taskIds: {task.id}).firstOrNull;

    return LayoutBuilder(
      builder: (context, size) {
        lastKnownWidth = size.maxWidth;
        return ContextMenuRegion(
          contextMenu: GenericContextMenu(
            buttonConfigs: [
              ContextMenuButtonConfig(
                context.t.moodle_moodleTaskWidget_openInMoodle,
                onPressed: () => launchUrl(Uri.parse(task.url)),
                icon: const Icon(Icons.link),
                iconHover: Icon(Icons.link, color: context.theme.colorScheme.primary),
              ),
            ],
          ),
          child: SizedBox(
            height: 150,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: PaddingAll(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: Spacing.smallSpacing,
                      children: [
                        Skeletonizer(
                          enabled: course == null,
                          child: CourseTag(course: course ?? MoodleCourse.skeleton()),
                        ),
                        Text(
                          task.name,
                        ).bold(),
                      ],
                    ).stretch(),
                    Spacing.xsVertical(),
                    Column(
                      spacing: Spacing.xsSpacing,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          spacing: Spacing.smallSpacing,
                          children: [
                            Icon(
                              FontAwesome5Solid.circle,
                              size: 12,
                              color: context.theme.taskStatusTheme.colorOf(task.status),
                            ),
                            Text(task.status.translate(context)),
                          ],
                        ).stretch(),
                        if (task.deadline != null)
                          Row(
                            spacing: Spacing.xsSpacing,
                            children: [
                              const Icon(Icons.calendar_month, size: 16),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: context.t.kanban_card_dueOn(format(task.deadline!, allowFromNow: true)),
                                    ),
                                    const TextSpan(text: ' ('),
                                    TextSpan(
                                      text: CourseOverviewScreen.formatter.format(task.deadline!),
                                      style: context.theme.textTheme.bodyMedium?.bold,
                                    ),
                                    const TextSpan(text: ')'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        if (planned != null)
                          Row(
                            spacing: Spacing.xsSpacing,
                            children: [
                              const Icon(Icons.timelapse_rounded, size: 16),
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: context.t.kanban_card_plannedOn(format(planned.end, allowFromNow: true)),
                                    ),
                                    const TextSpan(text: ' ('),
                                    TextSpan(
                                      text: CourseOverviewScreen.formatter.format(planned.end),
                                      style: context.theme.textTheme.bodyMedium?.bold,
                                    ),
                                    const TextSpan(text: ')'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ).expanded(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
