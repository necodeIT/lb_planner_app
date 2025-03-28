import 'dart:async';

import 'package:eduplanner/config/endpoints.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds all users of the application.
class UsersRepository extends Repository<AsyncValue<List<User>>> with Tracable {
  final UserDatasource _datasource;
  final AuthRepository _auth;

  /// Holds all users of the application.
  UsersRepository(this._datasource, this._auth) : super(AsyncValue.loading()) {
    watchAsync(_auth);
    _datasource.parent = this;
  }

  @override
  Duration get updateInterval => kLessImportantRefreshIntervalDuration;

  @override
  FutureOr<void> build(Trigger trigger) async {
    final transaction = startTransaction('loadUsers');
    await guard(
      () async => _datasource.getUsers(
        waitForData(_auth).pick(Webservice.lb_planner_api),
      ),
      onData: (_) => log('Users loaded.'),
      onError: (e, s) {
        log('Failed to load users', e, s);
        transaction.internalError(e);
      },
    );
    await transaction.finish();
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }

  /// Filters this list by [username], [lastname], [firstname], [vintage] and [ids] and returns list of users that match the filter criteria.
  ///
  /// String values are case-insensitive.
  /// If [ids] is not empty, only users with an id in the list are returned.
  Iterable<User> filter({
    String? query,
    String? username,
    String? lastname,
    String? firstname,
    Vintage? vintage,
    List<int>? ids,

    /// The user must have all capabilities in this set.
    Set<UserCapability> capabilities = const {},
    UserCapability? capability,
  }) {
    if (!state.hasData) {
      return [];
    }

    return state.requireData.filter(
      query: query,
      username: username,
      lastname: lastname,
      firstname: firstname,
      vintage: vintage,
      ids: ids,
      capabilities: capabilities,
      capability: capability,
    );
  }
}

/// Extension methods for filtering users.
extension FilterUserX on Iterable<User> {
  /// Filters this list by [username], [lastname], [firstname], [vintage] and [ids] and returns list of users that match the filter criteria.
  ///
  /// String values are case-insensitive.
  /// If [ids] is not empty, only users with an id in the list are returned.
  Iterable<User> filter({
    String? query,
    String? username,
    String? lastname,
    String? firstname,
    Vintage? vintage,
    List<int>? ids,

    /// The user must have all capabilities in this set.
    Set<UserCapability> capabilities = const {},
    UserCapability? capability,
  }) {
    return where((user) {
      if (query != null &&
          !user.username.containsIgnoreCase(query) &&
          !user.lastname.containsIgnoreCase(query) &&
          !user.firstname.containsIgnoreCase(query)) {
        return false;
      }
      if (username != null && !user.username.containsIgnoreCase(username)) return false;
      if (lastname != null && !user.lastname.containsIgnoreCase(lastname)) return false;
      if (firstname != null && !user.firstname.containsIgnoreCase(firstname)) return false;
      if (ids != null && !ids.contains(user.id)) return false;
      if (vintage != null && user.vintage != vintage) return false;
      if (capabilities.isNotEmpty && !user.capabilities.has(capabilities.toList())) return false;
      if (capability != null && !user.capabilities.contains(capability)) return false;

      return true;
    });
  }
}
