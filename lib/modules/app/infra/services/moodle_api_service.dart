import 'package:either_dart/src/either.dart';
import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Implementation of [ApiService] using the Moodle API.
class MoodleApiService extends ApiService {
  final NetworkService _networkService;

  /// Implementation of [ApiService] using the Moodle API.
  MoodleApiService(this._networkService);

  @override
  void dispose() {
    _networkService.dispose();
  }

  @override
  Future<Either<List<JSON>, JSON>> callFunction({required String function, required String token, required JSON body, bool redact = false}) async {
    log("Calling $function ${redact ? "with [redacted body]" : "with body $body"}");

    body['wstoken'] = token;
    body['moodlewsrestformat'] = 'json';
    body['wsfunction'] = function;

    final response = await _networkService.post(
      '$kMoodleServerAdress/webservice/rest/server.php',
      body,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    if (response.isNotOk) {
      final e = ApiServiceException('Could not reach server', response.statusCode, response.body);

      log('Error calling function $function', e);

      throw e;
    }

    log("$function returned ${redact ? "[redacted body]" : "body ${response.body}"}");

    if (response.body is List) {
      // convert List<dynamic> to List<JSON>
      final jsonList = (response.body as List<dynamic>).map((dynamic e) => e as JSON).toList();

      return Left(jsonList);
    }

    return Right(response.body);
  }
}
