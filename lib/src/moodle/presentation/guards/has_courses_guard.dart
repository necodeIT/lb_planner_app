import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/moodle/moodle.dart';

/// Guard that checks if the user has any courses enabled.
/// Redirects to the course selection screen per default if no courses are enabled.
class HasCoursesGuard extends RouteGuard {
  /// Guard that checks if the user has any courses enabled.
  /// Redirects to the course selection screen per default if no courses are enabled.
  HasCoursesGuard({super.redirectTo = '/moodle/select-courses/'});

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final courses = Modular.get<MoodleCoursesRepository>();

    await courses.build(HasCoursesGuard);

    return courses.filter(enabled: true).isNotEmpty;
  }
}
