import 'package:eduplanner/eduplanner.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

import 'infra/infra.dart';

export 'package:eduplanner/src/auth/auth.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module handling communication with the Moodle API.
class MoodleModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        AuthModule(),
      ];

  @override
  void exportedBinds(Injector i) {
    i
      ..add<MoodleCourseDatasource>(StdMoodleCourseDatasource.new)
      ..addRepository<MoodleCoursesRepository>(MoodleCoursesRepository.new)
      ..addSerde<MoodleCourse>(fromJson: MoodleCourse.fromJson, toJson: (c) => c.toJson())
      ..add<MoodleTaskDatasource>(StdMoodleTaskDatasource.new)
      ..addRepository<MoodleTasksRepository>(MoodleTasksRepository.new)
      ..addSerde<MoodleTask>(fromJson: MoodleTask.fromJson, toJson: (t) => t.toJson())
      ..addRepository<UsersRepository>(UsersRepository.new);
  }

  @override
  void routes(RouteManager r) {
    r
      ..child(
        '/select-courses/',
        child: (_) => const CourseSelectionScreen(),
      )
      ..wildcard(child: (_) => const NotFoundScreen());
  }
}
