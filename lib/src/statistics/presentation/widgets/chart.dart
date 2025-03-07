import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:flutter/material.dart';

/// Base class for all chart widgets.
abstract class Chart extends StatefulWidget {
  /// Base class for all chart widgets.
  const Chart({
    super.key,
    required this.data,
    this.thickness = 20,
    this.spacing,
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.fastOutSlowIn,
    this.delay = const Duration(seconds: 1),
  });

  /// The data to use for rendering the chart (in order).
  final List<ChartValue> data;

  /// The duration of the animation.
  final Duration duration;

  /// The curve of the animation.
  final Curve curve;

  /// The delay before the animation starts.
  final Duration delay;

  /// The thickness of the bars.
  final double thickness;

  /// The spacing between the bars.
  final double? spacing;
}
