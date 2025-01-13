import 'package:flutter/material.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/statistics/statistics.dart';

/// A vertical [BarChart] widget.
class VerticalBarChart extends BarChart {
  /// A vertical [BarChart] widget.
  const VerticalBarChart({super.key, required super.data, required super.shape, super.thickness, super.spacing});

  @override
  State<VerticalBarChart> createState() => _VerticalBarChartState();
}

class _VerticalBarChartState extends State<VerticalBarChart> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final data = widget.data.where((element) => element.percentage > 0).toList();

        final spacing = widget.spacing ?? Spacing.smallSpacing;

        final height = size.maxHeight - spacing * (data.length - 1);

        final heights = data.map((value) => value.percentage * height).toList();

        return Row(
          children: [
            for (var i = 0; i < data.length; i++)
              Container(
                height: heights[i],
                width: widget.thickness,
                decoration: ShapeDecoration(
                  shape: widget.shape,
                  color: data[i].color,
                ),
              ),
          ].vSpaced(spacing).show(),
        );
      },
    );
  }
}
