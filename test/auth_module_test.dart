import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:logging/logging.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_local_storage/mcquenji_local_storage.dart';

final defaultUser = User.fromJson(
// #region json response pasted from mockoon
  jsonDecode('''
{
  "userid": 0,
  "username": "debug",
  "firstname": "Debug",
  "lastname": "Mode",
  "theme": "Light",
  "lang": "en",
  "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
  "planid": 0,
  "colorblindness": "none",
  "displaytaskcount": 1,
  "capabilities": 12,
  "vintage": "5AHIT"
}'''),
// #endregion
);

List<User> get defaultUsers {
  final serde = Modular.get<IGenericJsonSerializer<List<User>>>();

  return serde.deserialize(
    // #region json response pasted from mockoon
    jsonDecode('''
{"List<User>":[
  {
    "userid": 0,
    "username": "debug",
    "firstname": "Debug",
    "lastname": "Mode",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "5AHIT"
  },
  {
    "userid": 42,
    "username": "YyqAjYfaWq",
    "firstname": "IRojInsAxk",
    "lastname": "ucYWikirmR",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "ymZjpceUYP"
  },
  {
    "userid": 61,
    "username": "NeIMeDPuiA",
    "firstname": "rXUhJXneOm",
    "lastname": "gMtCoJQJii",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "IOuQRgkqnq"
  },
  {
    "userid": 78,
    "username": "ojgfnNZYAu",
    "firstname": "LDpukveXVk",
    "lastname": "tlGblsrFUs",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "PwLrDnZcOH"
  },
  {
    "userid": 83,
    "username": "ulpKGrCxLL",
    "firstname": "qxVmYcwfci",
    "lastname": "DlMJNFNWhR",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "ETktsLiFSA"
  },
  {
    "userid": 68,
    "username": "FZmOvWDCdy",
    "firstname": "WHOoxyPeDp",
    "lastname": "nyihMcqyub",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "qfkuaRoWxV"
  },
  {
    "userid": 31,
    "username": "cQQgLCGKkD",
    "firstname": "CqzkExePIZ",
    "lastname": "LqhMGlFUfo",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "NPiXeqfHMf"
  },
  {
    "userid": 82,
    "username": "YcICSCdpDw",
    "firstname": "dwjXsfvWJX",
    "lastname": "tONVbEnNzi",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "yXVpPOiGNq"
  },
  {
    "userid": 22,
    "username": "ZMrdFFvVhf",
    "firstname": "UONzxNVJMg",
    "lastname": "mXvhTpFQYz",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "nDznCPWZUH"
  },
  {
    "userid": 8,
    "username": "MZWSkKabCn",
    "firstname": "CWSFpQxNxw",
    "lastname": "DFiqznAVSV",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "wucVeDWtWL"
  },
  {
    "userid": 20,
    "username": "UIVDEzBimD",
    "firstname": "eGBYQzvvcd",
    "lastname": "DYueTuIkGZ",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "RHRbPuLLjb"
  },
  {
    "userid": 17,
    "username": "TTJtRvVXZp",
    "firstname": "PCwNwYayeI",
    "lastname": "SwonYCWtrH",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "CyulfvLfKN"
  },
  {
    "userid": 66,
    "username": "FVcEuWfusx",
    "firstname": "nctmOvxqyu",
    "lastname": "MTkcjDCLQx",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "wNZAxBVcdz"
  },
  {
    "userid": 16,
    "username": "JuiYXVBGHy",
    "firstname": "UPvvMIMUXP",
    "lastname": "WNsMNyUkFa",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "HPnkCrFHTR"
  },
  {
    "userid": 91,
    "username": "PESTQbECwy",
    "firstname": "UZnIVNtcXO",
    "lastname": "WifDyiTZPr",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "eOTyaVDtkv"
  },
  {
    "userid": 76,
    "username": "QQbkPdHAZi",
    "firstname": "UCuZmrrepD",
    "lastname": "cFiCLytdIh",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "BHcdDtMFJF"
  },
  {
    "userid": 50,
    "username": "iFpZQkjqhE",
    "firstname": "DauIHrBZKr",
    "lastname": "uhPInJxBVi",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "MrkJOWkOnJ"
  },
  {
    "userid": 37,
    "username": "CVhoHgyPkd",
    "firstname": "ouHoVyUBUa",
    "lastname": "PFTUswllWE",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "YmaVXqavmv"
  },
  {
    "userid": 56,
    "username": "mzMcfaxPqd",
    "firstname": "joyaDYnIgl",
    "lastname": "NOpExYaelc",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "bJacnSNfnv"
  },
  {
    "userid": 42,
    "username": "hrNTtGXAIV",
    "firstname": "ycugXqoMjS",
    "lastname": "FjVamjPTmh",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "pwtjDzSJaF"
  },
  {
    "userid": 78,
    "username": "LodiNlsALj",
    "firstname": "fGyUdqUjtR",
    "lastname": "VwADwDoFQk",
    "profileimageurl": "https://i.pinimg.com/474x/13/3b/0a/133b0ab0142b8faf0e11ad289ff0749e.jpg",
    "vintage": "gYnWEpQeye"
  }
]}
'''),
    // #endregion
  );
}

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
            const Token(
              webservice: Webservice.lb_planner_api,
              token: 'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
            ),
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
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.isLoading,
            'isLoading',
            true,
          ),
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.isLoading,
            'isLoading',
            true,
          ),
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.data,
            'data',
            isNotNull,
          ),
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
            reason: 'The tokens should be correctly stored in local storage.',
          );
        },
      );
      blocTest(
        'user is authenticated from storage',
        setUp: () async {
          final storage = Modular.get<LocalStorageDatasource>();

          await storage.write(
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
          );
        },
        build: () => Modular.get<AuthRepository>(),
        act: (repo) => repo.loadStoredTokens,
        expect: () => [
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.isLoading,
            'isLoading',
            true,
          ),
          isA<AsyncValue<Set<Token>>>()
              .having(
            (state) => state.data,
            'data',
            isNotNull,
          )
              .having(
            (state) => state.data,
            'data',
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

          await storage.write(
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
          );
        },
        build: () => Modular.get<AuthRepository>(),
        act: (repo) async {
          await repo.loadStoredTokens;
          await repo.logout();
        },
        expect: () => [
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.isLoading,
            'isLoading',
            true,
          ),
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.data,
            'data',
            isNotNull,
          ),
          isA<AsyncValue<Set<Token>>>().having(
            (state) => state.data,
            'data',
            isEmpty,
          ),
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
            'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
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
            'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
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
            'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
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
            'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
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
            'DpWjCjT5oaV7JFwQuwZgwMC53BcY2A',
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
        isA<AsyncValue<User>>().having((u) => u.isLoading, 'isLoading', true),
        isA<AsyncValue<User>>().having((u) => u.isLoading, 'isLoading', true),
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
        isA<AsyncValue<User>>().having((u) => u.isLoading, 'isLoading', true),
        isA<AsyncValue<User>>().having((u) => u.isLoading, 'isLoading', true),
        isA<AsyncValue<User>>().having((u) => u.isLoading, 'isLoading', true),
        isA<AsyncValue<User>>().having((u) => u.data, 'data', defaultUser),
        isA<AsyncValue<User>>().having((u) => u.data, 'data', defaultUser.copyWith(themeName: 'Dark')),
      ],
    );
  });
}
