import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserProfileImage extends StatelessWidget {
  final double size;
  final int? userId;

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
