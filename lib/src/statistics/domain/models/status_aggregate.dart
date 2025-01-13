// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/statistics/statistics.dart';

part 'status_aggregate.freezed.dart';
part 'status_aggregate.g.dart';

/// Aggregate of a set of tasks by [MoodleTask.status].
@freezed
class StatusAggregate with _$StatusAggregate {
  /// Status aggregate of a set of tasks.
  const factory StatusAggregate({
    /// The number of tasks with [MoodleTaskStatus.done].
    required int done,

    /// The number of tasks with [MoodleTaskStatus.pending].
    required int pending,

    /// The number of tasks with [MoodleTaskStatus.uploaded].
    required int uploaded,

    /// The number of tasks with [MoodleTaskStatus.late].
    required int late,
  }) = _StatusAggregate;

  const StatusAggregate._();

  /// The total number of aggregated tasks.
  int get total => done + pending + uploaded + late;

  /// The percentage of [done] tasks.
  double get donePercentage => done.percentageOfOrZero(total);

  /// The percentage of [pending] tasks.
  double get pendingPercentage => pending.percentageOfOrZero(total);

  /// The percentage of [uploaded] tasks.
  double get uploadedPercentage => uploaded.percentageOfOrZero(total);

  /// The percentage of [late] tasks.
  double get latePercentage => late.percentageOfOrZero(total);

  /// Creates a [StatusAggregate] from a JSON object.
  factory StatusAggregate.fromJson(Map<String, Object?> json) => _$StatusAggregateFromJson(json);

  /// Creates a [StatusAggregate] from a set of tasks.
  factory StatusAggregate.fromTasks(Iterable<MoodleTask> tasks) {
    final done = tasks.where((t) => t.status == MoodleTaskStatus.done).length;
    final pending = tasks.where((t) => t.status == MoodleTaskStatus.pending).length;
    final uploaded = tasks.where((t) => t.status == MoodleTaskStatus.uploaded).length;
    final late = tasks.where((t) => t.status == MoodleTaskStatus.late).length;

    return StatusAggregate(done: done, pending: pending, uploaded: uploaded, late: late);
  }
}
