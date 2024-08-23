import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Repository for managing a user's [MoodleCourse]s.
class MoodleCoursesRepository extends Repository<AsyncValue<List<MoodleCourse>>> {
  final AuthRepository _auth;
  final MoodleCourseDatasource _courses;
  final Ticks _ticks;

  /// Repository for managing a user's [MoodleCourse]s.
  MoodleCoursesRepository(this._auth, this._courses, this._ticks) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watch(_ticks);
  }

  @override
  Future<void> build(Type trigger) async {
    final tokens = _auth.state.requireData;

    await guard(() => _courses.getCourses(tokens[Webservice.lb_planner_api]));
  }

  /// Updates the given [course].
  Future<void> updateCourse(MoodleCourse course) async {
    if (!state.hasData) {
      log('Cannot update course: No data available.');

      return;
    }

    final tokens = _auth.state.requireData;

    await _courses.updateCourse(tokens[Webservice.lb_planner_api], course);
  }

  /// Enables or disables the given [course].
  Future<void> enableCourse(MoodleCourse course, {required bool enabled}) async {
    if (!state.hasData) {
      log('Cannot enable course: No data available.');

      return;
    }

    final courses = state.requireData;

    final index = courses.indexWhere((element) => element.id == course.id);

    if (index == -1) {
      log('Cannot enable course: Course not found.');

      return;
    }

    final updated = courses[index].copyWith(enabled: enabled);

    final updatedCourses = List<MoodleCourse>.from(courses)..[index] = updated;

    emit(AsyncValue.data(updatedCourses));

    await updateCourse(updated);
  }

  /// Filters the courses based on the given properties.
  ///
  /// All properties are optional and will be ignored if not provided.
  List<MoodleCourse> filter({bool? enabled, String? name, String? shortname, int? id}) {
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

      return true;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _courses.dispose();
  }
}
