import 'dart:async';

import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides all courses for the entire moodle instance to the slot master.
class SlotMasterCoursesRepository extends Repository<AsyncValue<List<MoodleCourse>>> {
  final AuthRepository _auth;
  final MoodleCourseDatasource _courses;

  /// Repository for managing a user's [MoodleCourse]s.
  SlotMasterCoursesRepository(this._auth, this._courses) : super(AsyncValue.loading()) {
    watchAsync(_auth);
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    final transaction = startTransaction('loadSlotsMasterCourses');
    final tokens = waitForData(_auth);

    await guard(() => _courses.getAllCourses(tokens[Webservice.lb_planner_api]));
    await transaction.commit();
  }

  /// Filters the courses based on the given properties.
  ///
  /// All properties are optional and will be ignored if not provided.
  List<MoodleCourse> filter({bool? enabled, String? name, String? shortname, int? id, List<int> ids = const <int>[]}) {
    if (!state.hasData) {
      log('Cannot filter courses: No data available.');

      return [];
    }

    final courses = state.requireData;

    return courses.where((element) {
      if (id != null && element.id != id) return false;
      if (enabled != null && element.enabled != enabled) return false;
      if (name != null && !element.name.containsIgnoreCase(name)) return false;
      if (shortname != null && !element.shortname.containsIgnoreCase(shortname)) return false;
      if (ids.isNotEmpty && !ids.contains(element.id)) return false;

      return true;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _courses.dispose();
  }
}
