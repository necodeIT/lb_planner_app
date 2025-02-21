import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:flutter/material.dart';

/// Base class for all bar chart widgets.
abstract class BarChart extends Chart {
  /// Base class for all bar chart widgets.
  const BarChart({
    super.key,
    required super.data,
    required this.shape,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    super.curve,
    super.delay,
    super.duration,
    super.spacing,
    super.thickness,
  });

  /// The shape of the individual bars.
  final ShapeBorder shape;

  /// The main axis alignment of the bars.
  final MainAxisAlignment? mainAxisAlignment;

  /// The cross axis alignment of the bars.
  final CrossAxisAlignment? crossAxisAlignment;
}
