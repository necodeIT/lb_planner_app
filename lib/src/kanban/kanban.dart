import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

import 'infra/infra.dart';

export 'domain/domain.dart';
export 'presentation/presentation.dart';
export 'utils/utils.dart';

/// Module for the Kanban board feature.
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
      ..add<KanbanDatasource>(MoodleKanbanDatasource.new)
      ..add<TitleBuilder>(() => (BuildContext context) => (context.t.kanban_title, null))
      ..addRepository<KanbanRepository>(KanbanRepository.new);
  }

  @override
  void exportedBinds(Injector i) {}

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const KanbanScreen());
  }
}
