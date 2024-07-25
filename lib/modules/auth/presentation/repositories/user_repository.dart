import 'dart:async';

import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// UI state controller for the current user.
class UserRepository extends Repository<AsyncValue<User>> {
  final AuthRepository _auth;
  late final StreamSubscription _authSubscription;
  final UserDatasource _userDatasource;

  /// UI state controller for the current user.
  UserRepository(this._auth, this._authSubscription, this._userDatasource) : super(AsyncValue.loading()) {
    _authSubscription = _auth.listen(
      (state) => state.when(
        data: _onAuthChange,
        loading: loading,
        error: error,
      ),
    );
  }

  Future<void> _onAuthChange(Set<Token> tokens) async {
    log('Auth state changed');

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

      return;
    }

    try {
      log('Fetching user data');

      final user = await _userDatasource.getUser(tokens[Webservice.lb_planner_api]);

      log('User data fetched successfully');

      data(user);
    } catch (e) {
      log('Failed to fetch user data', e);
    }

    log('Assuming user is not registered yet.');

    log('Registering user');

    emit(
      await AsyncValue.guard(
        () => _userDatasource.registerUser(
          tokens[Webservice.lb_planner_api],
        ),
        onError: (e, s) => log('Failed to register user', e, s),
        onData: (_) => log('User registered successfully'),
      ),
    );
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
