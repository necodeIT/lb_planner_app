import 'package:flutter/foundation.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

/// UI state controller for authentication.
///
/// If the state is an empty set, the user is not authenticated.
class AuthRepository extends Repository<AsyncValue<Set<Token>>> {
  final AuthService _auth;
  final LocalStorageDatasource _localStorage;

  /// A future that completes when tokens have been loaded from storage.
  @visibleForTesting
  late final Future<void> loadStoredTokens;

  /// UI state controller for authentication.
  AuthRepository(this._auth, this._localStorage) : super(AsyncValue.loading()) {
    loadStoredTokens = _authFromStorage();
  }

  Future<void> _authFromStorage() async {
    if (!await _localStorage.exists<Set<Token>>()) {
      log('No token found in storage');

      return;
    }

    final tokens = await _localStorage.read<Set<Token>>();

    for (final token in tokens) {
      final valid = await _auth.verifyToken(token);

      if (!valid) {
        log('Token $token is invalid. Setting state to empty.');

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
    emit(AsyncValue.loading());

    await guard(
      () => _auth.authenticate(
        username: username,
        password: password,
        webservices: Webservice.values.toSet(),
      ),
    );

    if (!state.hasData) return;

    await _localStorage.write(state.requireData);
  }

  /// Sign out.
  Future<void> logout() async {
    data({});

    await _localStorage.delete<Set<Token>>();
  }

  @override
  void dispose() {
    super.dispose();
    _auth.dispose();
    _localStorage.dispose();
  }
}
