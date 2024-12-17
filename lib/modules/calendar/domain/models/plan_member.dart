// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';

part 'plan_member.freezed.dart';
part 'plan_member.g.dart';

/// A member of a [CalendarPlan].
@freezed
class PlanMember with _$PlanMember implements Comparable<PlanMember> {
  /// A member of a [CalendarPlan].
  const factory PlanMember({
    /// The ID of the [User].
    @JsonKey(name: 'userid') required int id,

    /// The access type of the member.
    @JsonKey(name: 'accesstype') required PlanMemberAccessType accessType,
  }) = _PlanMember;

  const PlanMember._();

  /// Creates a [PlanMember] from a JSON object.
  factory PlanMember.fromJson(Map<String, Object?> json) => _$PlanMemberFromJson(json);

  @override
  int compareTo(PlanMember other) => accessType.index - other.accessType.index;
}

/// The access type of a member in a plan.
enum PlanMemberAccessType {
  /// The user is the owner of the plan.
  @JsonValue(0)
  owner,

  /// The user can write to the plan.
  @JsonValue(1)
  write,

  /// The user may only read the plan and is prohibited from editing.
  @JsonValue(2)
  read,
}
