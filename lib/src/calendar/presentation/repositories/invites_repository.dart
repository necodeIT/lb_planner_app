import 'dart:async';

import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds all invites for the current user
class InvitesRepository extends Repository<AsyncValue<List<PlanInvite>>> {
  final InvitesDatasource _invites;
  final AuthRepository _auth;
  final CalendarPlanRepository _plan;

  /// Holds all invites for the current user
  InvitesRepository(this._invites, this._auth, this._plan) : super(AsyncValue.loading()) {
    watchAsync(_auth);
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    final token = waitForData(_auth);

    await guard(
      () => _invites.getInvites(
        token.pick(Webservice.lb_planner_api),
      ),
    );
  }

  /// Invites the user with the given [userId] to the plan.
  Future<void> inviteUser(int userId) async {
    if (!state.hasData) {
      log('Cannot invite user: No plan loaded.');

      return;
    }

    try {
      await _invites.inviteUser(
        _auth.state.requireData[Webservice.lb_planner_api],
        userId,
      );

      await captureEvent('user_invited');

      await build(this);
    } catch (e, st) {
      log('Failed to invite user.', e, st);

      return;
    }
  }

  /// Declines the invite with the given [inviteId].
  Future<void> declineInvite(int inviteId) async {
    if (!state.hasData) {
      log('Cannot decline invite: No plan loaded.');

      return;
    }

    try {
      data(
        state.requireData.map((invite) {
          if (invite.id == inviteId) {
            return invite.copyWith(status: PlanInviteStatus.declined);
          }

          return invite;
        }).toList(),
      );

      await _invites.declineInvite(
        _auth.state.requireData[Webservice.lb_planner_api],
        inviteId,
      );

      await captureEvent('invite_declined');
    } catch (e, st) {
      log('Failed to decline invite.', e, st);

      return;
    }
  }

  /// Accepts the invite with the given [inviteId].
  Future<void> acceptInvite(int inviteId) async {
    if (!state.hasData) {
      log('Cannot accept invite: No plan loaded.');

      return;
    }

    try {
      data(
        state.requireData.map((invite) {
          if (invite.id == inviteId) {
            return invite.copyWith(status: PlanInviteStatus.accepted);
          }

          return invite;
        }).toList(),
      );

      await _invites.acceptInvite(
        _auth.state.requireData[Webservice.lb_planner_api],
        inviteId,
      );

      await captureEvent('invite_accepted');

      await _plan.build(this);
    } catch (e, st) {
      log('Failed to accept invite.', e, st);

      return;
    }
  }

  /// Returns a list of all invites that match the given filters.

  List<PlanInvite> filter({
    int? id,
    int? inviterId,
    int? inviteeId,
    PlanInviteStatus? status,
    int? planId,
  }) {
    if (!state.hasData) {
      log('Cannot filter invites: No data.');

      return [];
    }

    return state.requireData.where((invite) {
      if (id != null && invite.id != id) return false;
      if (inviterId != null && invite.inviterId != inviterId) return false;
      if (inviteeId != null && invite.invitedUserId != inviteeId) return false;
      if (status != null && invite.status != status) return false;
      if (planId != null && invite.planId != planId) return false;

      return true;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _invites.dispose();
  }
}
