import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';

/// A target in the [Sidebar] that navigates to a specific [route].
class SidebarTarget extends StatefulWidget {
  /// The route to navigate to when the target is clicked.
  /// Also used to determine if the target is active.
  ///
  /// The route must be the full path from the root of the app in order for subroutes to also be considered active.
  final String route;

  /// The icon to display on the target.
  final IconData icon;

  /// Optional callback to run when the target is clicked.
  final VoidCallback? onTap;

  /// A target in the [Sidebar] that navigates to a specific [route].
  const SidebarTarget({super.key, required this.route, required this.icon, this.onTap});

  @override
  State<SidebarTarget> createState() => _SidebarTargetState();
}

class _SidebarTargetState extends State<SidebarTarget> {
  void _onTap() {
    if (Modular.to.isActive(widget.route)) return;

    widget.onTap?.call();
    Modular.to.navigate(widget.route);

    setState(() {
      isActive = true;
    });
  }

  void _onNavigate() {
    setState(() {
      isActive = Modular.to.isActive(widget.route);
    });
  }

  bool isActive = false;

  @override
  void initState() {
    super.initState();

    Modular.to.addListener(_onNavigate);

    isActive = Modular.to.isActive(widget.route);
  }

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      onTap: _onTap,
      builder: (context, hover) {
        return AnimatedContainer(
          width: 35,
          height: 35,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 100),
          decoration: ShapeDecoration(
            color: isActive ? context.theme.colorScheme.primary : context.theme.scaffoldBackgroundColor,
            shadows: kElevationToShadow[isActive || hover ? 3 : 0],
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius(
                cornerRadius: 10,
                cornerSmoothing: 0.5,
              ),
            ),
          ),
          child: Icon(
            widget.icon,
            color: isActive ? context.theme.colorScheme.onPrimary : context.theme.colorScheme.onSurface,
            size: 20,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    Modular.to.removeListener(_onNavigate);
  }
}
