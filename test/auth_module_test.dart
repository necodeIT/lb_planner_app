// ignore_for_file: avoid_print

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen(print);

  Modular.bindModule(AuthModule());

  group('AuthService', () {
    test('authenticate with valid login', () async {
      final authService = Modular.get<AuthService>();

      await expectLater(
        authService.authenticate(
          username: 'debug',
          password: 'debug',
          webservices: {
            Webservice.lb_planner_api,
            Webservice.moodle_mobile_app,
          },
        ),
        completion(
          {
            const Token(
              webservice: Webservice.lb_planner_api,
              token: 'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
            ),
            const Token(
              webservice: Webservice.moodle_mobile_app,
              token: 'JNR9LeuzJUOSlFJsmluTHMkmwvTGzh',
            ),
          },
        ),
        reason: 'The user should be able to authenticate with the correct login.',
      );
    });

    test('authenticate with invalid login', () async {
      final authService = Modular.get<AuthService>();

      await expectLater(
        authService.authenticate(
          username: 'invalid user',
          password: 'invalid password',
          webservices: {
            Webservice.lb_planner_api,
            Webservice.moodle_mobile_app,
          },
        ),
        throwsA(isA<AuthException>()),
      );
    });

    test('verify valid token', () async {
      final authService = Modular.get<AuthService>();

      await expectLater(
        authService.verifyToken(
          const Token(
            webservice: Webservice.lb_planner_api,
            token: 'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
          ),
        ),
        completion(true),
        reason: 'The token should be valid.',
      );
    });

    test('verify invalid token', () async {
      final authService = Modular.get<AuthService>();

      await expectLater(
        authService.verifyToken(
          const Token(
            webservice: Webservice.lb_planner_api,
            token: 'invalid token',
          ),
        ),
        completion(false),
        reason: 'The token should be invalid.',
      );
    });
  });
}
