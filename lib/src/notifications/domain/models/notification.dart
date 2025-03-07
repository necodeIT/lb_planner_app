// ignore_for_file: invalid_annotation_target

import 'dart:async';

import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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

    /// Additional context for the notification.
    /// Interpretation depends on the [type].
    @JsonKey(name: 'info') int? context,

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
  ///
  /// [Notification.context] is the [CalendarPlan]'s unique identifier.
  @JsonValue(0)
  invite(inviteMessage, inviteActions),

  /// An invited user has accepted the invitation.
  ///
  /// [Notification.context] is the [PlanInvite]'s unique identifier.
  @JsonValue(1)
  inviteAccepted(inviteAcceptedMessage, noActions),

  /// An invited user has declined the invitation.
  @JsonValue(2)
  inviteDeclined(inviteDeclinedMessage, noActions),

  /// A member has left a shared [CalendarPlan].
  @JsonValue(3)
  planLeft(planLeftMessage, noActions),

  /// The user has been removed from a shared [CalendarPlan].
  @JsonValue(4)
  planRemoved(planRemovedMessage, noActions),

  /// The user has freshly installed the app.
  @JsonValue(5)
  newUser(newUserMessage, noActions),

  /// A teacher has requested the user to cancel a reservation.
  ///
  /// [Notification.context] is the [Reservation.id].
  @JsonValue(6)
  unbookRequested(unimplementedMessage, noActions),

  /// A teacher has forcefully cancelled a reservation made by the user.
  ///
  /// [Notification.context] is the [Reservation.id].
  @JsonValue(7)
  unbookForced(unimplementedMessage, noActions),

  /// A teacher has reserved a slot for the user.
  ///
  /// [Notification.context] is the [Reservation.id].
  @JsonValue(8)
  bookForced(unimplementedMessage, noActions);

  const NotificationType(this.message, this.actions);

  /// Returns a list of actions the user can take on the notification.
  ///
  /// The first element is the action's name, the second is the action's callback.
  final FutureOr<List<(String, FutureOr<void> Function()?)>> Function(BuildContext, Notification) actions;

  /// Returns the message of the notification.
  final Widget Function(BuildContext, Notification) message;
}
