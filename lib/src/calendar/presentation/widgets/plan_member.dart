import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Renders a single [member] of a plan.
class PlanMemberWidget extends StatefulWidget {
  /// Renders a single [member] of a plan.
  const PlanMemberWidget({super.key, required this.member});

  /// The member to render.
  final PlanMember member;

  @override
  State<PlanMemberWidget> createState() => _PlanMemberWidgetState();
}

class _PlanMemberWidgetState extends State<PlanMemberWidget> {
  bool changingAccess = false;
  bool removing = false;

  Future<void> removeMember() async {
    if (removing) return;

    setState(() {
      removing = true;
    });

    final plan = context.read<CalendarPlanRepository>();
    await plan.kick(widget.member.id);

    if (mounted) {
      setState(() {
        removing = false;
      });
    }
  }

  Future<void> incrementAccess() async {
    if (changingAccess) return;

    setState(() {
      changingAccess = true;
    });

    final plan = context.read<CalendarPlanRepository>();

    final nextAccess = switch (widget.member.accessType) {
      PlanMemberAccessType.owner => PlanMemberAccessType.owner,
      PlanMemberAccessType.write => PlanMemberAccessType.read,
      PlanMemberAccessType.read => PlanMemberAccessType.write,
    };

    if (nextAccess == PlanMemberAccessType.owner) {
      return;
    }

    await plan.chmod(widget.member.id, nextAccess);

    if (mounted) {
      setState(() {
        changingAccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UsersRepository>().state.data?.filter(ids: [widget.member.id]).firstOrNull;
    final currentUser = context.watch<UserRepository>().state;
    final plan = context.watch<CalendarPlanRepository>();

    if (user == null || !currentUser.hasData) {
      return const SizedBox();
    }
    final isOwner = plan.accessType == PlanMemberAccessType.owner;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          UserProfileImage(
            userId: user.id,
          ),
          Spacing.xsHorizontal(),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.fullname,
              ),
              if (user.vintage != null) Spacing.xsVertical(),
              if (user.vintage != null)
                Text(
                  user.vintage!.humanReadable,
                  style: context.theme.textTheme.bodySmall,
                ),
            ],
          ).expanded(),
          Spacing.xsHorizontal(),
          if (!changingAccess && !removing)
            ConditionalWrapper(
              condition: isOwner && widget.member.accessType != PlanMemberAccessType.owner,
              wrapper: (context, child) => ScaleOnHover(
                duration: const Duration(milliseconds: 100),
                scale: 1.1,
                onTap: incrementAccess,
                child: child,
              ),
              child: Icon(
                switch (widget.member.accessType) {
                  PlanMemberAccessType.owner => FontAwesomeIcons.crown,
                  PlanMemberAccessType.write => FontAwesomeIcons.pen,
                  PlanMemberAccessType.read => FontAwesomeIcons.eye,
                },
                color: context.theme.colorScheme.primary,
                size: context.bodyMedium?.fontSize,
              ),
            ),
          if (!changingAccess && !removing && isOwner && widget.member.accessType != PlanMemberAccessType.owner) Spacing.xsHorizontal(),
          if (!changingAccess && !removing && isOwner && widget.member.accessType != PlanMemberAccessType.owner)
            IconButton(
              icon: Icon(
                Icons.close,
                size: context.bodyMedium?.fontSize,
              ),
              onPressed: removeMember,
            ),
          if (removing || changingAccess)
            SizedBox(
              width: context.bodyMedium?.fontSize,
              height: context.bodyMedium?.fontSize,
              child: const CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
