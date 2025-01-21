import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/src/app/app.dart';

/// A screen that wraps its children in a [Sidebar].
class SidebarScreen extends StatelessWidget {
  /// A screen that wraps its children in a [Sidebar].
  const SidebarScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
