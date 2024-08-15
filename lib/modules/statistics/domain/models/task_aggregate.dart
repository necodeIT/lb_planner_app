// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/statistics/statistics.dart';

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
}
