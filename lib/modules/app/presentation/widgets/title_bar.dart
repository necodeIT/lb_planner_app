import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A bar displaying the current route's title and the current user's name and profile picture.
class TitleBar extends StatelessWidget {
  /// A bar displaying the current route's title and the current user's name and profile picture.
  const TitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();

    return user.state.when(
      data: (user) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  kAppName,
                  style: context.textTheme.titleLarge?.bold,
                ).fontSize(24),
                Row(
                  children: [
                    const Icon(Icons.notifications_outlined),
                    Spacing.xsHorizontal(),
                    const UserProfileImage(),
                    Spacing.xsHorizontal(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullname,
                          style: context.textTheme.titleMedium?.semiBold,
                        ).fontSize(17),
                        if (user.capabilities.isNotEmpty) Text(user.capabilities.highest.name).color(context.theme.colorScheme.primary),
                        'test'.text.color(context.theme.colorScheme.primary),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
      loading: () => _skeleton(context),
      error: (_, __) => _skeleton(context),
    );
  }

  Widget _skeleton(BuildContext context) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kAppName,
                style: context.textTheme.titleLarge?.bold,
              ).fontSize(24),
              Row(
                children: [
                  const Icon(Icons.notifications_outlined),
                  Spacing.xsHorizontal(),
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 40,
                  ),
                  Spacing.xsHorizontal(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mr. Loading',
                        style: context.textTheme.titleMedium?.semiBold,
                      ).fontSize(17),
                      'test'.text.color(context.theme.colorScheme.primary),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Spacing.largeVertical(),
        ],
      ).applyShimmer(
        baseColor: context.theme.colorScheme.onSurface.withOpacity(0.15),
        highlightColor: context.theme.colorScheme.onSurface.withOpacity(0.5),
      );
}
