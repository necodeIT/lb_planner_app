import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

import 'defaults.dart';

Future<void> main() async {
  Logger.root.level = Level.ALL;

  Logger.root.onRecord.listen(debugLogHandler);

  setUp(() {
    Modular.init(AuthModule());
  });

  tearDown(() {
    Modular.destroy();
  });

  group(AuthService, () {
    group('authenticate', () {
      test('authenticates with valid login data', () async {
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
          completion(defaultTokens),
          reason: 'The user should be able to authenticate with the correct login.',
        );
      });

      test('throws exception for invalid login data', () async {
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
    });

    group('verifyToken', () {
      test('verifies valid token', () async {
        final authService = Modular.get<AuthService>();

        await expectLater(
          authService.verifyToken(
            defaultTokens.token(Webservice.lb_planner_api),
          ),
          completion(true),
          reason: 'The token should be valid.',
        );
      });

      test('does not verify invalid token', () async {
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
  });

  group(AuthRepository, () {
    setUp(initializeLocalStorageForTesting);
    tearDown(clearLocalStorage);
    group('authenticate', () {
      blocTest(
        'writes token to storage once authenticated',
        build: () => Modular.get<AuthRepository>(),
        act: (repo) => repo.authenticate(
          username: 'debug',
          password: 'debug',
        ),
        expect: () => [
          isA<AsyncValue<Set<Token>>>().having((state) => state.isLoading, 'isLoading', true),
          isA<AsyncValue<Set<Token>>>().having((state) => state.data, 'data', isNotNull),
        ],
        verify: (bloc) async {
          final storage = Modular.get<LocalStorageDatasource>();

          await expectLater(
            storage.exists<Set<Token>>(),
            completion(true),
            reason: 'The tokens should be stored in local storage.',
          );

          await expectLater(
            storage.read<Set<Token>>(),
            completion(defaultTokens),
            reason: 'The tokens should be correctly stored in local storage.',
          );
        },
      );
      blocTest(
        'user is authenticated from storage',
        setUp: () async {
          final storage = Modular.get<LocalStorageDatasource>();

          await storage.write(defaultTokens);
        },
        build: () => Modular.get<AuthRepository>(),
        act: (repo) => repo.loadStoredTokens,
        expect: () => [
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.isLoading,
            'isLoading',
            true,
          ),
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.data,
            'data',
            defaultTokens,
          ),
        ],
      );

      blocTest(
        'user is unauthenticated when no token is stored',
        build: () => Modular.get<AuthRepository>(),
        act: (repo) => repo.loadStoredTokens,
        expect: () => [
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.isLoading,
            'isLoading',
            true,
          ),
        ],
      );
    });

    group('logout', () {
      blocTest(
        'clears tokens from storage',
        setUp: () async {
          final storage = Modular.get<LocalStorageDatasource>();

          await storage.write(defaultTokens);
        },
        build: () => Modular.get<AuthRepository>(),
        act: (repo) async {
          await repo.loadStoredTokens;
          await repo.logout();
        },
        expect: () => [
          isA<AsyncValue<Set<Token>>>().having((state) => state.isLoading, 'isLoading', true),
          isA<AsyncValue<Set<Token>>>().having((state) => state.data, 'data', isNotNull),
          isA<AsyncValue<Set<Token>>>().having((state) => state.data, 'data', isEmpty),
        ],
        verify: (bloc) async {
          final storage = Modular.get<LocalStorageDatasource>();

          await expectLater(
            storage.exists<Set<Token>>(),
            completion(false),
            reason: 'The tokens should be removed from local storage.',
          );
        },
      );
    });
  });

  group(UserDatasource, () {
    group('getUser', () {
      test('correctly fetches user data', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.getUser(
            defaultTokens[Webservice.lb_planner_api],
          ),
          completion(defaultUser),
        );
      });

      test('throws exception for invalid token', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.getUser(
            'invalid token',
          ),
          throwsA(isA<ApiServiceException>()),
        );
      });
    });

    group('updateUser', () {
      test('correctly updates user data', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.updateUser(
            defaultTokens[Webservice.lb_planner_api],
            defaultUser.copyWith(themeName: 'Dark'),
          ),
          completion(
            defaultUser.copyWith(themeName: 'Dark'),
          ),
        );
      });

      test('throws exception for invalid token', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.updateUser(
            'invalid token',
            defaultUser.copyWith(themeName: 'Dark'),
          ),
          throwsA(isA<ApiServiceException>()),
        );
      });
    });

    group('deleteUser', () {
      test('correctly deletes user data', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.deleteUser(
            defaultTokens[Webservice.lb_planner_api],
          ),
          completes,
        );
      });

      test('throws exception for invalid token', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.deleteUser(
            'invalid token',
          ),
          throwsA(isA<ApiServiceException>()),
        );
      });
    });

    group('registerUser', () {
      test('correctly registers user', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.registerUser(
            defaultTokens[Webservice.lb_planner_api],
          ),
          completion(defaultUser),
        );
      });

      test('throws exception for invalid token', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.registerUser(
            'invalid token',
            lang: 'de',
            theme: 'Dark',
            ekEnabled: true,
          ),
          throwsA(isA<ApiServiceException>()),
        );
      });
    });

    group('getUsers', () {
      test('correctly fetches all users', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.getUsers(
            defaultTokens[Webservice.lb_planner_api],
          ),
          completion(defaultUsers),
        );
      });

      test('throws exception for invalid token', () async {
        final userDatasource = Modular.get<UserDatasource>();

        await expectLater(
          userDatasource.getUsers(
            'invalid token',
          ),
          throwsA(isA<ApiServiceException>()),
        );
      });
    });
  });

  group(UserRepository, () {
    setUp(initializeLocalStorageForTesting);
    tearDown(clearLocalStorage);

    blocTest(
      'fetches user when authenticated',
      build: () => Modular.get<UserRepository>(),
      act: (repo) async {
        final auth = Modular.get<AuthRepository>();

        await auth.authenticate(
          username: 'debug',
          password: 'debug',
        );

        await Future.doWhile(() async {
          await Future.delayed(const Duration(seconds: 1));
          return repo.isHandlingAuthChange;
        });
      },
      expect: () => [
        isA<AsyncValue<User>>().having((u) => u.isLoading, 'isLoading', true),
        isA<AsyncValue<User>>().having((u) => u.data, 'data', defaultUser),
      ],
    );

    blocTest(
      'correctly updates the theme',
      build: () => Modular.get<UserRepository>(),
      act: (repo) async {
        final auth = Modular.get<AuthRepository>();

        await auth.authenticate(
          username: 'debug',
          password: 'debug',
        );

        await Future.doWhile(() async {
          await Future.delayed(const Duration(seconds: 1));
          return repo.isHandlingAuthChange;
        });

        await repo.setTheme('Dark');
      },
      expect: () => [
        isA<AsyncValue<User>>().having((u) => u.isLoading, 'isLoading', true),
        isA<AsyncValue<User>>().having((u) => u.data, 'data', defaultUser),
        isA<AsyncValue<User>>().having((u) => u.data, 'data', defaultUser.copyWith(themeName: 'Dark')),
      ],
    );
  });
}
