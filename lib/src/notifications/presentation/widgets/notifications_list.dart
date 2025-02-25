import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/notifications/notifications.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Displays all notifications of the user.
class NotificationsList extends StatefulWidget {
  /// Displays all notifications of the user.
  const NotificationsList({super.key});

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> with AdaptiveState {
  bool showAll = false;

  @override
  Widget buildDesktop(BuildContext context) {
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
                context.t.notification_list_title(notifications.length),
                style: context.theme.textTheme.titleMedium?.bold,
                textAlign: TextAlign.start,
              ),
              TextButton(
                onPressed: () => setState(() => showAll = !showAll),
                child: Text(
                  showAll ? context.t.notification_list_showUnread : context.t.notification_list_showAll,
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

  @override
  Widget buildMobile(BuildContext context) {
    final notificationsRepo = context.watch<NotificationsRepository>();

    final notifications = notificationsRepo.filter(read: showAll ? null : false)..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Dialog.fullscreen(
      child: Container(
        padding: PaddingAll(Spacing.smallSpacing),
        decoration: ShapeDecoration(
          shape: squircle(),
          color: context.theme.cardColor,
          shadows: kElevationToShadow[16],
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.t.notification_list_title(notifications.length),
                    style: context.theme.textTheme.titleMedium?.bold,
                    textAlign: TextAlign.start,
                  ),
                  TextButton(
                    onPressed: () => setState(() => showAll = !showAll),
                    child: Text(
                      showAll ? context.t.notification_list_showUnread : context.t.notification_list_showAll,
                    ),
                  ),
                ],
              ).stretch(),
              Spacing.mediumVertical(),
              SingleChildScrollView(
                child: Column(
                  children: notifications
                      .map(
                        (notification) => NotificationWidget(
                          notification: notification,
                          key: ValueKey(notification),
                        ),
                      )
                      .toList()
                      .vSpaced(Spacing.xsSpacing)
                      .show(limit: 8),
                ),
              ).expanded(),
              ElevatedButton(
                onPressed: Navigator.of(context).pop,
                child: Text(context.t.global_close),
              ).stretch(),
            ],
          ),
        ),
      ),
    );
  }
}
