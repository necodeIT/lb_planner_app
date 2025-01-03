import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/calendar/calendar.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';

/// Dialog to invite a user to the current user's plan.
class PlanInviteMemberDialog extends StatefulWidget {
  /// Dialog to invite a user to the current user's plan.
  const PlanInviteMemberDialog({super.key});

  @override
  State<PlanInviteMemberDialog> createState() => _PlanInviteMemberDialogState();
}

class _PlanInviteMemberDialogState extends State<PlanInviteMemberDialog> {
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<UserRepository>().state;

    final users = context.watch<UsersRepository>().state;

    return GenericDialog(
      title: 'Invite users',
      actions: const [
        SecondaryDialogAction(
          onPressed: Navigator.pop,
          label: 'Close',
        ),
      ],
      shrinkWrap: false,
      content: users.when(
        data: (users) => Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                hintText: 'Search users',
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
            Spacing.mediumVertical(),
            ListView(
              children: users
                  .where((user) => user.id != currentUser.data?.id)
                  .toList()
                  .filter(query: searchController.text)
                  .map(
                    (user) => InvitableMemberWidget(
                      user: user,
                      key: ValueKey('invite_user_${user.id}'),
                    ),
                  )
                  .toList()
                  .vSpaced(Spacing.smallSpacing),
            ).expanded(),
          ],
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (_, __) => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
