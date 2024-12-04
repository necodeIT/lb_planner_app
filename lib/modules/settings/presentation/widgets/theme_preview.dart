import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Renders a preview of a [ThemeBase] and sets it as the user's theme when tapped.
class ThemePreview extends StatelessWidget {
  /// Renders a preview of a [ThemeBase] and sets it as the user's theme when tapped.
  const ThemePreview({super.key, required this.theme});

  /// The theme to preview.
  final ThemeBase theme;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();
    final themes = context.watch<ThemeRepository>();

    return HoverBuilder(
      onTap: () async {
        // Optimistically update the theme
        // so the user sees the change immediately.
        themes.setTheme(theme);

        await user.setTheme(theme.name);
      },
      builder: (context, hover) {
        final highlight = hover || user.state.data?.themeName == theme.name;

        return AnimatedContainer(
          key: ValueKey(theme),
          width: 50,
          height: 50,
          duration: const Duration(milliseconds: 200),
          decoration: ShapeDecoration(
            shape: squircle(
              side: BorderSide(color: theme.accentColor, width: 2, style: highlight ? BorderStyle.solid : BorderStyle.none),
            ),
            color: theme.primaryColor,
            shadows: kElevationToShadow[4],
          ),
          child: Icon(theme.icon, color: theme.accentColor),
        ).withTooltip(theme.name);
      },
    );
  }
}
