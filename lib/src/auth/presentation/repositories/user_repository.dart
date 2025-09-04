import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/foundation.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:posthog_dart/posthog_dart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// UI state controller for the current user.
class UserRepository extends Repository<AsyncValue<User>> with Tracable {
  final AuthRepository _auth;
  final UserDatasource _userDatasource;

  bool _isHandlingAuthChange = false;

  /// `true` if the repository is currently handling an auth change.
  @visibleForTesting
  bool get isHandlingAuthChange => _isHandlingAuthChange;

  /// UI state controller for the current user.
  UserRepository(this._auth, this._userDatasource) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    _userDatasource.parent = this;
  }

  @override
  FutureOr<void> build(Trigger trigger) async {
    final transaction = startTransaction('loadUsers');

    final tokens = waitForData(_auth);

    _isHandlingAuthChange = true;

    if (!_auth.isAuthenticated) {
      log('User is unauthenticated');

      error(
        AuthException(
          '',
          Webservice.lb_planner_api,
          message: (reason, webservice) {
            return 'User is not authenticated';
          },
        ),
      );

      _isHandlingAuthChange = false;
      await transaction.commit();
      return;
    }

    try {
      log('Fetching user data');

      final user = await _userDatasource.getUser(tokens[Webservice.lb_planner_api]);

      log('User data fetched successfully');

      data(user);

      final hash = sha256.convert(user.id.toString().codeUnits).toString();

      await PostHog().identify(
        distinctId: hash,
        properties: {
          'capabilities': user.capabilities.map((c) => c.name).toList(),
          'vintage': user.vintage?.humanReadable,
          'theme': user.themeName,
          'optional_tasks_enabled': user.optionalTasksEnabled,
          'display_task_count': user.displayTaskCount,
          'show_column_colors': user.showColumnColors,
          'auto_move_completed_tasks': user.autoMoveCompletedTasksTo,
          'auto_move_submitted_tasks': user.autoMoveSubmittedTasksTo,
          'auto_move_overdue_tasks': user.autoMoveOverdueTasksTo,
        },
      );

      _isHandlingAuthChange = false;

      return;
    } catch (e, s) {
      log('Failed to fetch user data', e, s);
      transaction.internalError(e);
    } finally {
      _isHandlingAuthChange = false;
      await transaction.commit();
    }
  }

  /// Optimistically updates the user with [patch].
  Future<void> _updateUser(User patch, ISentrySpan span) async {
    log('Updating user to $patch');

    if (!state.hasData) {
      log('User is not loaded yet. Aborting.');
      return;
    }

    data(patch);

    final transaction = span.startChild('updateUser');
    await guard(
      () => _userDatasource.updateUser(
        _auth.state.requireData[Webservice.lb_planner_api],
        patch,
      ),
      onError: (e, s) {
        log('Failed to update user', e, s);
        transaction.internalError(e);
      },
      onData: (user) => log('User updated successfully'),
    );
    await transaction.commit();
  }

  /// Updates the user's theme.
  Future<void> setTheme(String theme) async {
    if (!state.hasData) {
      log('User is not loaded yet. Aborting.');

      return;
    }

    final transaction = startTransaction('setTheme');
    try {
      await captureEvent('theme_changed', properties: {'theme': theme});

      return _updateUser(
        state.requireData.copyWith(themeName: theme),
        transaction,
      );
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Deletes the current user.
  ///
  /// Note: this does not yet whipe any collected analytics data.
  Future<void> deleteUser() async {
    log('Deleting current user');

    if (!state.hasData) {
      log('User is not loaded yet.');

      return;
    }

    final transaction = startTransaction('deleteUser');

    try {
      await _userDatasource.deleteUser(_auth.state.requireData[Webservice.lb_planner_api]);

      await captureEvent('account_deleted');

      await _auth.logout();

      log('User deleted successfully.');
    } catch (e, s) {
      log('Failed to delete User.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Sets [User.optionalTasksEnabled] to [enabled] for the current user.
  // Using positional parameters here for ease of use in the UI.
  // ignore: avoid_positional_boolean_parameters
  Future<void> enableOptionalTasks(bool? enabled) async {
    if (!state.hasData) {
      log('Cannot set optional tasks enabled: No user loaded.');

      return;
    }

    if (enabled == null) {
      log('Cannot set optional tasks enabled: No value provided.');

      return;
    }

    final transaction = startTransaction('enableOptionalTasks');

    try {
      final patch = state.requireData.copyWith(
        optionalTasksEnabled: enabled,
      );

      await _updateUser(patch, transaction);

      await captureEvent('optional_tasks_enabled', properties: {'enabled': enabled});

      log('Optional tasks enabled set to $enabled');
    } catch (e, st) {
      log('Failed to set optional tasks enabled.', e, st);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Sets [User.displayTaskCount] to [value] for the current user.
  // ignore: avoid_positional_boolean_parameters Using positional parameters here for ease of use in the UI.
  Future<void> setDisplayTaskCount(bool? value) async {
    if (!state.hasData) {
      log('Cannot set display task count: No user loaded.');

      return;
    }

    if (value == null) {
      log('Cannot set display task count: No value provided.');

      return;
    }

    final transaction = startTransaction('setDisplayTaskCount');

    try {
      final patch = state.requireData.copyWith(
        displayTaskCount: value,
      );

      await _updateUser(
        patch,
        transaction,
      );

      await captureEvent('display_task_count', properties: {'enabled': value});
    } catch (e, st) {
      log('Failed to set display task count.', e, st);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Agrees to the collection of analytics data.
  void agreeToAnalytics({bool agree = true}) => agree ? PostHog().enable() : PostHog().disable();

  /// Sets [User.showColumnColors] to [value] for the current user.
  ///
  /// If [value] is null, it defaults to true.
  // ignore: avoid_positional_boolean_parameters Using positional parameters here for ease of use in the UI.
  Future<void> setShowColumnColors(bool? value) async {
    final patch = state.requireData.copyWith(
      showColumnColors: value ?? true,
    );

    log('Setting show column colors to ${value ?? true}');

    final transaction = startTransaction('setShowColumnColors');

    try {
      await _updateUser(
        patch,
        transaction,
      );

      await captureEvent('kanban_column_colors', properties: {'enabled': value ?? true});
      log('Set show column colors to ${value ?? true}');
    } catch (e, s) {
      log('Failed to set show column colors.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Sets [User.autoMoveCompletedTasksTo] to [column] for the current user.
  Future<void> setAutoMoveCompletedTasksTo(KanbanColumn? column) async {
    final patch = state.requireData.copyWith(
      autoMoveCompletedTasksTo: column,
    );

    final transaction = startTransaction('setAutoMoveCompletedTasksTo');

    log('Setting auto move completed tasks to ${column?.name}');

    try {
      await _updateUser(
        patch,
        transaction,
      );

      await captureEvent('auto_move_completed_tasks', properties: {'column': '${column?.name}'});

      log('Set auto move completed tasks to ${column?.name}');
    } catch (e, s) {
      log('Failed to set auto move completed tasks.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Sets [User.autoMoveSubmittedTasksTo] to [column] for the current user.
  Future<void> setAutoMoveSubmittedTasksTo(KanbanColumn? column) async {
    final patch = state.requireData.copyWith(
      autoMoveSubmittedTasksTo: column,
    );

    log('Setting auto move submitted tasks to ${column?.name}');

    final transaction = startTransaction('setAutoMoveSubmittedTasksTo');

    try {
      await _updateUser(
        patch,
        transaction,
      );

      await captureEvent('auto_move_submitted_tasks', properties: {'column': '${column?.name}'});
    } catch (e, s) {
      log('Failed to set auto move submitted tasks.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Sets [User.autoMoveOverdueTasksTo] to [column] for the current user.
  Future<void> setAutoMoveOverdueTasksTo(KanbanColumn? column) async {
    final patch = state.requireData.copyWith(
      autoMoveOverdueTasksTo: column,
    );

    data(
      patch,
    );

    final transaction = startTransaction('setAutoMoveOverdueTasksTo');

    log('Setting auto move overdue tasks to ${column?.name}');

    try {
      await _updateUser(
        patch,
        transaction,
      );

      await captureEvent('auto_move_overdue_tasks', properties: {'column': '${column?.name}'});

      log('Set auto move overdue tasks to ${column?.name}');
    } catch (e, s) {
      log('Failed to set auto move overdue tasks.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }
}
