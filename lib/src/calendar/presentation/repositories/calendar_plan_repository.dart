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
  final UserRepository _user;

  /// Repository for managing a user's [CalendarPlan].
  CalendarPlanRepository(
    this._plan,
    this._deadlines,
    this._auth,
    this._connectivity,
    this._tasks,
    this._user,
  ) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watchAsync(_tasks, setError: false, setLoading: false);
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  @override
  bool get refreshOptimization => true;

  @override
  Future<void> build(BuildTrigger trigger) async {
    // We don't need to refresh the plan as it's only loosely connected to the tasks.
    if (trigger is MoodleTasksRepository) {
      log('Skipping refresh triggered by $trigger');

      return;
    }

    final tokens = waitForData(_auth);

    log('Loading plan...');

    if (tokens.isEmpty) {
      log('Cannot load plan: No tokens provided.');

      return;
    }

    if (!_connectivity.isConnected) {
      log('Cannot load plan: No internet connection. Skipping to preserve chached data.');

      return;
    }

    final transaction = startTransaction('loadPlan');

    await guard(
      () => _plan.getPlan(tokens[Webservice.lb_planner_api]),
      onData: (_) => log('Plan loaded.'),
      onError: (e, s) {
        transaction.internalError(e);
        log('Failed to load plan.', e, s);
      },
    );

    await transaction.commit();
  }

  /// Clears the plan.
  Future<void> clear() async {
    if (!state.hasData) {
      log('Cannot clear plan: No plan loaded.');

      return;
    }

    final transaction = startTransaction('clear');

    try {
      data(state.requireData.copyWith(deadlines: []));

      await _deadlines.clearDeadlines(_auth.state.requireData[Webservice.lb_planner_api]);

      log('Plan cleared.');

      await captureEvent('plan_cleared');

      await build(this);
    } catch (e, st) {
      transaction.internalError(e);
      log('Failed to clear plan.', e, st);
    } finally {
      await transaction.commit();
    }
  }

  /// Sets a deadline for the given [taskId].
  Future<void> setDeadline(int taskId, DateTime start, DateTime end) async {
    if (!state.hasData) {
      log('Cannot set deadline: No plan loaded.');

      return;
    }

    final transaction = startTransaction('setDeadline');

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

      await _tasks.build(this);
      await build(this);
    } catch (e, st) {
      transaction.internalError(e);

      log('Failed to set deadline.', e, st);
    } finally {
      await transaction.commit();
    }
  }

  /// Removes the deadline with the given [id].
  Future<void> removeDeadline(int id) async {
    if (!state.hasData) {
      log('Cannot remove deadline: No plan loaded.');

      return;
    }

    final transaction = startTransaction('removeDeadline');

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

      await _tasks.build(this);
      await build(this);
    } catch (e, st) {
      transaction.internalError(e);

      log('Failed to remove deadline.', e, st);
    } finally {
      await transaction.commit();
    }
  }

  /// Leaves the shared plan.
  Future<void> leavePlan() async {
    if (!state.hasData) {
      log('Cannot leave plan: No plan loaded.');

      return;
    }

    log('Leaving plan...');

    final transaction = startTransaction('leavePlan');

    try {
      await _plan.leavePlan(_auth.state.requireData[Webservice.lb_planner_api]);

      await captureEvent('plan_left');

      await build(this);
    } catch (e, st) {
      log('Failed to leave plan.', e, st);

      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Removes the member with the given [userId].
  Future<void> kick(int userId) async {
    if (!state.hasData) {
      log('Cannot remove member: No plan loaded.');

      return;
    }

    final transaction = startTransaction('kickMember');

    try {
      await _plan.removeMember(
        _auth.state.requireData[Webservice.lb_planner_api],
        userId,
      );

      await captureEvent('member_kicked');

      await build(this);
    } catch (e, st) {
      log('Failed to remove member.', e, st);

      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Modifies the access type of the member with the given [userId].
  Future<void> chmod(int userId, PlanMemberAccessType accessType) async {
    if (!state.hasData) {
      log('Cannot modify member: No plan loaded.');

      return;
    }

    final transaction = startTransaction('chmodMember');

    try {
      await _plan.chmod(
        _auth.state.requireData[Webservice.lb_planner_api],
        userId,
        accessType,
      );

      await captureEvent('member_access_changed', properties: {'access_type': accessType});

      await build(this);
    } catch (e, st) {
      log('Failed to modify member.', e, st);

      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Changes the plan's name to the given [name].
  Future<void> changeName(String name) async {
    if (!state.hasData) {
      log('Cannot change name: No plan loaded.');

      return;
    }

    final transaction = startTransaction('changeName');

    try {
      await _plan.updatePlan(
        _auth.state.requireData[Webservice.lb_planner_api],
        state.requireData.copyWith(name: name),
      );

      await build(this);
    } catch (e, st) {
      log('Failed to change name.', e, st);

      transaction.internalError(e);
    } finally {
      await transaction.commit();
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
      if (state.requireData.deadlines.any((t) => t.id == task.id)) return false;
      if (task.type == MoodleTaskType.exam) return false;

      return true;
    }).toList();
  }

  /// Returns a list of deadlines that match the given filters.
  ///
  /// If no filters are provided, all deadlines are returned.
  List<PlanDeadline> filterDeadlines({
    Set<int>? taskIds,
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

    final now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    return state.requireData.deadlines.where((deadline) {
      final _start = DateTime(deadline.start.year, deadline.start.month, deadline.start.day);
      final _end = DateTime(deadline.end.year, deadline.end.month, deadline.end.day);

      if (taskIds != null && taskIds.contains(deadline.id)) return false;
      if (start != null && _start != start) return false;
      if (end != null && _end != end) return false;

      if (betweenStart != null && _start.isBefore(betweenStart)) return false;
      if (betweenEnd != null && _end.isAfter(betweenEnd)) return false;

      if (plannedForToday != null) {
        final startsBeforeToday = _start.isBefore(now) || _start.isSameDate(now);
        final endsAfterToday = _end.isAfter(now) || _end.isSameDate(now);

        if (plannedForToday && !(startsBeforeToday && endsAfterToday)) return false;
      }

      return true;
    }).toList();
  }

  /// Returns the access type of the current user.
  PlanMemberAccessType get accessType => state.hasData && _user.state.hasData
      ? state.requireData.members.firstWhere((member) => member.id == _user.state.requireData.id).accessType
      : PlanMemberAccessType.read;

  /// Returns `true` if the current user can modify the plan.
  bool get canModifiy => accessType == PlanMemberAccessType.write || accessType == PlanMemberAccessType.owner;

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

  @override
  void dispose() {
    super.dispose();

    _deadlines.dispose();
    _plan.dispose();
  }
}
