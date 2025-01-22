import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';
import 'package:lb_planner/src/moodle/moodle.dart';
import 'package:lb_planner/src/settings/settings.dart';

/// Renders the settings screen.
class SettingsScreen extends StatelessWidget {
  /// Renders the settings screen.
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stagger = AnimationStagger(const Duration(milliseconds: 50));
    final capabilities = context.watch<UserRepository>().state.data?.capabilities ?? {};

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
                if (capabilities.hasStudent)
                  Expanded(
                    flex: 2,
                    child: const CourseSelector().stretch(),
                  ).show(stagger),
              ].vSpaced(Spacing.mediumSpacing),
            ),
          ),
          const Expanded(
            flex: 2,
            child: FeedbackWidget(),
          ).show(stagger),
        ].hSpaced(Spacing.mediumSpacing),
      ),
    );
  }
}
