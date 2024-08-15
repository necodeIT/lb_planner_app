import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
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

    data(await _courses.getCourses(tokens[Webservice.lb_planner_api]));
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

  @override
  void dispose() {
    super.dispose();
    _courses.dispose();
  }
}
