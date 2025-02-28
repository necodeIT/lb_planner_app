// ignore_for_file: invalid_annotation_target

import 'dart:ui';

import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_value.freezed.dart';

/// Holds the data for a single value represented in a [Chart].
@freezed
class ChartValue with _$ChartValue {
  /// Holds the data for a single value represented in a [Chart].
  const factory ChartValue({
    /// The name of the value.
    required String name,

    /// The value itself.
    required double value,

    /// The percentage of the value compared to the total.
    required double percentage,

    /// The color of the value.
    required Color color,
  }) = _ChartValue;

  const ChartValue._();
}
