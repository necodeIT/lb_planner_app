import 'package:eduplanner/src/theming/theming.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart' hide Theme;
import 'package:mcquenji_core/mcquenji_core.dart';

/// A service that generates a theme of type [Theme] based on a [ThemeBase].
abstract class ThemeGeneratorService<Theme> extends Service {
  @override
  String get name => 'ThemeGenerator';

  /// Generates a theme based on the provided [themeBase].
  Theme generateTheme(ThemeBase themeBase);
}

/// Creates a squircle border with the given [radius].
SmoothRectangleBorder squircle({
  BorderSide side = BorderSide.none,
  double radius = 10,
  bool topLeft = true,
  bool topRight = true,
  bool bottomLeft = true,
  bool bottomRight = true,
  bool left = true,
  bool right = true,
  bool top = true,
  bool bottom = true,
  BorderAlign borderAlign = BorderAlign.inside,
}) {
  final _radius = SmoothRadius(
    cornerRadius: radius,
    cornerSmoothing: 0.9,
  );

  return SmoothRectangleBorder(
    side: side,
    borderAlign: borderAlign,
    borderRadius: SmoothBorderRadius.only(
      topLeft: topLeft ? _radius : SmoothRadius.zero,
      topRight: topRight ? _radius : SmoothRadius.zero,
      bottomLeft: bottomLeft ? _radius : SmoothRadius.zero,
      bottomRight: bottomRight ? _radius : SmoothRadius.zero,
    ),
  );
}
