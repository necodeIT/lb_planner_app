import 'dart:async';

import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A repository that manages the current theme.
class ThemeRepository extends Repository<ThemeData> with Tracable {
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

    final transaction = startTransaction('loadThemes');

    try {
      setThemeByName(_user.state.requireData.themeName);
    } catch (e, s) {
      log('Failed to load themes.', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
  }

  /// Sets the theme to the provided [themeBase].
  Future<void> setTheme(ThemeBase themeBase) async {
    final transaction = startTransaction('setTheme');
    try {
      log('Setting theme to ${themeBase.name}');

      emit(_generator.generateTheme(themeBase));

      _currentTheme = themeBase;
    } catch (e, s) {
      log('Failed to set Theme', e, s);
      transaction.internalError(e);
    } finally {
      await transaction.commit();
    }
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
