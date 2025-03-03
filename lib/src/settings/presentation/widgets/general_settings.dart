import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/config/posthog.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

/// Displays the general settings of the app.
class GeneralSettings extends StatefulWidget {
  /// Displays the general settings of the app.
  const GeneralSettings({super.key});

  @override
  State<GeneralSettings> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettings> with AdaptiveState {
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
  Widget buildDesktop(BuildContext context) {
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
                    title: context.t.settings_general_version(kInstalledRelease.toString()),
                    icon: Icons.update,
                    onPressed: checkUpdates,
                  ),

                  // item(context.t.settings_general_deleteProfile, Icons.delete, deleteProfile, context.theme.colorScheme.error),
                  if (isStudent)
                    checkboxItem(
                      title: context.t.settings_general_enableEK,
                      value: user.state.data?.optionalTasksEnabled ?? false,
                      onChanged: user.enableOptionalTasks,
                    ),
                  if (isStudent)
                    checkboxItem(
                      title: context.t.settings_general_displayTaskCount,
                      value: user.state.data?.displayTaskCount ?? false,
                      onChanged: user.setDisplayTaskCount,
                    ),
                  iconItem(
                    title: context.t.auth_privacyPolicy,
                    icon: FontAwesome5Solid.balance_scale,
                    onPressed: () => launchUrl(kPrivacyPolicyUrl),
                    iconSize: 14,
                  ),
                  iconItem(
                    title: context.t.settings_general_manageSubscription,
                    icon: FontAwesome5Solid.credit_card,
                    onPressed: () => Modular.to.pushNamed('/subscription'), // TODO(mcquenji): Implement subscription screen
                    iconSize: 14,
                  ),
                ].vSpaced(Spacing.smallSpacing),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    final user = context.watch<UserRepository>();

    final isStudent = user.state.data?.capabilities.hasStudent ?? false;

    // TODO(MasterMarcoHD): expand interactable area of item
    return Column(
      children: [
        Text(
          context.t.settings_general,
          style: context.textTheme.titleMedium?.bold,
        ).alignAtTopLeft(),
        Column(
          children: [
            iconItem(
              title: context.t.settings_general_version(kInstalledRelease.toString()),
              icon: Icons.update,
              onPressed: checkUpdates,
            ),

            // item(context.t.settings_general_deleteProfile, Icons.delete, deleteProfile, context.theme.colorScheme.error),
            if (isStudent)
              checkboxItem(
                title: context.t.settings_general_enableEK,
                value: user.state.data?.optionalTasksEnabled ?? false,
                onChanged: user.enableOptionalTasks,
              ),
            if (isStudent)
              checkboxItem(
                title: context.t.settings_general_displayTaskCount,
                value: user.state.data?.displayTaskCount ?? false,
                onChanged: user.setDisplayTaskCount,
              ),
            iconItem(
              title: context.t.auth_privacyPolicy,
              icon: FontAwesome5Solid.balance_scale,
              onPressed: () => launchUrl(kPrivacyPolicyUrl),
              iconSize: 14,
            ),
            iconItem(
              title: context.t.settings_general_manageSubscription,
              icon: FontAwesome5Solid.credit_card,
              onPressed: () => Modular.to.pushNamed('/subscription'), // TODO(mcquenji): Implement subscription screen
              iconSize: 14,
            ),
          ].vSpaced(Spacing.smallSpacing),
        ),
      ],
    );
  }

  Widget iconItem({required String title, required IconData icon, VoidCallback? onPressed, Color? hoverColor, double? iconSize = 20}) {
    return item(
      title: title,
      suffix: HoverBuilder(
        onTap: onPressed,
        builder: (context, hovering) {
          return Container(
            height: 35,
            width: 35,
            decoration: ShapeDecoration(
              shape: squircle(),
              color: context.theme.scaffoldBackgroundColor,
            ),
            child: Icon(
              icon,
              color: hovering ? hoverColor ?? context.theme.colorScheme.primary : context.theme.colorScheme.onSurface,
              size: iconSize,
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
    return SizedBox(
      height: 35,
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title).expanded(),
            Spacing.xs(),
            suffix,
          ],
        ),
      ),
    );
  }
}
