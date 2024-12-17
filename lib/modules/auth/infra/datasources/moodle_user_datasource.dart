import 'package:lb_planner/modules/moodle/moodle.dart';

/// Implementation of [UserDatasource] for Moodle.
class MoodleUserDatasource extends UserDatasource {
  final ApiService _api;

  /// Implementation of [UserDatasource] for Moodle.
  MoodleUserDatasource(this._api);

  @override
  void dispose() {
    super.dispose();
    _api.dispose();
  }

  @override
  Future<void> deleteUser(String token, {String? id}) => _api.callFunction(
        function: 'local_lbplanner_user_delete_user',
        token: token,
        body: {},
      );

  @override
  Future<User> getUser(String token, {String? id}) async {
    final response = await _api.callFunction(
      function: 'local_lbplanner_user_get_user',
      token: token,
      body: {
        'userid': id,
      },
    );

    response.assertJson();

    return User.fromJson(response.asJson);
  }

  @override
  Future<List<User>> getUsers(String token, {String? vintage}) async {
    final response = await _api.callFunction(
      function: 'local_lbplanner_user_get_all_users',
      token: token,
      body: {
        'vintage': vintage,
      },
    );

    response.assertList();

    return response.asList.map(User.fromJson).toList();
  }

  @override
  Future<User> updateUser(String token, User user) async {
    final response = await _api.callFunction(
      function: 'local_lbplanner_user_update_user',
      token: token,
      body: Map.fromEntries(
        user.toJson().entries.where(
              (e) => [
                'lang',
                'theme',
                'colorblindness',
                'displaytaskcount',
              ].contains(e.key),
            ),
      ),
    );

    response.assertJson();

    return User.fromJson(response.asJson);
  }

  @override
  Future<User> registerUser(String token, {String? lang, String? theme, bool? ekEnabled}) async {
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
  }
}
