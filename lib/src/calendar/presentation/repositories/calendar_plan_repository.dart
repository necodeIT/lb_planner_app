import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Repository for managing a user's [CalendarPlan].
class CalendarPlanRepository extends Repository<AsyncValue<CalendarPlan>> {
  final PlanDatasource _plan;
  final DeadlinesDatasource _deadlines;
  final AuthRepository _auth;
  final ConnectivityService _connectivity;
  final MoodleTasksRepository _tasks;
  final InvitesDatasource _invites;

  /// Repository for managing a user's [CalendarPlan].
  CalendarPlanRepository(
    this._plan,
    this._deadlines,
    this._auth,
    this._connectivity,
    this._tasks,
    this._invites,
  ) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watchAsync(_tasks, setError: false, setLoading: false);
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  @override
  Future<void> build(Type trigger) async {
    // We don't need to refresh the plan as it's only loosely connected to the tasks.
    if (trigger == MoodleTasksRepository) {
      log('Skipping refresh triggered by $trigger');

      return;
    }

    await _loadPlan(waitForData(_auth));
  }

  Future<void> _loadPlan(Set<Token> tokens) async {
    log('Loading plan...');

    if (tokens.isEmpty) {
      log('Cannot load plan: No tokens provided.');

      return;
    }

    if (!_connectivity.isConnected) {
      log('Cannot load plan: No internet connection. Skipping to preserve chached data.');

      return;
    }

    await guard(
      () => _plan.getPlan(tokens[Webservice.lb_planner_api]),
      onData: (_) => log('Plan loaded.'),
      onError: (e, s) => log('Failed to load plan.', e, s),
    );
  }

  /// Clears the plan.
  Future<void> clear() async {
    if (!state.hasData) {
      log('Cannot clear plan: No plan loaded.');

      return;
    }

    try {
      data(state.requireData.copyWith(deadlines: []));

      await _deadlines.clearDeadlines(_auth.state.requireData[Webservice.lb_planner_api]);

      log('Plan cleared.');

      await captureEvent('plan_cleared');
    } catch (e, st) {
      log('Failed to clear plan.', e, st);

      return;
    }
  }

  /// Sets a deadline for the given [taskId].
  Future<void> setDeadline(int taskId, DateTime start, DateTime end) async {
    if (!state.hasData) {
      log('Cannot set deadline: No plan loaded.');

      return;
    }

    try {
      final deadline = PlanDeadline(
        id: taskId,
        start: start,
        end: end,
      );

      data(
        state.requireData.copyWith(
          deadlines: [
            ...state.requireData.deadlines.where((d) => d.id != taskId),
            deadline,
          ],
        ),
      );

      await _deadlines.setDeadline(
        _auth.state.requireData[Webservice.lb_planner_api],
        deadline,
      );

      log('Deadline set.');

      await captureEvent('deadline_set', properties: {'id': taskId, 'start': start, 'end': end});
    } catch (e, st) {
      log('Failed to set deadline.', e, st);

      return;
    }
  }

  /// Removes the deadline with the given [id].
  Future<void> removeDeadline(int id) async {
    if (!state.hasData) {
      log('Cannot remove deadline: No plan loaded.');

      return;
    }

    try {
      data(
        state.requireData.copyWith(
          deadlines: state.requireData.deadlines.where((d) => d.id != id).toList(),
        ),
      );

      await _deadlines.removeDeadline(
        _auth.state.requireData[Webservice.lb_planner_api],
        id,
      );

      log('Deadline removed.');

      await captureEvent('deadline_removed', properties: {'id': id});
    } catch (e, st) {
      log('Failed to remove deadline.', e, st);

      return;
    }
  }

  /// Leaves the shared plan.
  Future<void> leavePlan() async {
    if (!state.hasData) {
      log('Cannot leave plan: No plan loaded.');

      return;
    }

    try {
      await _plan.leavePlan(_auth.state.requireData[Webservice.lb_planner_api]);

      await captureEvent('plan_left');
    } catch (e, st) {
      log('Failed to leave plan.', e, st);

      return;
    }
  }

  /// Removes the member with the given [userId].
  Future<void> kick(int userId) async {
    if (!state.hasData) {
      log('Cannot remove member: No plan loaded.');

      return;
    }

    try {
      await _plan.removeMember(
        _auth.state.requireData[Webservice.lb_planner_api],
        userId,
      );

      await captureEvent('member_kicked');
    } catch (e, st) {
      log('Failed to remove member.', e, st);

      return;
    }
  }

  /// Modifies the access type of the member with the given [userId].
  Future<void> chmod(int userId, PlanMemberAccessType accessType) async {
    if (!state.hasData) {
      log('Cannot modify member: No plan loaded.');

      return;
    }

    try {
      await _plan.chmod(
        _auth.state.requireData[Webservice.lb_planner_api],
        userId,
        accessType,
      );

      await captureEvent('member_access_changed', properties: {'access_type': accessType});
    } catch (e, st) {
      log('Failed to modify member.', e, st);

      return;
    }
  }

  /// Changes the plan's name to the given [name].
  Future<void> changeName(String name) async {
    if (!state.hasData) {
      log('Cannot change name: No plan loaded.');

      return;
    }

    try {
      await _plan.updatePlan(
        _auth.state.requireData[Webservice.lb_planner_api],
        state.requireData.copyWith(name: name),
      );
    } catch (e, st) {
      log('Failed to change name.', e, st);

      return;
    }
  }

  /// Sets [CalendarPlan.optionalTasksEnabled] to [enabled].
  // Using positional parameters here for ease of use in the UI.
  // ignore: avoid_positional_boolean_parameters
  Future<void> enableOptionalTasks(bool? enabled) async {
    if (!state.hasData) {
      log('Cannot set optional tasks enabled: No plan loaded.');

      return;
    }

    if (enabled == null) {
      log('Cannot set optional tasks enabled: No value provided.');

      return;
    }

    try {
      data(
        state.requireData.copyWith(
          optionalTasksEnabled: enabled,
        ),
      );

      await _plan.updatePlan(
        _auth.state.requireData[Webservice.lb_planner_api],
        state.requireData.copyWith(
          optionalTasksEnabled: enabled,
        ),
      );

      await _tasks.build(CalendarPlanRepository);

      await captureEvent('optional_tasks_enabled', properties: {'enabled': enabled});
    } catch (e, st) {
      log('Failed to set optional tasks enabled.', e, st);

      return;
    }
  }

  /// Returns a list of tasks that do not have an associated deadline.
  List<MoodleTask> getUnplannedTasks() {
    if (!state.hasData) {
      log('Cannot get unplanned tasks: No plan loaded.');

      return [];
    }

    if (!_tasks.state.hasData) {
      log('Cannot get unplanned tasks: No tasks loaded.');

      return [];
    }

    return _tasks.state.requireData.where((task) {
      return !state.requireData.deadlines.any((t) => t.id == task.id);
    }).toList();
  }

  /// Returns a list of deadlines that match the given filters.
  ///
  /// If no filters are provided, all deadlines are returned.
  List<PlanDeadline> filterDeadlines({
    int? taskId,
    DateTime? start,
    DateTime? end,
    DateTime? betweenStart,
    DateTime? betweenEnd,
    bool? plannedForToday,
  }) {
    if (!state.hasData) {
      log('Cannot filter deadlines: No plan loaded.');

      return [];
    }

    final now = DateTime.now();

    return state.requireData.deadlines.where((deadline) {
      if (taskId != null && deadline.id != taskId) return false;
      if (start != null && deadline.start != start) return false;
      if (end != null && deadline.end != end) return false;

      if (betweenStart != null && deadline.start.isBefore(betweenStart)) return false;
      if (betweenEnd != null && deadline.end.isAfter(betweenEnd)) return false;

      if (plannedForToday != null) {
        final startsBeforeToday = deadline.start.isBefore(now) || deadline.start.isSameDate(now);
        final endsAfterToday = deadline.end.isAfter(now) || deadline.end.isSameDate(now);

        if (plannedForToday && !(startsBeforeToday && endsAfterToday)) return false;
      }

      return true;
    }).toList();
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
      await _invites.acceptInvite(
        _auth.state.requireData[Webservice.lb_planner_api],
        inviteId,
      );

      await captureEvent('invite_accepted');
    } catch (e, st) {
      log('Failed to accept invite.', e, st);

      return;
    }
  }

  /// Returns a list of members that match the given filters.
  ///
  /// If no filters are provided, all members are returned.
  List<PlanMember> filterMembers({
    int? userId,
    PlanMemberAccessType? accessType,
  }) {
    if (!state.hasData) {
      log('Cannot filter members: No plan loaded.');

      return [];
    }

    return state.requireData.members.where((member) {
      if (userId != null && member.id != userId) return false;
      if (accessType != null && member.accessType != accessType) return false;

      return true;
    }).toList();
  }

  /// Returns a list of all invites that match the given filters.
  Future<List<PlanInvite>> getInvites({
    int? id,
    int? inviterId,
    int? inviteeId,
    PlanInviteStatus? status,
    int? planId,
  }) async {
    if (!state.hasData) {
      log('Cannot fetch invites: No plan loaded.');

      return [];
    }

    final invites = await _invites.getInvites(
      _auth.state.requireData[Webservice.lb_planner_api],
    );

    return invites.where((invite) {
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

    _deadlines.dispose();
    _plan.dispose();
  }
}
