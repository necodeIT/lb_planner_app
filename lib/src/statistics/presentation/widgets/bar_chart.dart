import 'package:flutter/material.dart';
import 'package:lb_planner/src/statistics/statistics.dart';

/// Base class for all bar chart widgets.
abstract class BarChart extends Chart {
  /// Base class for all bar chart widgets.
  const BarChart({
    super.key,
    required super.data,
    required this.shape,
    this.thickness = 20,
    this.spacing,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.fastOutSlowIn,
    this.delay = const Duration(seconds: 1),
  });

  /// The shape of the individual bars.
  final ShapeBorder shape;

  /// The thickness of the bars.
  final double thickness;

  /// The spacing between the bars.
  final double? spacing;

  /// The main axis alignment of the bars.
  final MainAxisAlignment? mainAxisAlignment;

  /// The cross axis alignment of the bars.
  final CrossAxisAlignment? crossAxisAlignment;

  /// The duration of the animation.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  /// The delay before the animation starts.
  final Duration delay;
}
