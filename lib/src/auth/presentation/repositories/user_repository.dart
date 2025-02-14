import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:posthog_dart/posthog_dart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// UI state controller for the current user.
class UserRepository extends Repository<AsyncValue<User>> {
  final AuthRepository _auth;
  final UserDatasource _userDatasource;

  bool _isHandlingAuthChange = false;

  /// `true` if the repository is currently handling an auth change.
  @visibleForTesting
  bool get isHandlingAuthChange => _isHandlingAuthChange;

  /// UI state controller for the current user.
  UserRepository(this._auth, this._userDatasource) : super(AsyncValue.loading()) {
    watchAsync(_auth);
  }

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    final transaction = startTransaction('loadUsers');

    final tokens = waitForData(_auth);

    _isHandlingAuthChange = true;

    if (tokens.isEmpty) {
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
      await transaction.finish();
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
          'vintage': user.vintage,
          'theme': user.themeName,
          'optional_tasks_enabled': user.optionalTasksEnabled,
          'display_task_count': user.displayTaskCount,
        },
      );

      Sentry.configureScope((scope) {
        scope.setUser(SentryUser(id: hash));
      });

      _isHandlingAuthChange = false;

      return;
    } catch (e, s) {
      log('Failed to fetch user data', e, s);
    } finally {
      _isHandlingAuthChange = false;
      await transaction.finish();
    }
  }

  Future<void> _updateUser(User patch) async {
    log('Updating user to $patch');

    if (!state.hasData) {
      log('User is not loaded yet. Aborting.');
      return;
    }

    final transaction = startTransaction('updateUser');
    await guard(
      () => _userDatasource.updateUser(
        _auth.state.requireData[Webservice.lb_planner_api],
        patch,
      ),
      onError: (e, s) => log('Failed to update user', e, s),
      onData: (user) => log('User updated successfully'),
    );
    await transaction.finish();
  }

  /// Updates the user's theme.
  Future<void> setTheme(String theme) async {
    if (!state.hasData) {
      log('User is not loaded yet. Aborting.');

      return;
    }

    final transaction = startTransaction('setTheme');
    await captureEvent('theme_changed', properties: {'theme': theme});

    await transaction.finish();
    return _updateUser(
      state.requireData.copyWith(themeName: theme),
    );
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
    } finally {
      await transaction.finish();
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

      data(
        patch,
      );

      await _userDatasource.updateUser(
        _auth.state.requireData[Webservice.lb_planner_api],
        patch,
      );

      await captureEvent('optional_tasks_enabled', properties: {'enabled': enabled});
    } catch (e, st) {
      log('Failed to set optional tasks enabled.', e, st);

      return;
    } finally {
      await transaction.finish();
    }
  }

  /// Sets [User.displayTaskCount] to [value] for the current user.
  // Using positional parameters here for ease of use in the UI.
  // ignore: avoid_positional_boolean_parameters
  Future<void> setDisplayTaskCount(bool? value) async {
    if (!state.hasData) {
      log('Cannot set optional tasks enabled: No user loaded.');

      return;
    }

    if (value == null) {
      log('Cannot set optional tasks enabled: No value provided.');

      return;
    }

    final transaction = startTransaction('setDisplayTaskCount');

    try {
      final patch = state.requireData.copyWith(
        displayTaskCount: value,
      );

      data(
        patch,
      );

      await _userDatasource.updateUser(
        _auth.state.requireData[Webservice.lb_planner_api],
        patch,
      );

      await captureEvent('optional_tasks_enabled', properties: {'enabled': value});
    } catch (e, st) {
      log('Failed to set optional tasks enabled.', e, st);

      return;
    } finally {
      await transaction.finish();
    }
  }

  /// Agrees to the collection of analytics data.
  void agreeToAnalytics({bool agree = true}) => agree ? PostHog().enable() : PostHog().disable();
}
