import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Navigation sidebar for the application.
class Sidebar extends StatelessWidget with AdaptiveWidget {
  /// Navigation sidebar for the application.
  const Sidebar({super.key});

  @override
  Widget buildDesktop(BuildContext context) {
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
                  const SidebarTarget(
                    route: '/dashboard/',
                    icon: Icons.dashboard,
                  ),
                if (capabilities.hasStudent)
                  SidebarTarget(
                    route: '/kanban/',
                    icon: Icons.bar_chart_rounded,
                    iconTransformer: (context, icon) => Transform.flip(
                      flipY: true,
                      child: icon,
                    ),
                  ),
                if (capabilities.hasStudent)
                  const SidebarTarget(
                    route: '/calendar/plan/',
                    activeRoute: '/calendar/',
                    icon: Icons.calendar_month_rounded,
                  ),
                if (capabilities.hasStudent)
                  const SidebarTarget(
                    route: '/course-overview/',
                    icon: Icons.school,
                  ),
                const SidebarTarget(
                  route: '/slots/book/',
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

  @override
  Widget buildMobile(BuildContext context) {
    final capabilities = context.watch<UserRepository>().state.data?.capabilities ?? {};

    return Container(
      height: 60,
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
        padding: PaddingHorizontal(Spacing.mediumSpacing).Vertical(Spacing.xsSpacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Spacing.xlSpacing,
          children: [
            if (capabilities.hasStudent)
              const SidebarTarget(
                route: '/dashboard/',
                icon: Icons.dashboard,
              ),
            // if (capabilities.hasStudent)
            //   const SidebarTarget(
            //     route: '/calendar/plan/',
            //     activeRoute: '/calendar/',
            //     icon: Icons.calendar_month_rounded,
            //   ),
            // if (capabilities.hasStudent)
            //   const SidebarTarget(
            //     route: '/course-overview/',
            //     icon: Icons.school,
            //   ),

            const SidebarTarget(
              route: '/slots/book/',
              activeRoute: '/slots/',
              icon: Icons.timelapse,
            ),
            const SidebarTarget(
              route: '/settings/',
              icon: Icons.settings,
            ),
          ].hSpaced(Spacing.smallSpacing),
        ),
      ),
    );
  }
}
