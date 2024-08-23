import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// Displays the general settings of the app.
class GeneralSettings extends StatelessWidget {
  /// Displays the general settings of the app.
  const GeneralSettings({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: ListView(),
            ),
          ],
        ),
      ),
    );
  }
}
