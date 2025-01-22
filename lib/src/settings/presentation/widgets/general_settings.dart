import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/auth/auth.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// Displays the general settings of the app.
class GeneralSettings extends StatefulWidget {
  /// Displays the general settings of the app.
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> {
  bool checkingUpdates = false;
  bool clearingCache = false;
  bool deletingProfile = false;

  Future<void> checkUpdates() async {
    if (checkingUpdates) {
      return;
    }

    checkingUpdates = true;

    //checkUpdates

    checkingUpdates = false;
  }

  Future<void> clearCache() async {
    if (clearingCache) {
      return;
    }

    clearingCache = true;

    //clearCache

    clearingCache = false;
  }

  Future<void> deleteProfile() async {
    if (deletingProfile) {
      return;
    }

    final user = context.read<UserRepository>();

    deletingProfile = true;

    await user.deleteUser();

    deletingProfile = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();

    final isStudent = user.state.data?.capabilities.hasStudent ?? false;

    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.settings_general,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Expanded(
              child: ListView(
                children: [
                  iconItem(
                    title: 'Version $kInstalledRelease',
                    icon: Icons.update,
                    onPressed: checkUpdates,
                  ),
                  // item(context.t.settings_general_deleteProfile, Icons.delete, deleteProfile, context.theme.colorScheme.error),
                  if (isStudent)
                    checkboxItem(
                      title: 'Enable EK modules',
                      value: user.state.data?.optionalTasksEnabled ?? false,
                      onChanged: user.enableOptionalTasks,
                    ),
                  if (isStudent)
                    checkboxItem(
                      title: 'Display task count',
                      value: user.state.data?.displayTaskCount ?? false,
                      onChanged: user.setDisplayTaskCount,
                    ),
                ].vSpaced(Spacing.smallSpacing),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconItem({required String title, required IconData icon, VoidCallback? onPressed, Color? hoverColor}) {
    return item(
      title: title,
      suffix: HoverBuilder(
        onTap: onPressed,
        builder: (context, hovering) {
          return Container(
            padding: PaddingAll(Spacing.xsSpacing),
            decoration: ShapeDecoration(
              shape: squircle(),
              color: context.theme.scaffoldBackgroundColor,
            ),
            child: Icon(
              icon,
              color: hovering ? hoverColor ?? context.theme.colorScheme.primary : context.theme.colorScheme.onSurface,
            ),
          );
        },
      ),
      onPressed: onPressed,
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Widget checkboxItem({required String title, required bool value, required Function(bool?) onChanged}) {
    return item(
      title: title,
      suffix: Checkbox(
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  // ignore: avoid_positional_boolean_parameters
  Widget item({required String title, required Widget suffix, VoidCallback? onPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title).expanded(),
        Spacing.xs(),
        suffix,
      ],
    );
  }
}
