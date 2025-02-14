import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

/// Implementation of [ApiService] using the Moodle API.
class MoodleApiService extends ApiService {
  final NetworkService _networkService;

  /// Implementation of [ApiService] using the Moodle API.
  MoodleApiService(this._networkService);

  @override
  void dispose() {
    super.dispose();
    _networkService.dispose();
  }

  @override
  Future<Either<List<JSON>, JSON>> callFunction({required String function, required String token, JSON body = const {}, bool redact = false}) async {
    log("Calling $function ${redact ? "with [redacted body]" : "with body ${jsonEncode(body)}"}");

    final transaction = startTransaction(function);

    try {
      var payload = JSON.of(body)
        ..removeWhere((key, value) {
          final remove = value == null;

          if (remove) {
            log('Removing null value for key $key');
          }

          return remove;
        });

      // check for any bool values and convert them to 0 or 1
      payload = payload.map((key, value) {
        if (value is bool) {
          return MapEntry(key, value ? 1 : 0);
        }

        return MapEntry(key, value);
      });

      payload['wstoken'] = token;
      payload['moodlewsrestformat'] = 'json';
      payload['wsfunction'] = function;

      final response = await _networkService.post(
        '$kMoodleServerAdress/webservice/rest/server.php',
        payload,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.isNotOk) {
        final e = ApiServiceException('Could not reach server', response.statusCode, response.body);

        log('Error calling function $function', e);

        throw e;
      }

      log("$function returned ${redact ? "[redacted body]" : "body ${jsonEncode(response.body)}"}");

      if (response.body == null) {
        return const Right({});
      }

      if (response.body is List) {
        // convert List<dynamic> to List<JSON>
        final jsonList = (response.body as List<dynamic>).map((dynamic e) => e as JSON).toList();

        return Left(jsonList);
      }

      if (response.body['exception'] != null) {
        final e = ApiServiceException(response.body['message'], response.statusCode, response.body);

        log('Error calling function $function', e);

        throw e;
      }

      return Right(response.body);
    } catch (e) {
      transaction
        ..throwable = e
        ..status = const SpanStatus.internalError();

      rethrow;
    } finally {
      await transaction.finish();
    }
  }
}
