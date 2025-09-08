import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/config/posthog.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:eduplanner/src/settings/presentation/widgets/generic_settings.dart';
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

  Future<void> logout() async {
    final auth = context.read<AuthRepository>();

    await auth.logout();

    Modular.to.navigate('/auth/');
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();

    final isStudent = user.state.data?.capabilities.hasStudent ?? false;
    return GenericSettings(
      title: context.t.settings_general,
      items: [
        IconSettingsItem(
          name: context.t.settings_general_version(kInstalledRelease.toString()),
          icon: Icons.info_outline_rounded,
          hoverColor: context.theme.colorScheme.onSurface,
          // icon: Icons.update,
          // onPressed: checkUpdates,
        ),
        IconSettingsItem(
          name: context.t.auth_privacyPolicy,
          icon: FontAwesome5Solid.balance_scale,
          onPressed: () => launchUrl(kPrivacyPolicyUrl),
          iconSize: 14,
        ),

        // Delete profile could be re-added as a destructive action item when needed
        if (isStudent)
          BooleanSettingsItem(
            name: context.t.settings_general_enableEK,
            value: user.state.data?.optionalTasksEnabled ?? false,
            onChanged: user.enableOptionalTasks,
          ),
        if (isStudent)
          BooleanSettingsItem(
            name: context.t.settings_general_displayTaskCount,
            value: user.state.data?.displayTaskCount ?? false,
            onChanged: user.setDisplayTaskCount,
          ),

        // Manage subscription could be added as another IconSettingsItem

        if (context.isMobile)
          IconSettingsItem(
            name: context.t.settings_logout,
            icon: Icons.logout,
            onPressed: logout,
          ),
      ],
    );
  }
}
