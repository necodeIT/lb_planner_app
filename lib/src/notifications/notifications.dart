import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'infra/infra.dart';
import 'presentation/presentation.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module responsible for the notifications feature.
class NotificationsModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        MoodleModule(),
        AuthModule(),
      ];

  @override
  void binds(Injector i) => i
    ..add<NotificationsDatasource>(MoodleNotificationsDatasource.new)
    ..addRepository<NotificationsRepository>(NotificationsRepository.new);

  @override
  void routes(RouteManager r) {}
}
