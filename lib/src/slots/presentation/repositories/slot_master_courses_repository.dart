import 'dart:async';

import 'package:eduplanner/config/endpoints.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides all courses for the entire moodle instance to the slot master.
class SlotMasterCoursesRepository extends Repository<AsyncValue<List<MoodleCourse>>> with Tracable {
  final AuthRepository _auth;
  final MoodleCourseDatasource _courses;

  /// Repository for managing a user's [MoodleCourse]s.
  SlotMasterCoursesRepository(this._auth, this._courses) : super(AsyncValue.loading()) {
    watchAsync(_auth);

    _courses.parent = this;
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  @override
  FutureOr<void> build(Trigger trigger) async {
    final transaction = startTransaction('loadSlotsMasterCourses');
    final tokens = waitForData(_auth);

    await guard(
      () => _courses.getAllCourses(tokens[Webservice.lb_planner_api]),
      onData: (_) => log('Courses loaded.'),
      onError: (e, s) {
        log('Failed to load courses', e, s);
        transaction.internalError(e);
      },
    );
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
