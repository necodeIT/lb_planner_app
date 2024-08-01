import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Implementation of [AuthService] for Moodle.
class MoodleAuthService extends AuthService {
  final ApiService _apiService;
  final NetworkService _networkService;

  /// Implementation of [AuthService] for Moodle.
  MoodleAuthService(this._apiService, this._networkService);

  @override
  void dispose() {
    _apiService.dispose();
    _networkService.dispose();
  }

  @override
  Future<Set<Token>> authenticate({required String username, required String password, required Set<Webservice> webservices}) async {
    log('Authenticating user $username for ${webservices.map((webService) => webService.name).join(', ')}');

    const url = '$kMoodleServerAdress/login/token.php';

    final tokens = <Token>{};

    for (final webservice in webservices) {
      final response = await _networkService.post(
        url,
        {
          'username': username,
          'password': password,
          'service': webservice.name,
          'moodlewsrestformat': 'json',
        },
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.isNotOk) {
        final e = AuthException(response, webservice);

        log('Authentication failed', e);

        throw e;
      }

      final json = response.body as JSON;

      final token = json['token'] as String?;

      if (token == null) {
        final e = AuthException(response.body, webservice);

        log('Authentication failed', e);

        throw e;
      }

      tokens.add(Token(token: token, webservice: webservice));

      log('Authenticated user $username for ${webservice.name}');
    }

    return tokens;
  }

  @override
  Future<bool> verifyToken(Token token) async {
    log('Verifying token for ${token.webservice.name}');

    try {
      final respone = await _apiService.callFunction(
        function: '',
        token: token.token,
        body: {},
      );

      log('API call succeeded, this should not happen', respone);

      return true; // this will never be reached
    } on ApiServiceException catch (e, stack) {
      final body = e.data;

      if (body == null) {
        log('Token verification failed', e, stack);

        return false;
      }

      final errorCode = body['errorcode'] as String?;

      if (errorCode == 'accessexception') {
        log('Token expired', body);

        return false;
      }

      if (errorCode == 'invalidtoken') {
        log('Token is invalid', body);

        return false;
      }

      if (errorCode == 'invalidrecord') {
        // The 'invalidrecord' error code indicates that the token is valid, but
        // the specific record being accessed does not exist because we passed
        // an empty function name. This means the token itself has passed the
        // verification step and thus is valid.
        log('Token verified');

        return true;
      }

      log('Unknown errorcode. Assuming token is invalid', body);

      return false;
    } catch (e, stack) {
      log('Token verification failed', e, stack);

      return false;
    }
  }
}
