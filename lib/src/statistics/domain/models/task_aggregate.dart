// ignore_for_file: invalid_annotation_target

import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_aggregate.freezed.dart';
part 'task_aggregate.g.dart';

/// Aggregation of a set of [MoodleTask]s for each property relevant to statistics.
@freezed
class TaskAggregate with _$TaskAggregate {
  /// Aggregation of a set of tasks for each property relevant to statistics.
  const factory TaskAggregate({
    /// Aggregation by status.
    required StatusAggregate status,

    /// Aggregation by type.
    required TypeAggregate type,
  }) = _TaskAggregate;

  const TaskAggregate._();

  /// Creates a [TaskAggregate] from a JSON object.
  factory TaskAggregate.fromJson(Map<String, Object?> json) => _$TaskAggregateFromJson(json);

  /// Creates a [TaskAggregate] from a set of tasks.
  factory TaskAggregate.fromTasks(Iterable<MoodleTask> tasks) {
    final status = StatusAggregate.fromTasks(tasks);
    final type = TypeAggregate.fromTasks(tasks);

    return TaskAggregate(status: status, type: type);
  }

  /// Creates a dummy [TaskAggregate] for the UI to show while data is loading.
  factory TaskAggregate.dummy() => const TaskAggregate(
        status: StatusAggregate(done: 5, pending: 3, uploaded: 2, late: 8),
        type: TypeAggregate(required: 5, optional: 7, compensation: 5, exam: 1, none: 0),
      );
}
