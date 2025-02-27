import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Renders the settings screen.
class SettingsScreen extends StatelessWidget with AdaptiveWidget {
  /// Renders the settings screen.
  const SettingsScreen({super.key});

  @override
  Widget buildDesktop(BuildContext context) {
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

  @override
  Widget buildMobile(BuildContext context) {
    // TODO(MasterMarcoHD): implement buildMobile
    throw UnimplementedError();
  }
}
