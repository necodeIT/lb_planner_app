import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/calendar/calendar.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/notifications/notifications.dart';
import 'package:lb_planner/src/theming/theming.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Renders a given [notification].
class NotificationWidget extends StatefulWidget {
  /// Renders a given [notification].
  const NotificationWidget({super.key, required this.notification});

  /// The notification to render.
  final Notification notification;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  bool handlingCallback = false;

  Future<void> handleCallback(FutureOr<void> Function() callback) async {
    if (handlingCallback) return;

    setState(() {
      handlingCallback = true;
    });

    await callback();

    await toggleRead(read: true);

    if (mounted) {
      setState(() {
        handlingCallback = false;
      });
    }
  }

  FutureOr<void> toggleRead({bool? read}) async {
    read ??= !widget.notification.read;

    final repo = context.read<NotificationsRepository>();

    if (read && !widget.notification.read) await repo.markAsRead(widget.notification);
    if (!read && widget.notification.read) await repo.unread(widget.notification);
  }

  Future<List<(String, FutureOr<void> Function()?)>> getActions() async {
    return await widget.notification.type.actions(context, widget.notification);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingAll(Spacing.mediumSpacing),
      decoration: ShapeDecoration(
        shape: squircle(),
        color: context.theme.scaffoldBackgroundColor,
      ),
      child: Column(
        children: [
          widget.notification.type.message(context, widget.notification).alignAtCenterLeft(),
          Spacing.smallVertical(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesome5Regular.clock,
                    size: context.bodySmall?.fontSize,
                    color: context.theme.disabledColor,
                  ),
                  Spacing.xsHorizontal(),
                  Text(
                    timeago.format(widget.notification.timestamp),
                    style: context.bodySmall?.copyWith(
                      color: context.theme.disabledColor,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              FutureBuilder(
                future: getActions(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || handlingCallback) {
                    return const SizedBox.shrink();
                  }

                  return Row(
                    children: [
                      for (final (title, callback) in snapshot.requireData)
                        if (callback != null)
                          TextButton(
                            onPressed: callback,
                            child: Text(title),
                          )
                        else
                          Text(
                            title,
                            textAlign: TextAlign.start,
                          ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onPressed: toggleRead,
                        icon: Icon(
                          widget.notification.read ? FontAwesome5Regular.eye_slash : FontAwesome5Regular.eye,
                          size: context.bodySmall?.fontSize,
                          color: context.theme.colorScheme.primary,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Message builder for [NotificationType.invite].
Widget inviteMessage(BuildContext context, Notification notification) {
  final invites = context.watch<InvitesRepository>().filter(id: notification.context);
  final users = context.watch<UsersRepository>();

  final invite = invites.firstOrNull;

  final userName = invite != null
      ? users.state.data
          ?.filter(
            ids: [
              invite.inviterId,
            ],
          )
          .firstOrNull
          ?.fullname
      : null;

  return Skeletonizer(
    enabled: userName == null || notification.context == null,
    child: Text(
      '${userName ?? 'Loading'} invited you to join their plan!',
    ),
  );
}

/// Actions builder for [NotificationType.invite].
FutureOr<List<(String, FutureOr<void> Function()?)>> inviteActions(BuildContext context, Notification notification) async {
  final invites = context.watch<InvitesRepository>();

  final invite = invites.filter(id: notification.context).firstOrNull;

  if (invite == null) return [];

  if (invite.status != PlanInviteStatus.pending) {
    return [
      (
        invite.status == PlanInviteStatus.accepted ? 'Accepted' : 'Declined',
        null,
      ),
    ];
  }

  return [
    (
      'Accept',
      () async => invites.acceptInvite(notification.context!),
    ),
    (
      'Decline',
      () async => invites.declineInvite(notification.context!),
    ),
  ];
}

/// Actions builder for types that have no actions.
FutureOr<List<(String, FutureOr<void> Function())>> noActions(BuildContext context, Notification notification) {
  return [];
}

/// Message builder for [NotificationType.inviteAccepted].
Widget inviteAcceptedMessage(BuildContext context, Notification notification) {
  final invites = context.watch<InvitesRepository>();
  final users = context.watch<UsersRepository>();

  final invite = invites.filter(id: notification.context).firstOrNull;

  final userName = invite != null
      ? users.state.data
          ?.filter(
            ids: [
              invite.invitedUserId,
            ],
          )
          .firstOrNull
          ?.fullname
      : null;

  return Skeletonizer(
    enabled: userName == null || notification.context == null,
    child: Text(
      '$userName accepted your invitation!',
    ),
  );
}

/// Message builder for [NotificationType.inviteDeclined].
Widget inviteDeclinedMessage(BuildContext context, Notification notification) {
  final invites = context.watch<InvitesRepository>();
  final users = context.watch<UsersRepository>();

  final invite = invites.filter(id: notification.context).firstOrNull;

  final userName = invite != null
      ? users.state.data
          ?.filter(
            ids: [
              invite.invitedUserId,
            ],
          )
          .firstOrNull
          ?.fullname
      : null;

  return Skeletonizer(
    enabled: userName == null || notification.context == null,
    child: Text(
      '$userName declined your invitation!',
    ),
  );
}

/// Message builder for [NotificationType.planLeft].
Widget planLeftMessage(BuildContext context, Notification notification) {
  final users = context.watch<UsersRepository>();

  final userName = users.state.data?.filter(ids: [notification.context!]).firstOrNull?.fullname;

  return Skeletonizer(
    enabled: userName == null || notification.context == null,
    child: Text(
      '$userName left your plan! No hard feelings. You can re-invite them any time',
    ),
  );
}

/// Message builder for [NotificationType.planRemoved].
Widget planRemovedMessage(BuildContext context, Notification notification) {
  return const Text(
    "You have been removed from your shared plan. But don't worry, we've got you covered - a copy of the plan has been saved to your account.",
  );
}

/// Message builder for [NotificationType.newUser].
Widget newUserMessage(BuildContext context, Notification notification) {
  final user = context.watch<UserRepository>();

  return Skeletonizer(
    enabled: !user.state.hasData,
    child: Text(
      'Welcome to $kAppName, ${user.state.data?.firstname ?? 'Loading'}! We hope you enjoy your stay.',
    ),
  );
}
