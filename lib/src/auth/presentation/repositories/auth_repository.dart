import 'dart:async';

import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';
import 'package:posthog_dart/posthog_dart.dart';

/// UI state controller for authentication.
///
/// If the state is an empty set, the user is not authenticated.
class AuthRepository extends Repository<AsyncValue<Set<Token>>> {
  final AuthService _auth;
  final LocalStorageDatasource _localStorage;

  static AsyncValue<Set<Token>>? _state;

  /// UI state controller for authentication.
  AuthRepository(this._auth, this._localStorage) : super(_state ?? AsyncValue.loading());

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    if (trigger is! InitialBuildTrigger) return;

    if (_state != null && isAuthenticated) {
      log('Global state present and user is authenticated, skipping storage check');
      return;
    }

    if (_state != null && !isAuthenticated) {
      log('Global state present, however user the is unauthenticated. Discarding state.');
      _state = null;
    }

    if (!await _localStorage.exists<Set<Token>>()) {
      log('No token found in storage');

      data({});

      return;
    }

    final tokens = await _localStorage.read<Set<Token>>();

    for (final token in tokens) {
      final valid = await _auth.verifyToken(token);

      if (!valid) {
        log('Token $token is invalid. Setting clearing state.');

        await logout();

        return;
      }
    }

    data(tokens);
  }

  /// Sign in with [username] and [password].
  Future<void> authenticate({
    required String username,
    required String password,
  }) async {
    log('Authenticating with username $username');

    emit(AsyncValue.loading());

    await guard(
      () => _auth.authenticate(
        username: username,
        password: password,
        webservices: Webservice.values.toSet(),
      ),
      onData: (p0) => captureEvent('user_login'),
    );

    if (!state.hasData) return;

    log('Authentication successful');

    await _localStorage.write(state.requireData);
  }

  /// Sign out.
  Future<void> logout() async {
    log('Logging out');

    data({});

    await _localStorage.delete<Set<Token>>();

    PostHog().reset();
  }

  /// `true` if the user is authenticated.
  bool get isAuthenticated => state.hasData && state.requireData.isNotEmpty;

  @override
  void emit(AsyncValue<Set<Token>> state) {
    super.emit(state);

    _state = state;
  }

  @override
  void dispose() {
    super.dispose();
    _auth.dispose();
    _localStorage.dispose();
  }
}
