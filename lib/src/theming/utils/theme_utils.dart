import 'package:flutter/material.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// Adds a [TaskStatusTheme] getter to [ThemeData].
extension ThemeUtils on ThemeData {
  /// The [TaskStatusTheme] of this theme.
  TaskStatusTheme get taskStatusTheme => extension<TaskStatusTheme>()!;
}
