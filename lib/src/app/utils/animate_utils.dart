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
  /// - [duration] is the duration of the animation.
  /// - [curve] is the curve of the animation.
  /// - [begin] is the starting position of the animation.
  /// - [end] is the ending position of the animation.
  /// - [limit] is the maximum number of widgets to animate (0 for all).
  List<Widget> show({
    Duration delay = Duration.zero,
    AnimationStagger? stagger,
    Duration duration = const Duration(seconds: 1, milliseconds: 500),
    Curve? curve,
    double begin = 2,
    double end = 0,
    int limit = 16,
    String? keyPrefix,

              key: keyPrefix != null ? ValueKey('$keyPrefix-$i') : null,
  }) {
    assert(limit >= 0, 'Limit must be non-negative');

    stagger ??= AnimationStagger();

    curve ??= Sprung.custom(damping: 19);

    var animated = 0;

    final widgets = <Widget>[];

    for (var i = 0; i < length; i++) {
      // Don't animate spacer widgets
      if (this[i] is SizedBox && (this[i] as SizedBox).child == null) {
        widgets.add(this[i]);
        continue;
      }

      if (this[i] is Static) {
        widgets.add(this[i]);
        continue;
      }

      if (limit > 0 && animated >= limit) {
        widgets.add(this[i]);
        continue;
      }

      final staggeredDelay = delay + stagger.add();

      widgets.add(
        this[i]
            .animate(
              key: keyPrefex != null ? ValueKey('$keyPrefex-$i') : null,
            )
            .slideY(
              begin: begin,
              end: end,
              curve: curve,
              duration: duration,
              delay: staggeredDelay,
            )
            .fadeIn(
              curve: curve,
              duration: duration,
              delay: staggeredDelay,
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
    Key? key,
  }) {
    return animate(key: key).scale(duration: duration, delay: stagger?.add() ?? delay, curve: Curves.easeOutCubic);
  }

  /// Wraps this widget in [Static] to disable animations.
  Static static() => Static(child: this);
}

/// Adds shimmer animation to a widget.
extension ShimmerX on Widget {
  /// Adds themed shimmer animation to a widget.
  Widget applyShimmerThemed(BuildContext context) {
    return applyShimmer(
      baseColor: context.theme.colorScheme.onSurface.withValues(alpha: 0.05),
      highlightColor: context.theme.colorScheme.onSurface.withValues(alpha: 0.1),
    );
  }
}

/// Use this to wrap a widget and mark it as static (i.e. not animated).
/// This is useful when you want to disable animations for a widget when using [AnimateUtils.show].
class Static extends StatelessWidget {
  /// Use this to wrap a widget and mark it as static (i.e. not animated).
  /// This is useful when you want to disable animations for a widget when using [AnimateUtils.show].
  const Static({super.key, required this.child});

  /// The child widget.
  final Widget child;

  @override
  Widget build(BuildContext context) => child;
}
