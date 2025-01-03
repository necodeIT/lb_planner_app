import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Standard implementation of [ThemesDatasource].
class StdThemesDatasource extends ThemesDatasource {
  @override
  ThemeBase get defaultTheme => ThemeBase(
        primaryColor: const Color(0xFFFFFFFF),
        secondaryColor: const Color(0xFFF2F3F9),
        tertiaryColor: const Color(0xFFCFCFCF),
        accentColor: const Color(0xFF27BCF3),
        onAccentColor: const Color(0xFFFFFFFF),
        errorColor: const Color(0xFFE74C3C),
        moduleUploadedColor: const Color(0xFFF1C40F),
        moduleDoneColor: const Color(0xFF4FB930),
        modulePendingColor: const Color(0xFF7F8C8D),
        textColor: const Color(0xFF1D1D1D),
        name: 'Light',
        icon: Icons.wb_sunny,
        brightness: Brightness.light,
      );

  @override
  ThemeBase systemTheme() {
    final theme = ui.PlatformDispatcher.instance.platformBrightness == ui.Brightness.light
        ? getThemes().firstWhere((element) => element.name == 'Light')
        : getThemes().firstWhere((element) => element.name == 'Dark');

    return theme.copyWith(
      name: 'default',
      icon: Icons.brightness_auto,
    );
  }

  @override
  List<ThemeBase> getThemes() => [
        defaultTheme,

        // Dark theme
        ThemeBase(
          primaryColor: const Color(0xFF1D1D1D),
          secondaryColor: const Color(0xFF2C2C2C),
          tertiaryColor: const Color(0xFF3C3C3C),
          accentColor: const Color(0xFF27BCF3),
          onAccentColor: const Color(0xFFFFFFFF),
          errorColor: const Color(0xFFE74C3C),
          moduleUploadedColor: const Color(0xFFF1C40F),
          moduleDoneColor: const Color(0xFF4FB930),
          modulePendingColor: const Color(0xFF7F8C8D),
          textColor: const Color(0xFFFFFFFF),
          name: 'Dark',
          icon: Icons.nights_stay,
          brightness: Brightness.dark,
        ),

        // Ocean theme
        ThemeBase(
          brightness: Brightness.dark,
          primaryColor: const Color(0xFF212942),
          secondaryColor: const Color(0xFF262E48),
          tertiaryColor: const Color(0xFF3D4C80),
          accentColor: const Color(0xFF78A5FE),
          textColor: const Color(0xFFF8F2F2),
          onAccentColor: const Color(0xFFF8F2F2),
          moduleDoneColor: const Color(0xFF208767),
          moduleUploadedColor: const Color(0xFFCCB941),
          errorColor: const Color(0xFFD15C4F),
          modulePendingColor: const Color(0xFF626D6E),
          name: 'Ocean',
          icon: FontAwesome5Solid.tint,
        ),

        // 桜 theme
        ThemeBase(
          brightness: Brightness.light,
          primaryColor: const Color(0xFFFCE9EB),
          secondaryColor: const Color(0xFFF3DCDB),
          tertiaryColor: const Color(0xFFECBDB0),
          accentColor: const Color(0xFFF3A39E),
          textColor: const Color(0xFF8C5E6B),
          onAccentColor: const Color(0xFFFCE9EB),
          moduleDoneColor: const Color(0xFFB2C959),
          moduleUploadedColor: const Color(0xFFE5D75A),
          errorColor: const Color(0xFFC26161),
          modulePendingColor: const Color(0xFFE0BAC0),
          icon: FontAwesome5Solid.tree,
          name: 'Sakura',
        ),
      ];
}
