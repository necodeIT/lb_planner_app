import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/notifications/notifications.dart';

/// Standard implementation of the [NotificationsDatasource] using Moodle API.
class MoodleNotificationsDatasource extends NotificationsDatasource {
  final ApiService _api;

  /// Standard implementation of the [NotificationsDatasource] using Moodle API.
  MoodleNotificationsDatasource(this._api) {
    _api.parent = this;
  }

  @override
  void dispose() {
    super.dispose();
    _api.dispose();
  }

  @override
  Future<List<Notification>> fetchNotifications(String token) async {
    final transaction = startTransaction('fetchNotifications');
    try {
      final response = await _api.callFunction(
        token: token,
        function: 'local_lbplanner_notifications_get_all_notifications',
        body: {},
      );

      response.assertList();

      return response.asList.map(Notification.fromJson).toList();
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> markAllAsRead(String token, List<Notification> notifications) async {
    final transaction = startTransaction('markAllAsRead');
    try {
      for (final notification in notifications) {
        await _setReadStatus(token, notification, true);
      }
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> markAsRead(String token, Notification notification) async {
    final transaction = startTransaction('markAsRead');
    try {
      await _setReadStatus(token, notification, true);
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> unread(String token, Notification notification) async {
    final transaction = startTransaction('markAsUnread');
    try {
      await _setReadStatus(token, notification, false);
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  @override
  Future<void> unreadAll(String token, List<Notification> notifications) async {
    final transaction = startTransaction('markAllAsUnread');
    try {
      for (final notification in notifications) {
        await _setReadStatus(token, notification, false);
      }
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }

  Future<void> _setReadStatus(String token, Notification notification, bool read) async {
    final transaction = startTransaction('setReadStatus');
    try {
      await _api.callFunction(
        token: token,
        function: 'local_lbplanner_notifications_update_notification',
        body: {
          'notificationid': notification.id,
          'status': const BoolConverter().toJson(read),
        },
      );
    } catch (e) {
      transaction.internalError(e);
      rethrow;
    } finally {
      await transaction.commit();
    }
  }
}
