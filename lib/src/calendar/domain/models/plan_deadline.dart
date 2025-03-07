// ignore_for_file: invalid_annotation_target

import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_deadline.freezed.dart';
part 'plan_deadline.g.dart';

/// A deadline for a [MoodleTask] in a [CalendarPlan].
@freezed
class PlanDeadline with _$PlanDeadline {
  /// A deadline for a [MoodleTask] in a [CalendarPlan].
  const factory PlanDeadline({
    /// The ID of this deadline.
    @JsonKey(name: 'moduleid') required int id,

    /// The start date of this deadline.
    @JsonKey(name: 'deadlinestart') @UnixTimestampConverter() required DateTime start,

    /// The end date of this deadline.
    @JsonKey(name: 'deadlineend') @UnixTimestampConverter() required DateTime end,
  }) = _PlanDeadline;

  const PlanDeadline._();

  /// Creates a [PlanDeadline] from a JSON object.
  factory PlanDeadline.fromJson(Map<String, Object?> json) => _$PlanDeadlineFromJson(json);
}
