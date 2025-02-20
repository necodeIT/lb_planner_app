import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

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

  /// Set this value if the target should be considered active when the route is not the same as the [route].
  final String? activeRoute;

  /// A target in the [Sidebar] that navigates to a specific [route].
  const SidebarTarget({super.key, required this.route, required this.icon, this.onTap, this.activeRoute});

  @override
  State<SidebarTarget> createState() => _SidebarTargetState();
}

class _SidebarTargetState extends State<SidebarTarget> {
  String get route => widget.activeRoute ?? widget.route;

  void _onTap() {
    if (Modular.to.isActive(route)) return;

    widget.onTap?.call();
    Modular.to.navigate(widget.route);

    setState(() {
      isActive = true;
    });
  }

  void _onNavigate() {
    setState(() {
      isActive = Modular.to.isActive(route);
    });
  }

  bool isActive = false;

  @override
  void initState() {
    super.initState();

    Modular.to.addListener(_onNavigate);

    isActive = Modular.to.isActive(route);
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
          duration: const Duration(milliseconds: 300),
          decoration: ShapeDecoration(
            color: isActive ? context.theme.colorScheme.primary : context.theme.scaffoldBackgroundColor,
            shadows: kElevationToShadow[isActive || hover ? 2 : 0],
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
