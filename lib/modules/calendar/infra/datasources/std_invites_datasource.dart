import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';

/// Standard [InvitesDatasource] implementation.
class StdInvitesDatasource extends InvitesDatasource {
  final ApiService _apiService;

  /// Standard [InvitesDatasource] implementation.
  StdInvitesDatasource(this._apiService);

  @override
  void dispose() {
    _apiService.dispose();
  }

  @override
  Future<void> acceptInvite(String token, int id) async {
    log('Accepting invite $id');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_accept_invite',
        token: token,
        body: {
          'inviteid': id,
        },
      );

      log('Invite $id accepted');
    } catch (e, s) {
      log('Failed to accept invite $id', e, s);
      rethrow;
    }
  }

  @override
  Future<void> declineInvite(String token, int id) async {
    log('Declining invite $id');

    try {
      await _apiService.callFunction(
        function: 'local_lbplanner_plan_decline_invite',
        token: token,
        body: {
          'inviteid': id,
        },
      );

      log('Invite $id declined');
    } catch (e, s) {
      log('Failed to decline invite $id', e, s);
      rethrow;
    }
  }

  @override
  Future<List<PlanInvite>> getInvites(String token) async {
    log('Getting invites');

    try {
      final response = await _apiService.callFunction(
        function: 'local_lbplanner_plan_get_invites',
        token: token,
        body: {},
      );

      response.assertList();

      final invites = response.asList.map(PlanInvite.fromJson).toList();

      log('Got ${invites.length} invites');

      return invites;
    } catch (e, s) {
      log('Failed to get invites', e, s);
      rethrow;
    }
  }

  @override
  Future<PlanInvite> inviteUser(String token, int userId) async {
    log('Inviting user $userId');

    try {
      final response = await _apiService.callFunction(
        function: 'local_lbplanner_plan_invite_user',
        token: token,
        body: {
          'inviteeid': userId,
        },
      );

      response.assertJson();

      log('User $userId invited');

      return PlanInvite.fromJson(response.asJson);
    } catch (e, s) {
      log('Failed to invite user $userId', e, s);
      rethrow;
    }
  }
}
