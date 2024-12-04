import 'package:flutter/material.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/settings/settings.dart';

/// Renders the settings screen.
class SettingsScreen extends StatelessWidget {
  /// Renders the settings screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stagger = AnimationStagger(const Duration(milliseconds: 50));

    return Padding(
      padding: PaddingAll(),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: const GeneralSettings().stretch(),
                      ).show(stagger),
                      Expanded(
                        child: const ThemesSettings().stretch(),
                      ).show(stagger),
                    ].hSpaced(Spacing.mediumSpacing),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: const CourseSelector().stretch(),
                ).show(stagger),
              ].vSpaced(Spacing.mediumSpacing),
            ),
          ),
          Expanded(
            flex: 2,
            child: const Card(
              child: SizedBox.expand(),
            ).stretch(),
          ).show(stagger),
        ].hSpaced(Spacing.mediumSpacing),
      ),
    );
  }
}
