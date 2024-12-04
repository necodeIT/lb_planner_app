import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';

/// A screen that wraps its children in a [Sidebar].
class SidebarScreen extends StatelessWidget {
  /// A screen that wraps its children in a [Sidebar].
  const SidebarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const Sidebar(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: PaddingAll(Spacing.mediumSpacing).Bottom(0),
                  child: const TitleBar(),
                ),
                const Expanded(
                  child: RouterOutlet(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
