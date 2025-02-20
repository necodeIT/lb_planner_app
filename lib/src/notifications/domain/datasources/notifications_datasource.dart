import 'package:eduplanner/lb_planner.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Fetches the user's notifications.
abstract class NotificationsDatasource extends Datasource with Tracable {
  @override
  String get name => 'Notifications';

  /// Fetches the user's notifications.
  Future<List<Notification>> fetchNotifications(String token);

  /// Marks the given [notification] as read.
  Future<void> markAsRead(String token, Notification notification);

  /// Marks all [notifications] as read.
  Future<void> markAllAsRead(String token, List<Notification> notifications);

  /// Marks the given [notification] as unread.
  Future<void> unread(String token, Notification notification);

  /// Marks all [notifications] as unread.
  Future<void> unreadAll(String token, List<Notification> notifications);
}
