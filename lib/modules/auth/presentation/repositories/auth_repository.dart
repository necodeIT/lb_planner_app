import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// UI state controller for authentication.
///
/// If the state is an empty set, the user is not authenticated.
class AuthRepository extends Repository<AsyncValue<Set<Token>>> {
  final AuthService _auth;

  /// UI state controller for authentication.
  AuthRepository(this._auth) : super(AsyncValue.loading());

  /// Sign in with [username] and [password].
  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(AsyncValue.loading());

    final state = await AsyncValue.guard(
      () => _auth.authenticate(
        username: username,
        password: password,
        webservices: Webservice.values.toSet(),
      ),
    );

    emit(state);
  }

  /// Sign out.
  Future<void> logout() async {
    emit(AsyncValue.data({}));
  }

  @override
  void dispose() {
    super.dispose();
    _auth.dispose();
  }
}
