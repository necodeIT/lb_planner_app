import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sprung/sprung.dart';

/// Adds default animation to a list of widgets.
extension AnimateUtils on List<Widget> {
  /// Animate a list of widgets with a default slide and fade animation.
  List<Widget> show({
    Duration delay = Duration.zero,
    Duration increment = const Duration(milliseconds: 100),
    Duration duration = const Duration(seconds: 1, milliseconds: 500),
    Curve? curve,
    double begin = 2,
    double end = 0,
  }) {
    curve ??= Sprung.custom(damping: 19);

    return [
      for (var i = 0; i < length; i++)
        this[i] is SizedBox && (this[i] as SizedBox).child == null // Don't animate spacer widgets
            ? this[i]
            : this[i]
                .animate()
                .slideY(
                  begin: begin,
                  end: end,
                  curve: curve,
                  duration: duration,
                  delay: delay + increment * i,
                )
                .fadeIn(
                  curve: curve,
                  duration: duration,
                  delay: delay + increment * i,
                ),
    ];
  }
}
