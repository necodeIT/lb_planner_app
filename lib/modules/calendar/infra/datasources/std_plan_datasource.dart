import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';

/// Standard [PlanDatasource] implementation.
class StdPlanDatasource extends PlanDatasource {
  final ApiService _apiService;

  /// Standard [PlanDatasource] implementation.
  StdPlanDatasource(this._apiService);

  @override
  void dispose() {
    super.dispose();
    _apiService.dispose();
  }

  @override
  Future<void> chmod(String token, int userId, PlanMemberAccessType accessType) async {
    log('Changing access type of user $userId to $accessType');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_update_access',
        token: token,
        body: {
          'memberid': userId,
          'accesstype': accessType.index,
        },
      );

      log('Access type of user $userId changed to $accessType');
    } catch (e, s) {
      log('Failed to change access type of user $userId to $accessType', e, s);
      rethrow;
    }
  }

  @override
  Future<CalendarPlan> getPlan(String token) async {
    log('Fetching plan');

    try {
      final response = await _apiService.callFunction(
        function: 'local_lbplanner_plan_get_plan',
        token: token,
        body: {},
      );

      response.assertJson();

      log('Plan fetched');

      return CalendarPlan.fromJson(response.asJson);
    } catch (e, s) {
      log('Failed to fetch plan', e, s);
      rethrow;
    }
  }

  @override
  Future<void> leavePlan(String token) async {
    log('Leaving plan');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_leave_plan',
        token: token,
        body: {},
      );

      log('Successfully left plan');
    } catch (e, s) {
      log('Failed to leave plan', e, s);
      rethrow;
    }
  }

  @override
  Future<void> removeMember(String token, int userId) async {
    log('Removing member $userId');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_remove_user',
        token: token,
        body: {
          'memberid': userId,
        },
      );

      log('Member $userId removed');
    } catch (e, s) {
      log('Failed to remove member $userId', e, s);
      rethrow;
    }
  }

  @override
  Future<void> updatePlan(String token, CalendarPlan plan) async {
    log('Updating plan');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_update_plan',
        token: token,
        body: {
          'planname': plan.name,
          'enableek': plan.optionalTasksEnabled,
        },
      );

      log('Plan updated');
    } catch (e, s) {
      log('Failed to update plan', e, s);
      rethrow;
    }
  }
}
