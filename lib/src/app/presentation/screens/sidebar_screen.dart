import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:lb_planner/src/app/app.dart';

/// A screen that wraps its children in a [Sidebar].
class SidebarScreen extends StatefulWidget {
  /// A screen that wraps its children in a [Sidebar].
  const SidebarScreen({super.key});

  @override
  State<SidebarScreen> createState() => _SidebarScreenState();
}

class _SidebarScreenState extends State<SidebarScreen> {
  bool showedDisclaimer = false;

  void showDisclaimerDialog() {
    showMarkdownDialog(
      context,
      title: context.t.global_disclaimer_title,
      markdown: context.t.global_disclaimer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = Localizations.localeOf(context);
    Intl.defaultLocale = currentLocale.languageCode;
    DesktopGuard.listen(context);

    if (!showedDisclaimer && !kDebugMode) {
      showedDisclaimer = true;

      runAfterBuild(showDisclaimerDialog);
    }
    return const Scaffold(
      body: Row(
        children: [
          Sidebar(),
          Expanded(
            child: TitleBar(
              child: RouterOutlet(),
            ),
          ),
        ],
      ),
    );
  }
}
