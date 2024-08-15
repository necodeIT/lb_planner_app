// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

/// A notification users receive.
@freezed
class Notification with _$Notification {
  /// A notification users receive.
  const factory Notification({
    /// The notification's unique identifier.
    @JsonKey(name: 'notificationid') required int id,

    /// The timestamp when the notification was sent.
    @UnixTimestampConverter() required DateTime timestamp,

    /// The timestamp when the notification was read.
    @UnixTimestampConverter() @JsonKey(name: 'timestamp_read') DateTime? readAt,

    /// The type of the notification.
    ///
    /// The message is displayed differently based on the type.
    required NotificationType type,

    /// `true` if the notification has been read.
    @BoolConverter() @JsonKey(name: 'status') required bool read,
    @JsonKey(name: 'userid') required int userId,
  }) = _Notification;

  const Notification._();

  /// Creates a [Notification] from a JSON object.
  factory Notification.fromJson(Map<String, Object?> json) => _$NotificationFromJson(json);
}

/// The type of a  [Notification].
enum NotificationType {
  /// The user has been invited to a [CalendarPlan].
  @JsonValue(0)
  invite,

  /// An invited user has accepted the invitation.
  @JsonValue(1)
  inviteAccepted,

  /// An invited user has declined the invitation.
  @JsonValue(2)
  inviteDeclined,

  /// A member has left a shared [CalendarPlan].
  @JsonValue(3)
  planLeft,

  /// The user has been removed from a shared [CalendarPlan].
  @JsonValue(4)
  planRemoved,

  /// The user has freshly installed the app.
  @JsonValue(5)
  newUser,
}
