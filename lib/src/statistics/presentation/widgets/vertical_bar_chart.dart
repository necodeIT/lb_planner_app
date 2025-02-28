import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:flutter/material.dart';

/// A vertical [BarChart] widget.
class VerticalBarChart extends BarChart {
  /// A vertical [BarChart] widget.
  const VerticalBarChart({
    super.key,
    required super.data,
    required super.shape,
    super.thickness,
    super.spacing,
    super.mainAxisAlignment,
    super.crossAxisAlignment,
    super.duration,
    super.curve,
    super.delay,
  });

  @override
  State<VerticalBarChart> createState() => _VerticalBarChartState();
}

class _VerticalBarChartState extends State<VerticalBarChart> {
  int multiplier = 0;

  @override
  void initState() {
    super.initState();

    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          multiplier = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final data = widget.data.where((element) => element.percentage > 0).toList();

        final spacing = widget.spacing ?? Spacing.smallSpacing;

        final height = size.maxHeight - spacing * (data.length - 1);

        final heights = data.map((value) => value.percentage * height).toList();

        return Row(
          mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < data.length; i++)
              AnimatedContainer(
                height: multiplier * heights[i],
                width: widget.thickness,
                duration: widget.duration,
                curve: widget.curve,
                decoration: ShapeDecoration(
                  shape: widget.shape,
                  color: data[i].color,
                ),
              ),
          ].hSpaced(spacing),
        );
      },
    );
  }
}
