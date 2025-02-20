import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/statistics/statistics.dart';
import 'package:flutter/material.dart';

/// A horizontal [BarChart] widget.
class HorizontalBarChart extends BarChart {
  /// A horizontal [BarChart] widget.
  const HorizontalBarChart({
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
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
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

        final width = size.maxWidth - spacing * (data.length - 1);

        final widths = data.map((value) => value.percentage * width).toList();

        return Row(
          mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
          crossAxisAlignment: widget.crossAxisAlignment ?? CrossAxisAlignment.center,
          children: <Widget>[
            for (var i = 0; i < data.length; i++)
              AnimatedContainer(
                duration: widget.duration,
                curve: widget.curve,
                width: multiplier * widths[i],
                height: widget.thickness,
                decoration: ShapeDecoration(
                  shape: widget.shape,
                  color: data[i].color,
                ),
              ).withTooltip('${data[i].name}: ${data[i].value}'),
          ].hSpaced(spacing).show(),
        );
      },
    );
  }
}
