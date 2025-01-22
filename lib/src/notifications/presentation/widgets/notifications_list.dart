import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/notifications/notifications.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// Displays all notifications of the user.
class NotificationsList extends StatefulWidget {
  /// Displays all notifications of the user.
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  bool showAll = false;

  @override
  Widget build(BuildContext context) {
    final notificationsRepo = context.watch<NotificationsRepository>();

    final notifications = notificationsRepo.filter(read: showAll ? null : false)..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Container(
      padding: PaddingAll(Spacing.smallSpacing),
      decoration: ShapeDecoration(
        shape: squircle(),
        color: context.theme.cardColor,
        shadows: kElevationToShadow[16],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifications (${notifications.length})',
                style: context.theme.textTheme.titleMedium?.bold,
                textAlign: TextAlign.start,
              ),
              TextButton(
                onPressed: () => setState(() => showAll = !showAll),
                child: Text(
                  showAll ? 'Show unread' : 'Show all',
                ),
              ),
            ],
          ).stretch(),
          Spacing.mediumVertical(),
          ListView(
            children: notifications
                .map(
                  (notification) => NotificationWidget(
                    notification: notification,
                    key: ValueKey(notification),
                  ),
                )
                .toList()
                .vSpaced(Spacing.xsSpacing)
                .show(),
          ).expanded(),
        ],
      ),
    );
  }
}
