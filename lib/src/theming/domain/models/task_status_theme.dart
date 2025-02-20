import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';

/// Theme extension for [MoodleTask.status].
class TaskStatusTheme extends ThemeExtension<TaskStatusTheme> {
  /// Color for [MoodleTaskStatus.late]
  final Color lateColor;

  /// Color for [MoodleTaskStatus.pending]
  final Color pendingColor;

  /// Color for [MoodleTaskStatus.done]
  final Color doneColor;

  /// Color for [MoodleTaskStatus.uploaded]
  final Color uploadedColor;

  /// Theme extension for [MoodleTask.status].
  TaskStatusTheme({required this.lateColor, required this.pendingColor, required this.doneColor, required this.uploadedColor});

  @override
  ThemeExtension<TaskStatusTheme> copyWith({Color? lateColor, Color? pendingColor, Color? doneColor, Color? uploadedColor}) {
    return TaskStatusTheme(
      lateColor: lateColor ?? this.lateColor,
      pendingColor: pendingColor ?? this.pendingColor,
      doneColor: doneColor ?? this.doneColor,
      uploadedColor: uploadedColor ?? this.uploadedColor,
    );
  }

  @override
  ThemeExtension<TaskStatusTheme> lerp(covariant ThemeExtension<TaskStatusTheme>? other, double t) {
    if (other == null) return this;
    if (other is! TaskStatusTheme) return this;
    if (other == this) return this;

    return TaskStatusTheme(
      lateColor: Color.lerp(lateColor, other.lateColor, t)!,
      pendingColor: Color.lerp(pendingColor, other.pendingColor, t)!,
      doneColor: Color.lerp(doneColor, other.doneColor, t)!,
      uploadedColor: Color.lerp(uploadedColor, other.uploadedColor, t)!,
    );
  }
}
