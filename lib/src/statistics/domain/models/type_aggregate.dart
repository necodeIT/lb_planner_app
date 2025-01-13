// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/statistics/statistics.dart';

part 'type_aggregate.freezed.dart';
part 'type_aggregate.g.dart';

/// Aggregate of a set of tasks by [MoodleTask.type].
@freezed
class TypeAggregate with _$TypeAggregate {
  /// Aggregate of a set of tasks by [MoodleTask.type].
  const factory TypeAggregate({
    /// The number of tasks with [MoodleTaskType.required].
    required int required,

    /// The number of tasks with [MoodleTaskType.optional].
    required int optional,

    /// The number of tasks with [MoodleTaskType.compensation].
    required int compensation,

    /// The number of tasks with [MoodleTaskType.exam].
    required int exam,

    /// The number of tasks with [MoodleTaskType.none].
    required int none,
  }) = _TypeAggregate;

  const TypeAggregate._();

  /// The total number of aggregated tasks.
  int get total => this.required + optional + compensation + exam + none;

  /// The percentage of [required] tasks.
  double get requiredPercentage => this.required.percentageOfOrZero(total);

  /// The percentage of [optional] tasks.
  double get optionalPercentage => optional.percentageOfOrZero(total);

  /// The percentage of [compensation] tasks.
  double get compensationPercentage => compensation.percentageOfOrZero(total);

  /// The percentage of [exam] tasks.
  double get examPercentage => exam.percentageOfOrZero(total);

  /// The percentage of [none] tasks.
  double get nonePercentage => none.percentageOfOrZero(total);

  /// Creates a [TypeAggregate] from a JSON object.
  ///
  factory TypeAggregate.fromJson(Map<String, Object?> json) => _$TypeAggregateFromJson(json);

  /// Creates a [TypeAggregate] from a set of tasks.
  factory TypeAggregate.fromTasks(Iterable<MoodleTask> tasks) {
    final required = tasks.where((t) => t.type == MoodleTaskType.required).length;
    final optional = tasks.where((t) => t.type == MoodleTaskType.optional).length;
    final compensation = tasks.where((t) => t.type == MoodleTaskType.compensation).length;
    final exam = tasks.where((t) => t.type == MoodleTaskType.exam).length;
    final none = tasks.where((t) => t.type == MoodleTaskType.none).length;

    return TypeAggregate(required: required, optional: optional, compensation: compensation, exam: exam, none: none);
  }
}
