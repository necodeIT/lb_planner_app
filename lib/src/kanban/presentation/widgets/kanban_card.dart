import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// A card within a kanban column.
class KanbanCard extends StatelessWidget {
  /// A card within a kanban column.
  const KanbanCard({super.key, required this.task});

  /// The task represented by this card.
  final MoodleTask task;

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<MoodleCoursesRepository>();

    final course = courses.getById(task.courseId);

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Skeletonizer(
                enabled: course == null,
                child: CourseTag(course: course ?? MoodleCourse.skeleton()),
              ),
              Text(
                task.name,
              ),
              const SizedBox.expand(),
              Row(
                children: [
                  Icon(
                    FontAwesome5Solid.circle,
                    size: 12,
                    color: context.theme.taskStatusTheme.colorOf(task.status),
                  ),
                  Text(task.status.translate(context)),
                ],
              ),
            ],
          ),
          Spacing.xsVertical(),
        ],
      ),
    );
  }
}
