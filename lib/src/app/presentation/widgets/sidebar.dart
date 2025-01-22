import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/auth/auth.dart';

/// Navigation sidebar for the application.
class Sidebar extends StatelessWidget {
  /// Navigation sidebar for the application.
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final capabilities = context.watch<UserRepository>().state.data?.capabilities ?? {};

    return Container(
      width: 60,
      decoration: BoxDecoration(
        color: context.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Padding(
        padding: PaddingVertical(Spacing.mediumSpacing).Horizontal(Spacing.xsSpacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                if (capabilities.hasStudent)
                  SidebarTarget(
                    route: '/dashboard/',
                    icon: Icons.dashboard,
                  ),
                if (capabilities.hasStudent)
                  SidebarTarget(
                    route: '/calendar/plan',
                    activeRoute: '/calendar/',
                    icon: Icons.calendar_month_rounded,
                  ),
                if (capabilities.hasStudent)
                  SidebarTarget(
                    route: '/course-overview/',
                    icon: Icons.school,
                  ),
                SidebarTarget(
                  route: '/slots/book',
                  activeRoute: '/slots/',
                  icon: Icons.timelapse,
                ),
              ].vSpaced(Spacing.smallSpacing),
            ),
            Column(
              children: [
                const SidebarTarget(
                  route: '/settings/',
                  icon: Icons.settings,
                ),
                SidebarTarget(
                  route: '/auth/',
                  icon: Icons.logout,
                  onTap: Modular.get<AuthRepository>().logout,
                ),
              ].vSpaced(Spacing.smallSpacing),
            ),
          ],
        ),
      ),
    );
  }
}
