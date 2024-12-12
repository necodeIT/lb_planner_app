import 'dart:async';

import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds all users of the application.
class UsersRepository extends Repository<AsyncValue<List<User>>> {
  final UserDatasource _datasource;
  final AuthRepository _auth;

  /// Holds all users of the application.
  UsersRepository(this._datasource, this._auth) : super(AsyncValue.loading()) {
    watchAsync(_auth);
  }

  @override
  Duration get updateInterval => kLessImportantRefreshIntervalDuration;

  @override
  FutureOr<void> build(Type trigger) {
    guard(
      () => _datasource.getUsers(
        waitForData(_auth).pick(Webservice.lb_planner_api),
      ),
    );
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }
}
