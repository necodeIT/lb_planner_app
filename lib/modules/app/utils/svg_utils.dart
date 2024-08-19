import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';

/// Utility class for theming SVG images.
extension SvgUtils on SvgGenImage {
  /// Creates a themed SVG image based on the current [context].
  /// {@template color_substitution}
  /// Please refer to the table below for the color substitutions:
  ///
  /// | Hex Code   | Replaced with                | Description                                           |
  /// |------------|------------------------------|-------------------------------------------------------|
  /// | `#FF5733`  | `ColorScheme.primary`         | Main color of the app's theme.                        |
  /// | `#FFC300`  | `ColorScheme.secondary`       | Accents and highlights that complement the primary.   |
  /// | `#FF5733`  | `ColorScheme.secondaryVariant` | Lighter or alternate shade of the secondary color.   |
  /// | `#DAF7A6`  | `ColorScheme.surface`         | Surfaces like cards and sheets.                       |
  /// | `#900C3F`  | `ColorScheme.error`           | Error messages and error state indications.           |
  /// | `#581845`  | `ColorScheme.onPrimary`       | Text and icons on top of the primary color.           |
  /// | `#1F618D`  | `ColorScheme.onSecondary`     | Text and icons on top of the secondary color.         |
  /// | `#17202A`  | `ColorScheme.onSurface`       | Text and icons on top of surfaces.                    |
  /// | `#F1C40F`  | `ColorScheme.onError`         | Text and icons on top of error color surfaces.        |
  /// | `#000000`  | `TextTheme.bodyNormal.color`  | Normal text color.                                    |
  /// {@endtemplate}
  SvgPicture themed(
    BuildContext context, {
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme? theme,
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
  }) {
    final loader = SvgAssetLoader(
      path,
      assetBundle: bundle,
      packageName: package,
      theme: theme,
      colorMapper: ContextColorMapper(context),
    );

    return SvgPicture(
      loader,
      key: key,
      matchTextDirection: matchTextDirection,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      colorFilter: colorFilter,
      clipBehavior: clipBehavior,
    );
  }
}

/// {@template color_mapper}
/// A [ColorMapper] that uses the current context to resolve colors based on the active theme.
/// Used in [SvgUtils.themed] to resolve colors in SVG images.
///
/// {@endtemplate}
class ContextColorMapper extends ColorMapper {
  /// The context to use for resolving colors.
  final BuildContext context;

  /// Creates a new [ContextColorMapper] with the given [context].
  ///
  /// ---
  ///
  /// {@macro color_mapper}
  const ContextColorMapper(this.context);

  @override
  Color substitute(String? id, String elementName, String attributeName, Color color) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return switch (color.value) {
      0xFFFF5733 => colorScheme.primary,
      0xFFFFC300 => colorScheme.secondary,
      0xFFDAF7A6 => colorScheme.surface,
      0xFF900C3F => colorScheme.error,
      0xFF581845 => colorScheme.onPrimary,
      0xFF1F618D => colorScheme.onSecondary,
      0xFF17202A => colorScheme.onSurface,
      0xFFF1C40F => colorScheme.onError,
      0xFF000000 => textTheme.bodyMedium?.color ?? color,
      _ => color,
    };
  }
}
