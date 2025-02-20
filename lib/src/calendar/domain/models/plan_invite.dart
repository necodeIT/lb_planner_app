// ignore_for_file: invalid_annotation_target

import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_invite.freezed.dart';
part 'plan_invite.g.dart';

/// An invitation to a [CalendarPlan].
@freezed
class PlanInvite with _$PlanInvite {
  /// An invitation to a [CalendarPlan].
  const factory PlanInvite({
    /// The ID of this invitation.
    required int id,

    /// The ID of the [User] who created this invite.
    @JsonKey(name: 'inviterid') required int inviterId,

    /// The ID of the [CalendarPlan] this invite is for.
    @JsonKey(name: 'planid') required int planId,

    /// The ID of the [User] who is invited.
    @JsonKey(name: 'inviteeid') required int invitedUserId,

    /// The status of this invite.
    required PlanInviteStatus status,

    /// The date and time this invite was created.
    @UnixTimestampConverter() required DateTime timestamp,
  }) = _PlanInvite;

  const PlanInvite._();

  /// Creates a [PlanInvite] from a JSON object.
  factory PlanInvite.fromJson(Map<String, Object?> json) => _$PlanInviteFromJson(json);
}

/// The status of a [PlanInvite].
enum PlanInviteStatus {
  /// The invited user is yet to respond.
  @JsonValue(0)
  pending,

  /// The invited user has accepted the invite and is now a member of the plan.
  @JsonValue(1)
  accepted,

  /// The invited user has declined the invite.
  @JsonValue(2)
  declined,
}
