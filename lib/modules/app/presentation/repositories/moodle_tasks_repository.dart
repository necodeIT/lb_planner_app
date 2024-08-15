import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Provides all tasks from Moodle with the latest updates.
class MoodleTasksRepository extends Repository<AsyncValue<List<MoodleTask>>> {
  final MoodleTaskDatasource _tasks;
  final AuthRepository _auth;
  final Ticks _ticks;

  /// Provides all tasks from Moodle with the latest updates.
  MoodleTasksRepository(this._tasks, this._auth, this._ticks) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watch(_ticks);
  }

  @override
  Future<void> build(Type trigger) async {
    final tokens = _auth.state.requireData;

    data(await _tasks.getTasks(tokens[Webservice.lb_planner_api]));
  }

  @override
  void dispose() {
    super.dispose();
    _tasks.dispose();
  }
}
