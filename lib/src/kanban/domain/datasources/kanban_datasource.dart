import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:eduplanner/src/kanban/kanban.dart';

abstract class KanbanDatasource extends Datasource {
  @override
  String get name => 'Kanban';

  Future<KanbanBoard> getBoard(String token);

  Future<void> move(String token, {required int taskId, required KanbanColumn to});
}
