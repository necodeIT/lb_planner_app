import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/calendar/calendar.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// Members tab in the plan popup
class PlanPopupMembers extends StatefulWidget {
  /// Members tab in the plan popup
  const PlanPopupMembers({super.key});

  @override
  State<PlanPopupMembers> createState() => _PlanPopupMembersState();
}

class _PlanPopupMembersState extends State<PlanPopupMembers> {
  final searchController = TextEditingController();

  void showInviteMemberDialog() {
    showAnimatedDialog(
      context: context,
      pageBuilder: (_, __, ___) => const PlanInviteMemberDialog(),
    );
  }

  Future<void> leavePlan() async {
    final plan = context.read<CalendarPlanRepository>();
    final confirmed = await showConfirmationDialog(context, title: context.t.calendar_leave_title, message: context.t.calendar_leave_message);

    if (!confirmed) return;

    await plan.leavePlan();
  }

  @override
  void initState() {
    searchController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final plan = context.watch<CalendarPlanRepository>();
    final users = context.watch<UsersRepository>().state;

    if (!plan.state.hasData || !users.hasData) {
      return const Center(child: CircularProgressIndicator());
    }

    final filteredMembers = users.requireData
        .filter(
          query: searchController.text,
          ids: plan.state.requireData.members.map((m) => m.id).toList(),
        )
        .map((u) => plan.state.requireData.members.firstWhere((m) => m.id == u.id))
        .toList()
      ..sort();

    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            filled: true,
            hintText: context.t.calendar_searchMembers,
            prefixIcon: const Icon(Icons.search),
            fillColor: context.theme.scaffoldBackgroundColor,
            isDense: true,
            contentPadding: PaddingAll(Spacing.xsSpacing),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ).stretch(),
        Spacing.smallVertical(),
        ListView(
          children: [
            ...filteredMembers.map((m) => PlanMemberWidget(member: m)).toList().vSpaced(Spacing.xsSpacing),
            Spacing.smallVertical(),
            if (plan.accessType == PlanMemberAccessType.owner)
              ElevatedButton(
                onPressed: showInviteMemberDialog,
                child: Row(
                  children: [
                    Text(context.t.calendar_inviteUsers),
                    const Spacer(),
                    const Icon(
                      FontAwesome5Solid.user_plus,
                      size: 15,
                    ),
                  ],
                ),
              )
            else
              ElevatedButton(
                onPressed: leavePlan,
                child: Row(
                  children: [
                    Text(context.t.calendar_leave),
                    const Spacer(),
                    const Icon(
                      FontAwesome5Solid.user_minus,
                      size: 15,
                    ),
                  ],
                ),
              ),
          ],
        ).expanded(),
      ],
    );
  }
}
