import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// A bar displaying the current route's title and the current user's name and profile picture.
class TitleBar extends StatefulWidget {
  /// A bar displaying the current route's title and the current user's name and profile picture.
  const TitleBar({super.key});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  @override
  void initState() {
    super.initState();

    Modular.to.addListener(_listener);
  }

  /// Rebuild the widget when the route changes
  /// so we can update the title accordingly.
  void _listener() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();

    final title = Modular.get<TitleBuilder>()(context);

    return user.state.when(
      data: (user) {
        return Row(
          key: ValueKey(title),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
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
              ].show(),
            ),
          ].show(),
        );
      },
      loading: () => _skeleton(context),
      error: (_, __) => _skeleton(context),
    );
  }

  Widget _skeleton(BuildContext context) => Container(
        decoration: ShapeDecoration(
          shape: squircle(),
          color: context.theme.colorScheme.surface,
        ),
        height: 40,
      ).applyShimmerThemed(context);

  @override
  void dispose() {
    Modular.to.removeListener(_listener);
    super.dispose();
  }
}

/// Returns the localized title of the current route.
typedef TitleBuilder = String Function(BuildContext context);
