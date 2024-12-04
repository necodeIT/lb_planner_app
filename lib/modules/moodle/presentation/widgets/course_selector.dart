import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Displays a form where the user can search for courses and enable/disable them.
class CourseSelector extends StatefulWidget {
  /// Displays a form where the user can search for courses and enable/disable them.
  const CourseSelector({super.key});

  @override
  State<CourseSelector> createState() => _CourseSelectorState();
}

class _CourseSelectorState extends State<CourseSelector> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final courses = context.watch<MoodleCoursesRepository>();

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              style: context.textTheme.bodyMedium,
              decoration: InputDecoration(
                filled: true,
                hintText: context.t.moodle_courseSelector_search,
                prefixIcon: const Icon(Icons.search),
                fillColor: context.theme.scaffoldBackgroundColor,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Spacing.mediumVertical(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    if (courses.state.hasData)
                      for (final course in courses.filter(name: _searchController.text))
                        CourseWidget(
                          key: ValueKey(course.id),
                          course: course,
                        ),
                    if (!courses.state.hasData)
                      for (int i = 0; i < 5; i++)
                        Container(
                          height: 30,
                          decoration: ShapeDecoration(
                            shape: squircle(),
                            color: context.theme.colorScheme.surface,
                          ),
                        ).stretch().applyShimmerThemed(context),
                  ].vSpaced(courses.state.hasData ? Spacing.xsSpacing : Spacing.smallSpacing).show(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
