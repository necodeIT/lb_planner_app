import 'dart:async';

import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/notifications/notifications.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// UI state control for notifications.
class NotificationsRepository extends Repository<AsyncValue<List<Notification>>> {
  final Ticks _ticks;
  final NotificationsDatasource _datasource;
  final AuthRepository _auth;

  /// UI state control for notifications.
  NotificationsRepository(this._ticks, this._datasource, this._auth) : super(AsyncValue.loading()) {
    watch(_ticks);
    watchAsync(_auth);
  }

  bool _hasUnread = false;

  /// If `true` the current user has unread notifications.
  bool get hasUnreadNotifications => _hasUnread;

  @override
  FutureOr<void> build(Type trigger) async {
    if (!_auth.state.hasData) return;

    if (_auth.state.requireData.isEmpty) return;

    await guard(
      () => _datasource.fetchNotifications(
        _auth.state.requireData[Webservice.lb_planner_api],
      ),
      onData: (data) => _hasUnread = data.any((element) => !element.read),
      onError: (_, __) => _hasUnread = false,
    );
  }

  /// Marks the given [notification] as read.
  Future<void> markAsRead(Notification notification) async {
    await _datasource.markAsRead(
      _auth.state.requireData[Webservice.lb_planner_api],
      notification,
    );
  }

  /// Marks all notifications as read.
  Future<void> markAllAsRead() async {
    if (!state.hasData) return;

    log('Marking all notifications as read');

    final unread = state.requireData.where((element) => !element.read).toList();

    if (unread.isEmpty) {
      log('No notifications to mark as read');
      return;
    }

    log('Marking ${unread.length} notifications as read');

    await _datasource.markAllAsRead(
      _auth.state.requireData[Webservice.lb_planner_api],
      unread,
    );

    _hasUnread = false;

    emit(
      AsyncValue.data(
        state.requireData.map((e) => e.copyWith(read: true)).toList(),
      ),
    );

    log('All notifications marked as read');
  }

  /// Marks the given [notification] as unread.
  Future<void> unread(Notification notification) async {
    await _datasource.unread(
      _auth.state.requireData[Webservice.lb_planner_api],
      notification,
    );
  }

  /// Marks all notifications as unread.
  Future<void> unreadAll() async {
    if (!state.hasData) return;

    log('Marking all notifications as unread');

    final read = state.requireData.where((element) => element.read).toList();

    if (read.isEmpty) {
      log('No notifications to mark as unread');
      return;
    }

    log('Marking ${read.length} notifications as unread');

    await _datasource.unreadAll(
      _auth.state.requireData[Webservice.lb_planner_api],
      read,
    );

    _hasUnread = true;

    emit(
      AsyncValue.data(
        state.requireData.map((e) => e.copyWith(read: false)).toList(),
      ),
    );

    log('All notifications marked as unread');
  }

  @override
  void dispose() {
    super.dispose();
    _datasource.dispose();
  }
}
