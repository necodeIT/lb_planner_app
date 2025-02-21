import 'dart:math';

import 'package:eduplanner/lb_planner.dart';
import 'package:flutter/material.dart';

/// A widget that displays a circular chart.
class CircularChart extends Chart {
  /// A widget that displays a circular chart.
  const CircularChart({
    super.key,
    required super.data,
    this.radius,
    super.curve,
    super.delay,
    super.duration,
    super.spacing,
    super.thickness,
  });

  /// The radius of the chart.
  /// If null, it will be set to the width or height of the parent (whichever is smaller).
  final double? radius;

  @override
  double get spacing => super.spacing ?? 10;

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> with SingleTickerProviderStateMixin {
  bool show = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          show = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filter out segments with 0% (won't be drawn).
    final data = widget.data.where((element) => element.percentage > 0).toList();
    // Now, we consider a gap after every segment, so there are data.length gaps.
    final totalSpacing = widget.spacing * data.length;
    final availableDegrees = 360 - totalSpacing;

    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = widget.radius ?? min(constraints.maxWidth, constraints.maxHeight);
              var cumulativeAngle = widget.spacing / 2; // Start with half spacing

              if (!show) {
                return SizedBox(
                  width: size,
                  height: size,
                );
              }

              final segments = <Widget>[];

              for (var i = 0; i < data.length; i++) {
                final value = data[i];
                final segmentAngle = availableDegrees * value.percentage;
                final startAngle = cumulativeAngle;

                cumulativeAngle += segmentAngle + widget.spacing;

                segments.add(
                  Center(
                    child: SizedBox(
                      width: size,
                      height: size,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: startAngle * pi / 180),
                        duration: widget.duration,
                        curve: widget.curve,
                        builder: (context, v1, _) {
                          return Transform.rotate(
                            angle: v1,
                            child: TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: segmentAngle / 360),
                              duration: widget.duration,
                              curve: widget.curve,
                              builder: (context, v, _) => CircularProgressIndicator(
                                value: v,
                                color: value.color,
                                strokeWidth: widget.thickness,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              }

              return Stack(children: segments);
            },
          ),
        ),
      ],
    );
  }
}
