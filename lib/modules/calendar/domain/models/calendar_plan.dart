// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';

part 'calendar_plan.freezed.dart';
part 'calendar_plan.g.dart';

/// A plan of when to to which [MoodleTask]s.
@freezed
class CalendarPlan with _$CalendarPlan {
  /// A plan of when to to which [MoodleTask]s.
  const factory CalendarPlan({
    /// The name of this plan.
    required String name,

    /// The ID of this plan.
    @JsonKey(name: 'planid') required int id,

    /// `true` if [MoodleTask]s of type [MoodleTaskType.optional] are enabled.
    @JsonKey(name: 'enableek') @BoolConverter() required bool optionalTasksEnabled,

    /// A list of deadlines planned by it's [members].
    required List<PlanDeadline> deadlines,

    /// A list of all [User]s participating in this plan and their respective access type.
    required List<PlanMember> members,
  }) = _CalendarPlan;

  const CalendarPlan._();

  /// Creates a [CalendarPlan] from a JSON object.
  factory CalendarPlan.fromJson(Map<String, Object?> json) => _$CalendarPlanFromJson(json);
}
