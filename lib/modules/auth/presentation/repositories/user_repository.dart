import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// UI state controller for the current user.
class UserRepository extends Repository<AsyncValue<User>> {
  final AuthRepository _auth;
  late final StreamSubscription _authSubscription;
  final UserDatasource _userDatasource;

  int _handlers = 0;

  /// If this is `true` [_onAuthChange] is currently running.
  @visibleForTesting
  bool get isHandlingAuthChange => _handlers > 0;

  /// UI state controller for the current user.
  UserRepository(this._auth, this._userDatasource) : super(AsyncValue.loading()) {
    _authSubscription = _auth.listen(
      (state) => state.when(
        data: _onAuthChange,
        loading: loading,
        error: error,
      ),
    );
  }

  Future<void> _onAuthChange(Set<Token> tokens) async {
    _handlers++;

    log('Received new tokens, refetching user ($_handlers queued)');

    // ! may want to implement this later as it may lead to some race conditions
    // wait for the previous handler to finish (less than 1 as the current handler is already queued)
    // await Future.doWhile(() => _handlers <= 1);
    // log('Previous handler finished, proceeding');

    loading();

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

      _handlers--;

      return;
    }

    try {
      log('Fetching user data');

      final user = await _userDatasource.getUser(tokens[Webservice.lb_planner_api]);

      log('User data fetched successfully');

      data(user);

      _handlers--;

      return;
    } catch (e) {
      log('Failed to fetch user data', e);
    }

    log('Assuming user is not registered yet.');

    log('Registering user');

    await guard(
      () => _userDatasource.registerUser(
        tokens[Webservice.lb_planner_api],
      ),
      onError: (e, s) => log('Failed to register user', e, s),
      onData: (_) => log('User registered successfully'),
    );

    _handlers--;
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
  Future<void> setTheme(String theme) => _updateUser(
        state.requireData.copyWith(themeName: theme),
      );

  /// Updates the user's language.
  Future<void> setLanguage(String lang) => _updateUser(
        state.requireData.copyWith(language: lang),
      );

  @override
  void dispose() {
    super.dispose();
    _authSubscription.cancel();
  }
}
