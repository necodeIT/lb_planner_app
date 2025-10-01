import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';

/// Displays the user's profile image and name.
class UserWidget extends StatelessWidget {
  /// Displays the user's profile image and name.
  const UserWidget({super.key, required this.user, this.size = 20, this.style, this.flexible = false});

  /// The user to display.
  final User user;

  /// The size of the profile image.
  final double size;

  /// The style of the text.
  final TextStyle? style;

  /// If true the widget will expand to fill the available space.
  final bool flexible;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        UserProfileImage(
          userId: user.id,
          size: size,
        ),
        Spacing.smallHorizontal(),
        Text(
          user.fullname,
          style: style,
          overflow: TextOverflow.ellipsis,
        ).flexible(),
      ],
    );
  }
}
