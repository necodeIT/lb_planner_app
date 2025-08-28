import 'package:eduplanner/eduplanner.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'domain/domain.dart';
import 'presentation/presentation.dart';
import 'infra/infra.dart';
import 'utils/utils.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

class KanbanModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
        MoodleModule(),
        AuthModule(),
      ];

  @override
  void binds(Injector i) {
    i
      ..add<KanbanDatasource>(LocalKanbanDatasource.new)
      ..add<TitleBuilder>(() => (BuildContext context) => ('Kanban Board', null))
      ..addRepository<KanbanRepository>(KanbanRepository.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const KanbanScreen());
  }
}
