import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:lb_planner/src/theming/theming.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A repository that manages the current theme.
class ThemeRepository extends Repository<ThemeData> {
  final ThemeGeneratorService<ThemeData> _generator;
  final ThemesDatasource _themes;
  final UserRepository _user;

  ThemeBase? _currentTheme;

  /// The current theme.
  ThemeBase get currentTheme => _currentTheme ?? _themes.defaultTheme;

  /// A repository that manages the current theme.
  ThemeRepository(this._generator, this._themes, this._user) : super(_generator.generateTheme(_themes.defaultTheme)) {
    _currentTheme = _themes.defaultTheme;

    watch(_user);
  }

  @override
  FutureOr<void> build(BuildTrigger trigger) async {
    if (!_user.state.hasData) return;

    setThemeByName(_user.state.requireData.themeName);
  }

  /// Sets the theme to the provided [themeBase].
  void setTheme(ThemeBase themeBase) {
    log('Setting theme to ${themeBase.name}');

    emit(_generator.generateTheme(themeBase));

    _currentTheme = themeBase;
  }

  /// Sets the theme by [name].
  ///
  /// If the theme is not found, [ThemesDatasource.defaultTheme] will be used.
  void setThemeByName(String name) {
    setTheme(
      _themes.getThemes().firstWhere(
            (element) => element.name == name,
            orElse: _themes.systemTheme,
          ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _generator.dispose();
  }
}
