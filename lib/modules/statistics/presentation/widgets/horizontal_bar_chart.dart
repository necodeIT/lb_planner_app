import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/statistics/statistics.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A horizontal [BarChart] widget.
class HorizontalBarChart extends BarChart {
  /// A horizontal [BarChart] widget.
  const HorizontalBarChart({
    super.key,
    required super.data,
    required super.shape,
    super.thickness,
    super.spacing,
  });

  @override
  State<HorizontalBarChart> createState() => _HorizontalBarChartState();
}

class _HorizontalBarChartState extends State<HorizontalBarChart> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final data = widget.data.where((element) => element.percentage > 0).toList();

        final spacing = widget.spacing ?? Spacing.smallSpacing;

        final width = size.maxWidth - spacing * (data.length - 1);

        final widths = data.map((value) => value.percentage * width).toList();

        return Row(
          children: <Widget>[
            for (var i = 0; i < data.length; i++)
              Container(
                width: widths[i],
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
