import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Guard that checks if the user has any courses enabled.
/// Redirects to the course selection screen per default if no courses are enabled.
class HasCoursesGuard extends RouteGuard implements BuildTrigger {
  /// Guard that checks if the user has any courses enabled.
  /// Redirects to the course selection screen per default if no courses are enabled.
  HasCoursesGuard({super.redirectTo = '/moodle/select-courses/'});

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final courses = Modular.tryGet<MoodleCoursesRepository>();
    final user = Modular.tryGet<UserRepository>();

    if (courses == null || user == null) return false;

    await courses.ready;
    await user.ready;

    if (!user.state.hasData) return false;

    if (!user.state.requireData.capabilities.hasStudent) return true;

    await courses.build(this);

    return courses.filter(enabled: true).isNotEmpty;
  }
}
