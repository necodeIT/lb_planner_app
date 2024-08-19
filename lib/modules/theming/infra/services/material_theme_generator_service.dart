import 'package:flutter/material.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Implementation of [ThemeGeneratorService] for [ThemeData].
class MaterialThemeGeneratorService extends ThemeGeneratorService<ThemeData> {
  @override
  void dispose() {}

  @override
  ThemeData generateTheme(ThemeBase themeBase) {
    log('Generating ${themeBase.name} theme');

    final colorScheme = ColorScheme(
      primary: themeBase.accentColor,
      onPrimary: themeBase.onAccentColor,
      secondary: themeBase.accentColor,
      onSecondary: themeBase.onAccentColor,
      brightness: themeBase.brightness,
      error: themeBase.errorColor,
      onError: themeBase.onAccentColor,
      surface: themeBase.primaryColor,
      onSurface: themeBase.textColor,
    );

    final typography = Typography.material2021(colorScheme: colorScheme);

    final textTheme = themeBase.brightness == Brightness.light ? typography.black : typography.white;

    final templateTheme = ThemeData(brightness: themeBase.brightness);

    return ThemeData(
      brightness: themeBase.brightness,
      useMaterial3: false,
      primaryColor: themeBase.secondaryColor,
      dividerColor: themeBase.tertiaryColor,
      canvasColor: themeBase.primaryColor,
      iconTheme: templateTheme.iconTheme.copyWith(
        color: themeBase.textColor,
      ),
      extensions: <ThemeExtension<dynamic>>[
        TaskStatusTheme(
          pendingColor: themeBase.modulePendingColor,
          uploadedColor: themeBase.moduleUploadedColor,
          lateColor: themeBase.errorColor,
          doneColor: themeBase.moduleDoneColor,
        ),
      ],
      colorScheme: colorScheme,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.all<Color>(themeBase.tertiaryColor),
        trackColor: WidgetStateProperty.all<Color>(themeBase.secondaryColor),
        thickness: WidgetStateProperty.all<double>(5),
      ),
      scaffoldBackgroundColor: themeBase.secondaryColor,
      textTheme: textTheme.apply(
        displayColor: themeBase.textColor,
        bodyColor: themeBase.textColor,
        decorationColor: themeBase.textColor,
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
        ),
      ),
    );
  }
}
