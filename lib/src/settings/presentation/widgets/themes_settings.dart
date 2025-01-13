import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/settings/settings.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// A section of the settings screen that allows the user to change the app's theme.
class ThemesSettings extends StatelessWidget {
  /// A section of the settings screen that allows the user to change the app's theme.
  const ThemesSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final themes = context.watch<ThemesDatasource>();

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.settings_theme,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Spacing.mediumVertical(),
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: Spacing.mediumSpacing,
                  runSpacing: Spacing.mediumSpacing,
                  children: [
                    ThemePreview(theme: themes.systemTheme()),
                    for (final theme in themes.getThemes()) ThemePreview(theme: theme),
                  ].show(
                    begin: .5,
                  ),
                ).alignAtTopLeft(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
