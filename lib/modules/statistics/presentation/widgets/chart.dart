import 'package:flutter/material.dart';
import 'package:lb_planner/modules/statistics/statistics.dart';

/// Base class for all chart widgets.
abstract class Chart extends StatefulWidget {
  /// Base class for all chart widgets.
  const Chart({super.key, required this.data});

  /// The data to use for rendering the chart (in order).
  final List<ChartValue> data;
}
