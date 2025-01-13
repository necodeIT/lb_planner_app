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
  FutureOr<void> build(Type trigger) async {
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
    } catch (e) {
      log('Failed to fetch user data', e);
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

  /// Updates the user's language.
  Future<void> setLanguage(String lang) async {
    if (!state.hasData) {
      log('User is not loaded yet. Aborting.');

      return;
    }

    await captureEvent('language_changed', properties: {'language': lang});

    return _updateUser(
      state.requireData.copyWith(language: lang),
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

  /// Agrees to the collection of analytics data.
  void agreeToAnalytics({bool agree = true}) => agree ? PostHog().enable() : PostHog().disable();
}
