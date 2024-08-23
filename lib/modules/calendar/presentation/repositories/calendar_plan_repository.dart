import 'dart:async';

import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Repository for managing a user's [CalendarPlan].
class CalendarPlanRepository extends Repository<AsyncValue<CalendarPlan>> {
  final PlanDatasource _plan;
  final DeadlinesDatasource _deadlines;
  final AuthRepository _auth;
  final ConnectivityService _connectivity;
  final TickRepository _ticks;
  final MoodleTasksRepository _tasks;

  /// Repository for managing a user's [CalendarPlan].
  CalendarPlanRepository(
    this._plan,
    this._deadlines,
    this._auth,
    this._connectivity,
    this._ticks,
    this._tasks,
  ) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    watch(_ticks);
    watchAsync(_tasks);
  }

  @override
  Future<void> build(Type trigger) async {
    // We don't need to refresh the plan as it's only loosely connected to the tasks.
    if (trigger == MoodleTasksRepository) {
      log('Skipping refresh triggered by $trigger');

      return;
    }

    if (!_ticks.state.isFirst) log('Refreshing plan...');

    if (!_auth.state.hasData) {
      log('Cannot fetch plan: No tokens provided.');

      return;
    }

    await _loadPlan(_auth.state.requireData);
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
      await _deadlines.clearDeadlines(_auth.state.requireData[Webservice.lb_planner_api]);
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
      await _deadlines.setDeadline(
        _auth.state.requireData[Webservice.lb_planner_api],
        PlanDeadline(
          id: taskId,
          start: start,
          end: end,
        ),
      );
    } catch (e, st) {
      log('Failed to set deadline.', e, st);

      return;
    }
  }

  /// Removes the given [deadline].
  Future<void> removeDeadline(PlanDeadline deadline) async {
    if (!state.hasData) {
      log('Cannot remove deadline: No plan loaded.');

      return;
    }

    try {
      await _deadlines.removeDeadline(
        _auth.state.requireData[Webservice.lb_planner_api],
        deadline.id,
      );
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
  Future<void> enableOptionalTasks({bool enabled = true}) async {
    if (!state.hasData) {
      log('Cannot set optional tasks enabled: No plan loaded.');

      return;
    }

    try {
      await _plan.updatePlan(
        _auth.state.requireData[Webservice.lb_planner_api],
        state.requireData.copyWith(
          optionalTasksEnabled: enabled,
        ),
      );
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

    return _tasks.state.requireData.where((task) {
      return !state.requireData.deadlines.any((t) => t.id == task.id);
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();

    _deadlines.dispose();
    _plan.dispose();
  }
}
