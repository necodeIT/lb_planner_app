// ignore_for_file: invalid_annotation_target

import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/slots/slots.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_to_slot.freezed.dart';
part 'course_to_slot.g.dart';

/// Maps a [MoodleCourse] to a [Slot].
@freezed
class CourseToSlot with _$CourseToSlot {
  /// Maps a [MoodleCourse] to a [Slot].
  const factory CourseToSlot({
    /// Unique identifier of this mapping.
    required int id,

    /// The id of the course.
    @JsonKey(name: 'courseid') required int courseId,

    /// The id of the slot.
    @JsonKey(name: 'slotid') required int slotId,

    /// The vintage a user must be in to attend this slot.
    required Vintage vintage,
  }) = _CourseToSlot;

  /// Maps a [MoodleCourse] to a [Slot] without an id.
  factory CourseToSlot.noId({required int courseId, required int slotId, required Vintage vintage}) => CourseToSlot(
        id: -1,
        courseId: courseId,
        slotId: slotId,
        vintage: vintage,
      );

  const CourseToSlot._();

  /// Creates a [CourseToSlot] mapping from [json].
  factory CourseToSlot.fromJson(Map<String, Object?> json) => _$CourseToSlotFromJson(json);
}
