import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:sprung/sprung.dart';

/// Adds default animation to a list of widgets.
extension AnimateUtils on List<Widget> {
  /// Animate a list of widgets with a default slide and fade animation.
  ///
  /// - [delay] is the delay before the first animation starts.
  /// - [increment] is the delay between each animation.
  /// - [duration] is the duration of the animation.
  /// - [curve] is the curve of the animation.
  /// - [begin] is the starting position of the animation.
  /// - [end] is the ending position of the animation.
  /// - [limit] is the maximum number of widgets to animate (0 for all).
  List<Widget> show({
    Duration delay = Duration.zero,
    Duration increment = const Duration(milliseconds: 100),
    Duration duration = const Duration(seconds: 1, milliseconds: 500),
    Curve? curve,
    double begin = 2,
    double end = 0,
    int limit = 8,
  }) {
    assert(limit >= 0, 'Limit must be positive');

    curve ??= Sprung.custom(damping: 19);

    var animated = 0;

    final widgets = <Widget>[];

    for (var i = 0; i < length; i++) {
      // Don't animate spacer widgets
      if (this[i] is SizedBox && (this[i] as SizedBox).child == null) {
        widgets.add(this[i]);
        continue;
      }

      if (limit > 0 && animated >= limit) {
        widgets.add(this[i]);
        continue;
      }

      widgets.add(
        this[i]
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
      );

      animated++;
    }

    return widgets;
  }
}

/// Adds default animation to a widget.
extension AnimateX on Widget {
  /// Plays the default show animation for a route widget.
  Animate show(
    AnimationStagger? stagger, {
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = Duration.zero,
  }) {
    return animate().scale(duration: duration, delay: stagger?.add() ?? delay, curve: Curves.easeOutCubic);
  }
}

/// Adds shimmer animation to a widget.
extension ShimmerX on Widget {
  /// Adds themed shimmer animation to a widget.
  Widget applyShimmerThemed(BuildContext context) {
    return applyShimmer(
      baseColor: context.theme.colorScheme.onSurface.withOpacity(0.05),
      highlightColor: context.theme.colorScheme.onSurface.withOpacity(0.1),
    );
  }
}
