import 'dart:async';

import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart' hide Notification;
import 'package:lb_planner/modules/notifications/notifications.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({super.key, required this.notification});

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

    if (mounted) {
      setState(() {
        handlingCallback = false;
      });
    }
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
          widget.notification.type.message(context, widget.notification),
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
                      TextButton(
                        onPressed: () {
                          handleCallback(() async {
                            widget.notification.read
                                ? await context.read<NotificationsRepository>().unread(widget.notification)
                                : await context.read<NotificationsRepository>().markAsRead(widget.notification);
                          });
                        },
                        child: Icon(
                          widget.notification.read ? FontAwesome5Regular.eye_slash : FontAwesome5Regular.eye,
                          size: context.bodySmall?.fontSize,
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
  final plan = context.watch<CalendarPlanRepository>();
  final users = context.watch<UsersRepository>();

  return FutureBuilder(
    future: plan.getInvites(inviteeId: notification.context),
    builder: (context, snapshot) {
      final invite = snapshot.data?.firstOrNull;
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
    },
  );
}

/// Actions builder for [NotificationType.invite].
FutureOr<List<(String, FutureOr<void> Function()?)>> inviteActions(BuildContext context, Notification notification) async {
  final plan = context.watch<CalendarPlanRepository>();

  final invite = await plan.getInvites(inviteeId: notification.context).then((value) => value.firstOrNull);

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
      () async => plan.acceptInvite(notification.context!),
    ),
    (
      'Decline',
      () async => plan.declineInvite(notification.context!),
    ),
  ];
}

/// Actions builder for types that have no actions.
FutureOr<List<(String, FutureOr<void> Function())>> noActions(BuildContext context, Notification notification) {
  return [];
}

/// Message builder for [NotificationType.inviteAccepted].
Widget inviteAcceptedMessage(BuildContext context, Notification notification) {
  final plan = context.watch<CalendarPlanRepository>();
  final users = context.watch<UsersRepository>();

  return FutureBuilder(
    future: plan.getInvites(id: notification.context),
    builder: (context, snapshot) {
      final invite = snapshot.data?.firstOrNull;
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
    },
  );
}

/// Message builder for [NotificationType.inviteDeclined].
Widget inviteDeclinedMessage(BuildContext context, Notification notification) {
  final plan = context.watch<CalendarPlanRepository>();
  final users = context.watch<UsersRepository>();

  return FutureBuilder(
    future: plan.getInvites(id: notification.context),
    builder: (context, snapshot) {
      final invite = snapshot.data?.firstOrNull;
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
    },
  );
}

/// Message builder for [NotificationType.planLeft].
Widget planLeftMessage(BuildContext context, Notification notification) {
  final plan = context.watch<CalendarPlanRepository>();
  final users = context.watch<UsersRepository>();

  return FutureBuilder(
    future: plan.getInvites(id: notification.context),
    builder: (context, snapshot) {
      final invite = snapshot.data?.firstOrNull;
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
          '$userName left your plan!',
        ),
      );
    },
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
