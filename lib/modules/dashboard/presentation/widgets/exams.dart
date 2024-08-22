import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/dashboard/dashboard.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Exams extends StatelessWidget {
  const Exams({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>();

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.dashboard_exams,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            for (final task in tasks.filter(type: {MoodleTaskType.exam}, maxDeadlineDiff: const Duration(days: 7))) MoodleTaskWidget(task: task),
          ],
        ),
      ),
    );
  }
}
