// ignore_for_file: invalid_annotation_target

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'theme_base.freezed.dart';

/// Contains some basic information about a theme which is later used to generate a fully fledged theme.
@freezed
class ThemeBase with _$ThemeBase {
  /// Contains some basic information about a theme which is later used to generate a fully fledged theme.
  factory ThemeBase({
    /// The color to use for the surface of components.
    required Color primaryColor,

    /// The color to use for the background of the app.
    required Color secondaryColor,

    /// The color to use for separators and dividers.
    required Color tertiaryColor,

    /// The color to use for buttons and other interactive elements.
    required Color accentColor,

    /// The color to use for text on top of the primary color.
    required Color onAccentColor,

    /// The color to use to indicate errors.
    required Color errorColor,

    /// The color to use for modules that are completed.
    required Color moduleDoneColor,

    /// The color to use for modules that are pending.
    required Color modulePendingColor,

    /// The color to use for modules that have been uploaded.
    required Color moduleUploadedColor,

    /// The color to use for text.
    required Color textColor,

    /// The name of the theme.
    required String name,

    /// The icon of the theme.
    required IconData icon,

    /// The brightness of the theme.
    required Brightness brightness,

    /// Whether the theme uses Material 3.
    @Default(false) bool usesMaterial3,
  }) = _ThemeBase;

  const ThemeBase._();
}
