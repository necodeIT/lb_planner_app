import 'package:flutter/material.dart';
import 'package:lb_planner/modules/statistics/statistics.dart';

/// Base class for all bar chart widgets.
abstract class BarChart extends Chart {
  /// Base class for all bar chart widgets.
  const BarChart({
    super.key,
    required super.data,
    required this.shape,
    this.thickness = 20,
    this.spacing,
  });

  /// The shape of the individual bars.
  final ShapeBorder shape;

  /// The thickness of the bars.
  final double thickness;

  /// The spacing between the bars.
  final double? spacing;
}
