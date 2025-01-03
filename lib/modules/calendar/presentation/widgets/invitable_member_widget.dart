import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_utils/flutter_utils.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/theming/theming.dart';

/// Renders a user that can be invited to a plan.
class InvitableMemberWidget extends StatefulWidget {
  /// Renders a user that can be invited to a plan.
  const InvitableMemberWidget({super.key, required this.user});

  /// The user to render.
  final User user;

  @override
  State<InvitableMemberWidget> createState() => _InvitableMemberWidgetState();
}

class _InvitableMemberWidgetState extends State<InvitableMemberWidget> {
  Future<void> inviteUser() async {
    final plan = context.read<CalendarPlanRepository>();
    await plan.inviteUser(widget.user.id);
  }

  @override
  Widget build(BuildContext context) {
    final plan = context.watch<CalendarPlanRepository>().state;

    final isMember = plan.when(
      data: (plan) => plan.members.any((m) => m.id == widget.user.id),
      loading: () => false,
      error: (e, _) => false,
    );

    return Container(
      padding: PaddingAll(Spacing.smallSpacing),
      decoration: ShapeDecoration(
        shape: squircle(),
        color: context.theme.scaffoldBackgroundColor,
      ),
      child: Row(
        children: [
          UserProfileImage(
            userId: widget.user.id,
          ),
          Spacing.smallHorizontal(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.user.fullname,
              ),
              if (widget.user.vintage != null) Spacing.xsVertical(),
              if (widget.user.vintage != null)
                Text(
                  widget.user.vintage!.humanReadable,
                  style: context.theme.textTheme.bodySmall,
                ),
            ],
          ).expanded(),
          const Spacer(),
          if (!isMember)
            TextButton(
              onPressed: inviteUser,
              child: const Text('Invite'),
            ),
          if (isMember)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  FontAwesome5Solid.check_circle,
                  color: context.theme.taskStatusTheme.doneColor,
                  size: 16,
                ),
                Spacing.xsHorizontal(),
                Text(
                  'In your plan',
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: context.theme.taskStatusTheme.doneColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
