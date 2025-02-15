import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/notifications/notifications.dart';

/// Standard implementation of the [NotificationsDatasource] using Moodle API.
class MoodleNotificationsDatasource extends NotificationsDatasource {
  final ApiService _api;

  /// Standard implementation of the [NotificationsDatasource] using Moodle API.
  MoodleNotificationsDatasource(this._api);

  @override
  void dispose() {
    super.dispose();
    _api.dispose();
  }

  @override
  Future<List<Notification>> fetchNotifications(String token) async {
    final transaction = startTransaction('fetchNotifications');
    final response = await _api.callFunction(
      token: token,
      function: 'local_lbplanner_notifications_get_all_notifications',
      body: {},
    );

    response.assertList();

    await transaction.commit();

    return response.asList.map(Notification.fromJson).toList();
  }

  @override
  Future<void> markAllAsRead(String token, List<Notification> notifications) async {
    final transaction = startTransaction('markAllAsRead');
    for (final notification in notifications) {
      await _setReadStatus(token, notification, true);
    }
    await transaction.commit();
  }

  @override
  Future<void> markAsRead(String token, Notification notification) async {
    await _setReadStatus(token, notification, true);
  }

  @override
  Future<void> unread(String token, Notification notification) async {
    await _setReadStatus(token, notification, false);
  }

  @override
  Future<void> unreadAll(String token, List<Notification> notifications) async {
    for (final notification in notifications) {
      await _setReadStatus(token, notification, false);
    }
  }

  Future<void> _setReadStatus(String token, Notification notification, bool read) async {
    final transaction = startTransaction('setReadStatus');
    await _api.callFunction(
      token: token,
      function: 'local_lbplanner_notifications_update_notification',
      body: {
        'notificationid': notification.id,
        'status': const BoolConverter().toJson(read),
      },
    );
    await transaction.commit();
  }
}
