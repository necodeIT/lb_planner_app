import 'package:lb_planner/modules/auth/auth.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Datasource for fetching user data.
abstract class UserDatasource extends Datasource {
  @override
  String get name => 'User';

  /// Fetches the data for a given user.
  ///
  /// If [id] is not provided, the data for the user associated with the [token] is fetched.
  Future<User> getUser(String token, {String? id});

  /// Fetches all users.
  ///
  /// If [vintage] is provided, only users in the given class are fetched.
  Future<List<User>> getUsers(String token, {String? vintage});

  /// Updates the data for a given [user] and returns the updated user confirmed by the server.
  Future<User> updateUser(String token, User user);

  /// Deletes a user.
  ///
  /// If [id] is not provided, the user associated with the [token] is deleted.
  Future<void> deleteUser(String token, {String? id});

  /// Registers a new user and returns the registered user confirmed by the server.
  ///
  /// You can optionally provide [lang], [theme] and [ekEnabled] to override default initial settings.
  @Deprecated(
    "Removed as per https://github.com/necodeIT/lb_planner_plugin/issues/6. `getUser` will now also register the user if they don't exist.",
  )
  Future<User> registerUser(String token, {String? lang, String? theme, bool? ekEnabled});
}
