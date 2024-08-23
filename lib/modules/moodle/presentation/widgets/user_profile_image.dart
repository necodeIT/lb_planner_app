import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';

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
    late User user;

    if (userId == null) {
      user = context.watch<UserRepository>().state.requireData;
    }

    return ClipOval(
      child: Image.network(
        user.profileImageUrl,
        width: size,
        height: size,
      ),
    );
  }
}
