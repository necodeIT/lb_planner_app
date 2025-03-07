import 'package:data_widget/data_widget.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays an overview of all courses.
class CoursesOverviewScreen extends StatefulWidget {
  /// Displays an overview of all courses.
  const CoursesOverviewScreen({super.key});

  @override
  State<CoursesOverviewScreen> createState() => _CoursesOverviewScreenState();
}

class _CoursesOverviewScreenState extends State<CoursesOverviewScreen> with AdaptiveState, NoMobile {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Data.of<TitleBarState>(context).setSearchController(_searchController);
  }

  @override
  Widget buildDesktop(BuildContext context) {
    final repo = context.watch<MoodleCoursesRepository>();

    final courses = repo.filter(enabled: true, name: _searchController.text);

    return Padding(
      padding: PaddingAll(),
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: Spacing.mediumSpacing,
          spacing: Spacing.mediumSpacing,
          children: [
            for (final course in courses)
              CourseOverviewCourse(
                key: ValueKey('course_overview_${course.id}'),
                course: course,
              ),
          ].show(),
        ),
      ),
    );
  }
}
