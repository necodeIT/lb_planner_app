import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/theming/theming.dart';
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
}) =>
    SmoothRectangleBorder(
      side: side,
      borderRadius: SmoothBorderRadius(
        cornerRadius: radius,
        cornerSmoothing: 0.9,
      ),
    );
