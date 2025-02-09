import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:lb_planner/lb_planner.dart';

/// Prompts the user to select courses to include in the planning process.
class CourseSelectionScreen extends StatefulWidget {
  /// Prompts the user to select courses to include in the planning process.
  const CourseSelectionScreen({super.key});

  @override
  State<CourseSelectionScreen> createState() => _CourseSelectionScreenState();
}

class _CourseSelectionScreenState extends State<CourseSelectionScreen> {
  bool _checked = false;

  Future<void> preventMissfire() async {
    if (_checked) return;

    final user = context.read<UserRepository>();
    final repo = context.read<MoodleCoursesRepository>();

    await user.ready;
    await repo.ready;

    _checked = true;

    if (repo.filter(enabled: true).isNotEmpty || !(user.state.data?.capabilities.hasStudent ?? false)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Modular.to.navigate('/dashboard/');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<MoodleCoursesRepository>();

    DesktopGuard.listen(context);

    runAfterBuild(preventMissfire);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: Spacing.mediumSpacing,
            left: Spacing.mediumSpacing,
            child: Assets.moodle.courseSelection.themed(
              width: context.width * 0.45,
              context,
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: Text(
              context.t.moodle_courseSelectionScreen_selectCourses,
              style: context.textTheme.titleLarge,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 150),
              child: SizedBox(
                width: context.width * 0.4,
                height: context.height * 0.8,
                child: Column(
                  children: [
                    const CourseSelector().expanded(),
                    Spacing.mediumVertical(),
                    ElevatedButton(
                      onPressed: repo.filter(enabled: true).isNotEmpty ? () => Modular.to.navigate('/dashboard/') : null,
                      child: Text(context.t.global_continue),
                    ).stretch(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
