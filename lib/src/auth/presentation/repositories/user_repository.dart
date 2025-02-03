import 'dart:async';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:posthog_dart/posthog_dart.dart';

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

      return;
    }

    try {
      log('Fetching user data');

      final user = await _userDatasource.getUser(tokens[Webservice.lb_planner_api]);

      log('User data fetched successfully');

      data(user);

      await PostHog().identify(
        distinctId: sha256.convert(user.id.toString().codeUnits).toString(),
        properties: {
          'capabilities': user.capabilities.map((c) => c.name).toList(),
        },
      );

      _isHandlingAuthChange = false;

      return;
    } catch (e, s) {
      log('Failed to fetch user data', e, s);
    }

    _isHandlingAuthChange = false;
  }

  Future<void> _updateUser(User patch) async {
    log('Updating user to $patch');

    if (!state.hasData) {
      log('User is not loaded yet. Aborting.');
      return;
    }

    await guard(
      () => _userDatasource.updateUser(
        _auth.state.requireData[Webservice.lb_planner_api],
        patch,
      ),
      onError: (e, s) => log('Failed to update user', e, s),
      onData: (user) => log('User updated successfully'),
    );
  }

  /// Updates the user's theme.
  Future<void> setTheme(String theme) async {
    if (!state.hasData) {
      log('User is not loaded yet. Aborting.');

      return;
    }

    await captureEvent('theme_changed', properties: {'theme': theme});

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

    try {
      await _userDatasource.deleteUser(_auth.state.requireData[Webservice.lb_planner_api]);

      await captureEvent('account_deleted');

      await _auth.logout();

      log('User deleted successfully.');
    } catch (e, s) {
      log('Failed to delete User.', e, s);
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
    }
  }

  /// Agrees to the collection of analytics data.
  void agreeToAnalytics({bool agree = true}) => agree ? PostHog().enable() : PostHog().disable();
}
