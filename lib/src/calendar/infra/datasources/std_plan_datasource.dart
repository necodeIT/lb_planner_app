import 'package:lb_planner/lb_planner.dart';

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
    final transaction = startTransaction('chmod');

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
      transaction.internalError(e);

      log('Failed to change access type of user $userId to $accessType', e, s);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<CalendarPlan> getPlan(String token) async {
    final transaction = startTransaction('getPlan');

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
      transaction.internalError(e);
      log('Failed to fetch plan', e, s);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> leavePlan(String token) async {
    final transaction = startTransaction('leavePlan');
    log('Leaving plan');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_leave_plan',
        token: token,
        body: {},
      );

      log('Successfully left plan');
    } catch (e, s) {
      transaction.internalError(e);
      log('Failed to leave plan', e, s);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> removeMember(String token, int userId) async {
    final transaction = startTransaction('removeMember');

    log('Removing member $userId');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_remove_user',
        token: token,
        body: {
          'userid': userId,
        },
      );

      log('Member $userId removed');
    } catch (e, s) {
      transaction.internalError(e);
      log('Failed to remove member $userId', e, s);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> updatePlan(String token, CalendarPlan plan) async {
    final transaction = startTransaction('updatePlan');
    log('Updating plan');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_update_plan',
        token: token,
        body: {
          'planname': plan.name,
        },
      );

      log('Plan updated');
    } catch (e, s) {
      transaction.internalError(e);
      log('Failed to update plan', e, s);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }
}
