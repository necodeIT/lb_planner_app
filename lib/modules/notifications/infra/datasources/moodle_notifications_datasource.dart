import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/notifications/notifications.dart';

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
    final response = await _api.callFunction(
      token: token,
      function: 'local_lbplanner_notifications_get_all_notifications',
      body: {},
    );

    response.assertList();

    return response.asList.map(Notification.fromJson).toList();
  }

  @override
  Future<void> markAllAsRead(String token, List<Notification> notifications) async {
    for (final notification in notifications) {
      await _setReadStatus(token, notification, true);
    }
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
    await _api.callFunction(
      token: token,
      function: 'local_lbplanner_notifications_update_notification',
      body: {
        'notificationid': notification.id,
        'status': const BoolConverter().toJson(read),
      },
    );
  }
}
