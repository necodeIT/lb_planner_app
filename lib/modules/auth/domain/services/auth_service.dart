import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Service for authenticating users.
abstract class AuthService extends Service {
  @override
  String get name => 'Auth';

  /// Authenticates the user with the given [username] and [password] for the given [webservices].
  Future<Set<Token>> authenticate({required String username, required String password, required Set<Webservice> webservices});

  /// Verifies the given [token] is valid.
  Future<bool> verifyToken(Token token);
}

/// An exception thrown when [AuthService.authenticate] fails.
class AuthException implements Exception {
  /// The reason the authentication failed.
  final Object reason;

  /// The webservice that failed to authenticate.
  final Webservice webservice;

  /// An exception thrown when [AuthService.authenticate] fails.
  AuthException(this.reason, this.webservice);

  @override
  String toString() => 'AuthException: Failed to authenticate user for ${webservice.name}: $reason';
}
