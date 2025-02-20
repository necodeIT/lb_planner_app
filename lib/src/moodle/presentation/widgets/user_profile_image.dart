import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Renders a user's profile image.
class UserProfileImage extends StatelessWidget {
  /// The size of the image.
  final double size;

  /// The ID of the user to render.
  ///
  /// If `null`, the current user is rendered.
  final int? userId;

  /// Renders a user's profile image.
  const UserProfileImage({super.key, this.size = 40, this.userId});

  @override
  Widget build(BuildContext context) {
    final userId = this.userId ?? context.watch<UserRepository>().state.data?.id;
    final theme = context.watch<ThemeRepository>();

    final thembase = theme.currentTheme;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBoringAvatar(
        name: userId?.toString() ?? '0',
        duration: const Duration(milliseconds: 200),
        type: BoringAvatarType.beam,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
        palette: BoringAvatarPalette(
          [
            thembase.accentColor.lighten().withAlpha(153),
            thembase.accentColor.darken(30),
          ],
        ),
      ),
    );
  }
}
