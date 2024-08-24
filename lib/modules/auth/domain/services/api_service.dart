import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Service for
abstract class ApiService extends Service {
  @override
  String get name => 'Api';

  /// Makes a request to the given [function] with the given [body] and [token].
  ///
  /// If [redact] is true, the response will be redacted when logged.
  Future<Either<List<JSON>, JSON>> callFunction({required String function, required String token, required JSON body, bool redact = false});
}

/// An exception thrown when [ApiService.callFunction] fails.
class ApiServiceException implements Exception {
  /// The error message.
  final String message;

  /// The error code.
  final int? statusCode;

  /// The error data.
  final JSON? data;

  /// Creates a new [ApiServiceException] with the given [message], [statusCode] and [data].
  ApiServiceException(this.message, this.statusCode, this.data);

  @override
  String toString() => 'ApiServiceException: $message (status code: $statusCode) ${data != null ? jsonEncode(data) : ''}';
}
