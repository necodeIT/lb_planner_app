import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Implementation of [ThemeGeneratorService] for [ThemeData].
class MaterialThemeGeneratorService extends ThemeGeneratorService<ThemeData> {
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

    final textTheme = (themeBase.brightness == Brightness.light ? typography.black : typography.white).apply(
      displayColor: themeBase.textColor,
      bodyColor: themeBase.textColor,
      decorationColor: themeBase.textColor,
    );

    final templateTheme = ThemeData(brightness: themeBase.brightness, colorScheme: colorScheme, textTheme: textTheme);

    return ThemeData(
      cardTheme: CardTheme(
        color: themeBase.primaryColor,
        elevation: 6,
        margin: EdgeInsets.zero,
        shape: squircle(),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: squircle(radius: 4),
        overlayColor: WidgetStateProperty.all<Color>(Colors.transparent),
        checkColor: WidgetStateProperty.all<Color>(themeBase.onAccentColor),
        side: BorderSide(color: themeBase.accentColor, width: 2),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return themeBase.tertiaryColor.darken();
            }

            return themeBase.accentColor;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.disabled)) {
              return themeBase.tertiaryColor.lighten(20);
            }

            return themeBase.onAccentColor;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
              return 4;
            }

            if (states.contains(WidgetState.disabled)) {
              return 0;
            }

            return 2;
          }),
          shape: WidgetStateProperty.all(squircle(radius: 6)),
        ),
      ),
      tooltipTheme: TooltipThemeData(
        decoration: ShapeDecoration(
          color: themeBase.primaryColor,
          shape: squircle(radius: 5),
          shadows: kElevationToShadow[4],
        ),
        waitDuration: const Duration(seconds: 1),
        textStyle: textTheme.bodySmall,
      ),
      brightness: themeBase.brightness,
      useMaterial3: themeBase.usesMaterial3,
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
      textTheme: textTheme,
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        ),
      ),
      splashColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      cardColor: themeBase.primaryColor,
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          constraints: const BoxConstraints(
            maxHeight: 40,
          ),
          filled: true,
          fillColor: themeBase.secondaryColor,
          isDense: true,
          isCollapsed: true,
          border: OutlineInputBorder(
            borderRadius: squircle().borderRadius,
            borderSide: BorderSide.none,
          ),
        ),
        menuStyle: MenuStyle(
          padding: WidgetStatePropertyAll(PaddingAll(Spacing.smallSpacing).Vertical(Spacing.mediumSpacing)),
          backgroundColor: WidgetStatePropertyAll(themeBase.secondaryColor),
          shape: WidgetStatePropertyAll(squircle()),
          elevation: const WidgetStatePropertyAll(8),
          alignment: Alignment.bottomCenter * 5,
        ),
      ),
      menuButtonTheme: MenuButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStateProperty.all(PaddingAll(Spacing.mediumSpacing).Vertical(Spacing.xsSpacing)),
          shape: WidgetStateProperty.all(squircle()),
          animationDuration: Duration.zero,
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
                return themeBase.accentColor;
              }

              return themeBase.secondaryColor;
            },
          ),
          iconColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
                return themeBase.onAccentColor;
              }

              return themeBase.textColor;
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.hovered) || states.contains(WidgetState.focused)) {
                return themeBase.onAccentColor;
              }

              return themeBase.textColor;
            },
          ),
        ),
      ),
    );
  }
}
