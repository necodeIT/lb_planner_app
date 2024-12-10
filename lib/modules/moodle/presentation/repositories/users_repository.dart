import 'dart:async';

import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Holds all users of the application.
class UsersRepository extends Repository<AsyncValue<List<User>>> {
  final UserDatasource _datasource;
  final Ticks _tick;
  final AuthRepository _auth;

  /// Holds all users of the application.
  UsersRepository(this._datasource, this._tick, this._auth) : super(AsyncValue.loading()) {
    watch(_tick);
    watchAsync(_auth);
  }

  @override
  FutureOr<void> build(Type trigger) {
    guard(
      () => _datasource.getUsers(
        _auth.state.requireData.pick(Webservice.lb_planner_api),
      ),
    );
  }

  @override
  void dispose() {
    _datasource.dispose();
    super.dispose();
  }
}
