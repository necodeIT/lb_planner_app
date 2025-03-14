import 'dart:async';

import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';
import 'package:posthog_dart/posthog_dart.dart';

/// UI state controller for authentication.
///
/// If the state is an empty set, the user is not authenticated.
class AuthRepository extends Repository<AsyncValue<Set<Token>>> with Tracable {
  final AuthService _auth;
  final LocalStorageDatasource _localStorage;

  static AsyncValue<Set<Token>>? _state;

  /// UI state controller for authentication.
  AuthRepository(this._auth, this._localStorage) : super(_state ?? AsyncValue.loading()) {
    _auth.parent = this;
  }

  @override
  FutureOr<void> build(Trigger trigger) async {
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

    final transaction = startTransaction('loadAuth');

    try {
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

      if (isAuthenticated) PostHog().enable();
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Sign in with [username] and [password].
  Future<bool> authenticate({
    required String username,
    required String password,
  }) async {
    final transaction = startTransaction('login');

    log('Authenticating with username $username');

    try {
      emit(AsyncValue.loading());

      await guard(
        () async => _auth.authenticate(
          username: username,
          password: password,
          webservices: Webservice.values.toSet(),
        ),
        onData: (p0) => captureEvent('user_login'),
        onError: (e, s) {
          transaction.internalError(e);
          log('Failed to load authentification', e, s);
        },
      );

      if (!state.hasData) return false;

      log('Authentication successful');

      await _localStorage.write(state.requireData);

      return true;
    } catch (e) {
      transaction.internalError(e);

      return false;
    } finally {
      await transaction.commit();
    }
  }

  /// Sign out.
  Future<void> logout() async {
    final transaction = startTransaction('logout');
    log('Logging out');

    try {
      data({});

      await _localStorage.delete<Set<Token>>();

      PostHog().reset();
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// `true` if the user is authenticated.
  bool get isAuthenticated => state.hasData && state.requireData.isNotEmpty;

  /// Throws a [WaitForDataException] if the user is not authenticated.
  void requireAuth() {
    if (!isAuthenticated) throw WaitForDataException(AuthRepository);
  }

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
