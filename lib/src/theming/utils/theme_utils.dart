import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';

/// Adds a [TaskStatusTheme] getter to [ThemeData].
extension ThemeUtils on ThemeData {
  /// The [TaskStatusTheme] of this theme.
  TaskStatusTheme get taskStatusTheme => extension<TaskStatusTheme>()!;
}
