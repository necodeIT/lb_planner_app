import 'package:lb_planner/modules/app/app.dart';

class StdMoodleCourseDatasource extends MoodleCourseDatasource {
  @override
  void dispose() {}

  @override
  Future<List<MoodleCourse>> getCourses(String token) {
    // TODO: implement getCourses
    throw UnimplementedError();
  }

  @override
  Future<MoodleCourse> updateCourse(String token, MoodleCourse course) {
    // TODO: implement updateCourse
    throw UnimplementedError();
  }
}
