import 'dart:async';

import 'package:eduplanner/config/endpoints.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/notifications/notifications.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// UI state control for notifications.
class NotificationsRepository extends Repository<AsyncValue<List<Notification>>> with Tracable {
  final NotificationsDatasource _datasource;
  final AuthRepository _auth;

  /// UI state control for notifications.
  NotificationsRepository(this._datasource, this._auth) : super(AsyncValue.loading()) {
    watchAsync(_auth);

    _datasource.parent = this;
  }

  @override
  Duration get updateInterval => kRefreshIntervalDuration;

  /// If `true` the current user has unread notifications.
  bool get hasUnreadNotifications => state.data?.any((element) => !element.read) ?? false;

  @override
  FutureOr<void> build(Trigger trigger) async {
    waitForData(_auth);

    if (_auth.state.requireData.isEmpty) return;

    final transaction = startTransaction('loadNotifications');

    await guard(
      () async => _datasource.fetchNotifications(
        _auth.state.requireData[Webservice.lb_planner_api],
      ),
      onData: (_) => log('Notifications loaded.'),
      onError: (e, s) {
        log('Failed to load Notfications', e, s);
        transaction.internalError(e);
      },
    );

    await transaction.commit();
  }

  /// Marks the given [notification] as read.
  Future<void> markAsRead(Notification notification) async {
    if (!state.hasData) return;

    final transaction = startTransaction('markAsRead');

    try {
      data(
        state.requireData.map((e) {
          if (e.id == notification.id) {
            return e.copyWith(read: true);
          }

          return e;
        }).toList(),
      );

      await _datasource.markAsRead(
        _auth.state.requireData[Webservice.lb_planner_api],
        notification,
      );

      await captureEvent('notification_read');
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
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

    final transaction = startTransaction('markAllAsRead');

    try {
      await _datasource.markAllAsRead(
        _auth.state.requireData[Webservice.lb_planner_api],
        unread,
      );

      emit(
        AsyncValue.data(
          state.requireData.map((e) => e.copyWith(read: true)).toList(),
        ),
      );

      log('All notifications marked as read');

      await captureEvent('notifications_read');
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Marks the given [notification] as unread.
  Future<void> unread(Notification notification) async {
    if (!state.hasData) return;

    final transaction = startTransaction('unread');

    try {
      data(
        state.requireData.map((e) {
          if (e.id == notification.id) {
            return e.copyWith(read: false);
          }

          return e;
        }).toList(),
      );

      await _datasource.unread(
        _auth.state.requireData[Webservice.lb_planner_api],
        notification,
      );

      await captureEvent('notification_unread');
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
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

    final transaction = startTransaction('unrealAll');

    try {
      await _datasource.unreadAll(
        _auth.state.requireData[Webservice.lb_planner_api],
        read,
      );

      emit(
        AsyncValue.data(
          state.requireData.map((e) => e.copyWith(read: false)).toList(),
        ),
      );

      log('All notifications marked as unread');

      await captureEvent('notifications_unread');
    } catch (e) {
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// The unread notifications.
  List<Notification> get unreadNotifications => state.data?.where((element) => !element.read).toList() ?? [];

  /// Filters notifications based on the provided parameters.
  List<Notification> filter({
    NotificationType? type,
    bool? read,
    DateTime? readBefore,
    DateTime? readAfter,
    DateTime? timestampBefore,
    DateTime? timestampAfter,
  }) {
    if (!state.hasData) return [];

    return state.requireData.where((element) {
      if (type != null && element.type != type) return false;
      if (read != null && element.read != read) return false;
      if (readBefore != null && element.readAt == null) return false;
      if (readBefore != null && element.readAt!.isAfter(readBefore)) return false;
      if (readAfter != null && element.readAt == null) return false;
      if (readAfter != null && element.readAt!.isBefore(readAfter)) return false;
      if (timestampBefore != null && element.timestamp.isAfter(timestampBefore)) return false;
      if (timestampAfter != null && element.timestamp.isBefore(timestampAfter)) return false;

      return true;
    }).toList();
  }

  @override
  void dispose() {
    super.dispose();
    _datasource.dispose();
  }
}
