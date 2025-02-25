import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';

/// Displays the user's profile image and name.
class UserWidget extends StatelessWidget {
  /// Displays the user's profile image and name.
  const UserWidget({super.key, required this.user, this.size = 20, this.style, this.expand = false});

  /// The user to display.
  final User user;

  /// The size of the profile image.
  final double size;

  /// The style of the text.
  final TextStyle? style;

  /// If true the widget will expand to fill the available space.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      children: [
        UserProfileImage(
          userId: user.id,
          size: size,
        ),
        Spacing.smallHorizontal(),
        ConditionalWrapper(
          condition: expand,
          wrapper: (context, child) => Expanded(child: child),
          child: Text(
            user.fullname,
            style: style,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
