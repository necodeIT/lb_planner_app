import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:lb_planner/src/moodle/moodle.dart';

/// Standard [DeadlinesDatasource] implementation.
class StdDeadlinesDatasource extends DeadlinesDatasource {
  final ApiService _apiService;

  /// Standard [DeadlinesDatasource] implementation.
  StdDeadlinesDatasource(this._apiService);

  @override
  void dispose() {
    super.dispose();
    _apiService.dispose();
  }

  @override
  Future<void> clearDeadlines(String token) async {
    final transaction = startTransaction('clearDeadlines');
    log('Clearing deadlines');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_clear_plan',
        token: token,
        body: {},
      );

      log('Deadlines cleared');
    } catch (e, s) {
      log('Failed to clear deadlines', e, s);
      rethrow;
    } finally {
      await transaction.finish();
    }
  }

  @override
  Future<void> removeDeadline(String token, int id) async {
    final transaction = startTransaction('removeDeadline');
    log('Removing deadline $id');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_delete_deadline',
        token: token,
        body: {
          'moduleid': id,
        },
      );

      log('Deadline $id removed');
    } catch (e, s) {
      log('Failed to remove deadline $id', e, s);
      rethrow;
    } finally {
      await transaction.finish();
    }
  }

  @override
  Future<void> setDeadline(String token, PlanDeadline deadline) async {
    final transaction = startTransaction('setDeadline');
    log('Setting deadline ${deadline.id}');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_set_deadline',
        token: token,
        body: deadline.toJson(),
      );

      log('Deadline ${deadline.id} set');
    } catch (e, s) {
      log('Failed to set deadline $deadline', e, s);
      rethrow;
    } finally {
      await transaction.finish();
    }
  }
}
