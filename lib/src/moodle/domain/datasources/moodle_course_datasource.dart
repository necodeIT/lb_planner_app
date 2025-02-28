import 'package:eduplanner/eduplanner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Datasource for fetching course data.
abstract class MoodleCourseDatasource extends Datasource with Tracable {
  @override
  String get name => 'MoodleCourse';

  /// Fetches all courses the user is enrolled in and that are compatible with the app.
  Future<List<MoodleCourse>> getCourses(String token);

  /// Fetches all courses.
  Future<List<MoodleCourse>> getAllCourses(String token);

  /// Updates the data for a given [course] and returns the updated course confirmed by the server.
  Future<MoodleCourse> updateCourse(String token, MoodleCourse course);
}
