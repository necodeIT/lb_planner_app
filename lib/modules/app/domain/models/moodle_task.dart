// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/modules/app/app.dart';

part 'moodle_task.freezed.dart';
part 'moodle_task.g.dart';

/// A task that is part of a [MoodleCourse].
@freezed
class MoodleTask with _$MoodleTask {
  /// A task that is part of a [MoodleCourse].
  const factory MoodleTask({
    /// The ID of this task.
    @JsonKey(name: 'moduleid') required int id,

    /// The name of this task.
    required String name,

    /// The ID of the course this task is part of.
    @JsonKey(name: 'courseid') required int courseId,

    /// The status of this task.
    required MoodleTaskStatus status,

    /// The type of this task.
    required MoodleTaskType type,

    /// The timestamp of when this task is due in seconds since the Unix epoch.
    @UnixTimestampConverter() required int deadline,

    /// The URL to this task on the Moodle website.
    required String url,
  }) = _MoodleTask;

  const MoodleTask._();

  /// Creates a [MoodleTask] from a JSON object.
  factory MoodleTask.fromJson(Map<String, Object?> json) => _$MoodleTaskFromJson(json);
}

/// The status of a [MoodleTask].
enum MoodleTaskStatus {
  /// The task is done and graded with a passing grade.
  @JsonValue(0)
  done,

  /// The task is done but not graded.
  @JsonValue(1)
  uploaded,

  /// The deadline for the task has passed but the task is not done.
  @JsonValue(2)
  late,

  /// The task is not done and the deadline has not passed.
  @JsonValue(3)
  pending,
}

/// The type of a [MoodleTask].
enum MoodleTaskType {
  /// The task is required to pass the course.
  @JsonValue(0)
  required,

  /// The task isn't required to pass the course but can be done for extra credit.
  @JsonValue(1)
  optional,

  /// The task is an exam.
  @JsonValue(2)
  exam,

  /// The task is a compensation for a failed exam or other task.
  @JsonValue(3)
  compensation,

  /// The task has no effect whatsoever on the course grade.
  @JsonValue(4)
  none,
}
