import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';

/// Implementation of [UserDatasource] for Moodle.
class MoodleUserDatasource extends UserDatasource {
  final ApiService _api;

  /// Implementation of [UserDatasource] for Moodle.
  MoodleUserDatasource(this._api) {
    _api.parent = this;
  }

  @override
  void dispose() {
    super.dispose();
    _api.dispose();
  }

  @override
  Future<void> deleteUser(String token, {String? id}) async {
    final transaction = startTransaction('deleteUser');

    try {
      await _api.callFunction(
        function: 'local_lbplanner_user_delete_user',
        token: token,
        body: {},
      );
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<User> getUser(String token, {String? id}) async {
    final transaction = startTransaction('getUser');
    try {
      final response = await _api.callFunction(
        function: 'local_lbplanner_user_get_user',
        token: token,
        body: {
          'userid': id,
        },
      );

      response.assertJson();

      return User.fromJson(response.asJson);
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<List<User>> getUsers(String token, {String? vintage}) async {
    final transaction = startTransaction('getUsers');
    try {
      final response = await _api.callFunction(
        function: 'local_lbplanner_user_get_all_users',
        token: token,
        body: {
          'vintage': vintage,
        },
      );

      response.assertList();

      return response.asList.map(User.fromJson).toList();
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<User> updateUser(String token, User user) async {
    final transaction = startTransaction('updateUser');
    try {
      final response = await _api.callFunction(
        function: 'local_lbplanner_user_update_user',
        token: token,
        body: Map.fromEntries(
          user.toJson().entries.where(
                (e) => [
                  'theme',
                  'colorblindness',
                  'displaytaskcount',
                  'ekenabled',
                ].contains(e.key),
              ),
        ),
      );

      response.assertJson();

      return User.fromJson(response.asJson);
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<User> registerUser(String token, {String? lang, String? theme, bool? ekEnabled}) async {
    final transaction = startTransaction('registerUser');
    try {
      final response = await _api.callFunction(
        function: 'local_lbplanner_user_register_user',
        token: token,
        body: {
          'lang': lang,
          'theme': theme,
          'ekenabled': ekEnabled,
        },
      );

      response.assertJson();

      return User.fromJson(response.asJson);
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }
}
