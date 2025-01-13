// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/slots/slots.dart';

part 'slot_aggregate.freezed.dart';

/// An aggregate of a [Slot] with its [User] supervisors and [MoodleCourse].
@freezed
class SlotAggregate with _$SlotAggregate {
  /// An aggregate of a [Slot] with its [User] supervisors and [MoodleCourse].
  const factory SlotAggregate({
    required List<User> supervisors,
    required MoodleCourse course,
    required Slot slot,
  }) = _SlotAggregate;

  const SlotAggregate._();

  /// Creates a [SlotAggregate] from the given [slot], [users], [courses] and [mappings].
  factory SlotAggregate.join({
    required Slot slot,
    required List<User> users,
    required List<MoodleCourse> courses,
    required List<CourseToSlot> mappings,
  }) =>
      SlotAggregate(
        slot: slot,
        supervisors: users.where((user) => slot.supervisors.contains(user.id)).toList(),
        course: courses.firstWhere(
          (course) => mappings.any(
            (mapping) => mapping.slotId == slot.id && mapping.courseId == course.id,
          ),
        ),
      );
}

/// Aggregates a [Slot] with its [User] supervisors and [MoodleCourse].
extension SlotX on Slot {
  /// Aggregates a [Slot] with its [User] supervisors and [MoodleCourse].
  SlotAggregate join({
    required List<User> users,
    required List<MoodleCourse> courses,
    required List<CourseToSlot> mappings,
  }) =>
      SlotAggregate.join(slot: this, users: users, courses: courses, mappings: mappings);
}

/// Aggregates a list of [Slot]s with their [User] supervisors and [MoodleCourse]s.
extension SlotAggregateX on Iterable<Slot> {
  /// Aggregates a list of [Slot]s with their [User] supervisors and [MoodleCourse]s.
  List<SlotAggregate> join({
    required List<User> users,
    required List<MoodleCourse> courses,
    required List<CourseToSlot> mappings,
  }) =>
      map((slot) => slot.join(users: users, courses: courses, mappings: mappings)).toList();
}
