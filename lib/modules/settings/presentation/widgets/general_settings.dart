import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';

/// Displays the general settings of the app.
class GeneralSettings extends StatelessWidget {
  /// Displays the general settings of the app.
  const GeneralSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();

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

      deletingProfile = true;

      await user.deleteUser();

      deletingProfile = false;
    }

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Software Version'),
                      IconButton(
                        onPressed: checkUpdates,
                        icon: const Icon(Icons.update),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.t.settings_general_clearCache),
                      IconButton(
                        onPressed: clearCache,
                        icon: const Icon(Icons.chevron_right),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.t.settings_general_deleteProfile),
                      IconButton(
                        onPressed: deleteProfile,
                        icon: const Icon(Icons.delete),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.t.settings_general_credits),
                      IconButton(
                        onPressed: null,
                        icon: const Icon(Icons.info_outline),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
