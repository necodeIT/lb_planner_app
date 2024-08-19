import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Provides button extensions on [CircularProgressIndicator].
extension ButtonUtils on CircularProgressIndicator {
  /// Makes this progress indicator usable as [ElevatedButton.child].
  Widget button() {
    return Center(
      child: SizedBox.square(
        dimension: 18,
        child: CircularProgressIndicator(
          color: Modular.get<ThemeRepository>().state.colorScheme.onPrimary,
          strokeCap: StrokeCap.round,
          key: key,
          strokeWidth: 2.5,
        ),
      ),
    );
  }
}
