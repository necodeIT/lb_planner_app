import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Service for authenticating users.
abstract class AuthService extends Service with Tracable {
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

  /// The message for the exception.
  ///
  /// Defaults to [_defaultMessage] if not provided in the constructor.
  late final String Function(Object reason, Webservice) message;

  /// An exception thrown when [AuthService.authenticate] fails.
  AuthException(this.reason, this.webservice, {String Function(Object reason, Webservice)? message}) {
    this.message = message ?? _defaultMessage;
  }

  String _defaultMessage(Object reason, Webservice webservice) => 'AuthException: Failed to authenticate user for ${webservice.name}: $reason';

  @override
  String toString() => message(reason, webservice);
}

/// If [AuthException.reason] is [InsuffcientPermissionsReason], the user does not have the
/// required permissions to use the webservice and thus is not allowed to authenticate.
class InsuffcientPermissionsReason {
  @override
  String toString() => 'Insufficient permissions: The user does not have the required permissions to use this webservice.';
}
