import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boring_avatars/flutter_boring_avatars.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';

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
    final userId = this.userId ?? context.watch<UserRepository>().state.requireData.id;
    final theme = context.watch<ThemeRepository>();

    final thembase = theme.currentTheme;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBoringAvatar(
        name: userId.toString(),
        duration: const Duration(milliseconds: 200),
        type: BoringAvatarType.beam,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
        palette: BoringAvatarPalette(
          [
            thembase.accentColor.lighten().withOpacity(.6),
            thembase.accentColor.darken(30),
          ],
        ),
      ),
    );
  }
}
