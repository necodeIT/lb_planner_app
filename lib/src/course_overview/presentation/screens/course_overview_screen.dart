import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:collection/collection.dart';
import 'package:data_widget/data_widget.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// Displays an overview of all tasks for a course.
class CourseOverviewScreen extends StatefulWidget {
  /// Displays an overview of all tasks for a course.
  const CourseOverviewScreen({super.key, required this.id});

  /// The ID of the course to display.
  final int id;

  /// The date formatter.
  static final formatter = DateFormat('dd.MM.yyyy');

  @override
  State<CourseOverviewScreen> createState() => _CourseOverviewScreenState();
}

class _CourseOverviewScreenState extends State<CourseOverviewScreen> with AdaptiveState, NoMobile {
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

    Data.of<TitleBarState>(context)
      ..setParentRoute('/course-overview/')
      ..setSearchController(_searchController);
  }

  int sortColumn = 0;
  bool sortAscending = true;

  int Function(MoodleTask, MoodleTask) get sorter => switch (sortColumn) {
        (0) => (a, b) => a.name.compareTo(b.name),
        (1) => (a, b) => a.deadline?.compareTo(b.deadline ?? DateTime(0)) ?? 1,
        (2) => (a, b) => a.deadline?.compareTo(b.deadline ?? DateTime(0)) ?? 1,
        (3) => (a, b) => a.status.index.compareTo(b.status.index),
        (4) => (a, b) => a.type.index.compareTo(b.type.index),
        _ => (a, b) => 0,
      };

  // ignore: avoid_positional_boolean_parameters
  void sortBy(int column, bool ascending) {
    setState(() {
      sortColumn = column;
      sortAscending = ascending;
    });
  }

  @override
  Widget buildDesktop(BuildContext context) {
    final tasks = context.watch<MoodleTasksRepository>().filter(courseId: widget.id, query: _searchController.text)
      ..sort(
        (a, b) => sorter(a, b) * (sortAscending ? 1 : -1),
      );
    final deadlines = context.watch<CalendarPlanRepository>().filterDeadlines(taskIds: tasks.map((t) => t.id).toSet());

    final course = context.watch<MoodleCoursesRepository>().filter(id: widget.id).firstOrNull;

    return Padding(
      padding: PaddingAll(),
      child: Card(
        child: SingleChildScrollView(
          child: DataTable(
            sortColumnIndex: sortColumn,
            sortAscending: sortAscending,
            columns: [
              DataColumn(
                label: Text(context.t.courses_name),
                onSort: sortBy,
              ),
              DataColumn(
                label: Text(context.t.courses_type),
                onSort: sortBy,
              ),
              DataColumn(
                label: Text(context.t.courses_status),
                onSort: sortBy,
              ),
              DataColumn(
                label: Text(context.t.courses_dueDate),
                onSort: sortBy,
              ),
              DataColumn(
                label: Text(context.t.courses_plannedDueDate),
                onSort: sortBy,
              ),
              DataColumn(
                label: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onPressed: course != null
                      ? () {
                          launchUrlString(course.url);
                        }
                      : null,
                  icon: const Icon(
                    Icons.link,
                  ),
                ),
              ),
            ],
            rows: tasks.map(
              (t) {
                final planDeadline = deadlines.firstWhereOrNull((d) => d.id == t.id)?.start;

                return DataRow(
                  cells: [
                    DataCell(Text(t.name)),
                    DataCell(
                      Text(
                        t.type.translate(context),
                      ),
                    ),
                    DataCell(
                      Text(t.status.translate(context)),
                    ),
                    DataCell(
                      Text(
                        t.deadline != null ? CourseOverviewScreen.formatter.format(t.deadline!) : context.t.global_nA,
                      ),
                    ),
                    DataCell(
                      Text(
                        planDeadline != null ? CourseOverviewScreen.formatter.format(planDeadline) : context.t.global_nA,
                      ),
                    ),
                    DataCell(
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: () {
                          launchUrlString(t.url);
                        },
                        icon: Icon(
                          Icons.link,
                          color: context.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}
