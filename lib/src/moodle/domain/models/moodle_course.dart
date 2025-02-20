// ignore_for_file: invalid_annotation_target

import 'package:eduplanner/config/endpoints.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'moodle_course.freezed.dart';
part 'moodle_course.g.dart';

/// A course on Moodle the user is enrolled in.
@freezed
class MoodleCourse with _$MoodleCourse {
  /// A course on Moodle the user is enrolled in.
  const factory MoodleCourse({
    /// The ID of this course.
    @JsonKey(name: 'courseid') required int id,

    /// The color of this course in hexadecimal format.
    @HexColorConverter() required Color color,

    /// The name of this course.
    required String name,

    /// The shortname chosen by the user for this course.
    /// Limited to 5 characters.
    required String shortname,

    /// Whether the user want's the app to track this course.
    @BoolConverter() required bool enabled,
  }) = _MoodleCourse;

  const MoodleCourse._();

  /// Creates a [MoodleCourse] from a JSON object.
  factory MoodleCourse.fromJson(Map<String, Object?> json) => _$MoodleCourseFromJson(json);

  /// The URL to view this course on Moodle.
  String get url => '$kMoodleServerAdress/course/view.php?id=$id';

  /// Creates a dummy course for skeleton loading.
  factory MoodleCourse.skeleton() => const MoodleCourse(
        id: -1,
        color: Colors.green,
        name: 'Dummy Course',
        shortname: 'DUMMY',
        enabled: true,
      );
}
