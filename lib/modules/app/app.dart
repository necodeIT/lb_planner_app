library lb_planner.modules.app;

import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/app/infra/infra.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Root module of the application.
class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<ApiService>(MoodleApiService.new)
      ..add<MoodleCourseDatasource>(StdMoodleCourseDatasource.new)
      ..addRepository<MoodleCoursesRepository>(MoodleCoursesRepository.new)
      ..addSerde<MoodleCourse>(fromJson: MoodleCourse.fromJson, toJson: (c) => c.toJson())
      ..add<MoodleTaskDatasource>(StdMoodleTaskDatasource.new)
      ..addRepository<MoodleTasksRepository>(MoodleTasksRepository.new)
      ..addSerde<MoodleTask>(fromJson: MoodleTask.fromJson, toJson: (t) => t.toJson())
      ..addTickRepository(const TickInterval(milliseconds: kRefreshInterval));
  }

  @override
  void routes(RouteManager r) {
    r.module('/auth', module: AuthModule());
  }
}
