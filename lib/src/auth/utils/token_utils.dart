import 'package:collection/collection.dart';
import 'package:eduplanner/src/auth/auth.dart';

/// Utility functions for [Token] sets.
extension TokenExt on Set<Token> {
  /// Returns the token value for the given [service].
  ///
  /// Throws an [AuthException] if no token is not found.
  String pick(Webservice service) {
    return firstWhere(
      (token) => token.webservice == service,
      orElse: () => throw AuthException(
        '',
        service,
        message: (reason, webservice) {
          return 'AuthException: No token found for ${webservice.name}';
        },
      ),
    ).token;
  }

  /// Returns the token value for the given [service] or `null` if not found.
  String? maybePick(Webservice service) {
    return firstWhereOrNull(
      (token) => token.webservice == service,
    )?.token;
  }

  /// Returns the token value for the given [service].
  ///
  /// Throws an [AuthException] if no token is not found.
  String operator [](Webservice service) => pick(service);

  /// Returns `true` if the token for the given [service] is present.
  bool has(Webservice service) {
    return any((token) => token.webservice == service);
  }

  /// Returns the [Token] for the given [service].
  Token token(Webservice service) {
    return firstWhere(
      (token) => token.webservice == service,
      orElse: () => throw AuthException(
        '',
        service,
        message: (reason, webservice) {
          return 'AuthException: No token found for ${webservice.name}';
        },
      ),
    );
  }
}
