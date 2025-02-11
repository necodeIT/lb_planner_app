// ignore_for_file: invalid_annotation_target

import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/config/endpoints.dart';
import 'package:lb_planner/lb_planner.dart';

part 'moodle_task.freezed.dart';
part 'moodle_task.g.dart';

/// A task that is part of a [MoodleCourse].
@freezed
class MoodleTask with _$MoodleTask {
  /// A task that is part of a [MoodleCourse].
  const factory MoodleTask({
    /// The ID of this task.
    @JsonKey(name: 'assignid') required int id,

    /// The id of the task within it's parent [MoodleCourse].
    @JsonKey(name: 'cmid ') required int cmid,

    /// The name of this task.
    required String name,

    /// The ID of the [MoodleCourse] this task is part of.
    @JsonKey(name: 'courseid') required int courseId,

    /// The status of this task.
    required MoodleTaskStatus status,

    /// The type of this task.
    required MoodleTaskType type,

    /// The timestamp of when this task is due in seconds since the Unix epoch.
    @UnixTimestampConverterNullable() DateTime? deadline,
  }) = _MoodleTask;

  const MoodleTask._();

  /// Creates a [MoodleTask] from a JSON object.
  factory MoodleTask.fromJson(Map<String, Object?> json) => _$MoodleTaskFromJson(json);

  /// The URL to this task on the Moodle website.
  String get url => 'https://$kMoodleServerAdress/mod/assign/view.php?id=$cmid';
}

/// The status of a [MoodleTask].
enum MoodleTaskStatus {
  /// The task is done and graded with a passing grade.
  @JsonValue(0)
  done(_done),

  /// The task is done but not graded.
  @JsonValue(1)
  uploaded(_uploaded),

  /// The deadline for the task has passed but the task is not done.
  @JsonValue(2)
  late(_late),

  /// The task is not done and the deadline has not passed.
  @JsonValue(3)
  pending(_pending);

  const MoodleTaskStatus(this.translate);

  /// Translates the status to a string based on the [BuildContext].
  final Translator translate;

  static String _done(BuildContext context) => context.t.enum_taskStatus_done;
  static String _uploaded(BuildContext context) => context.t.enum_taskStatus_uploaded;
  static String _late(BuildContext context) => context.t.enum_taskStatus_late;
  static String _pending(BuildContext context) => context.t.enum_taskStatus_pending;
}

/// The type of a [MoodleTask].
enum MoodleTaskType {
  /// The task is required to pass the course.
  @JsonValue(0)
  required(_required),

  /// The task isn't required to pass the course but can be done for extra credit.
  @JsonValue(1)
  optional(_optional),

  /// The task is an exam.
  @JsonValue(2)
  exam(_exam),

  /// The task is a compensation for a failed exam or other task.
  @JsonValue(3)
  compensation(_compensation),

  /// The task has no effect whatsoever on the course grade.
  @JsonValue(4)
  none(_none);

  /// Translates the type to a string based on the [BuildContext].
  final Translator translate;

  const MoodleTaskType(this.translate);

  static String _required(BuildContext context) => 'GK';
  static String _optional(BuildContext context) => 'EK';
  static String _exam(BuildContext context) => 'Exam';
  static String _compensation(BuildContext context) => 'M';
  static String _none(BuildContext context) => 'N/A';
}
