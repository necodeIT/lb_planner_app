part of lbplanner_routes;

/// Wraps a route in a Sidebar and a scaffold.
class RouteWrapper extends StatelessWidget {
  /// Wraps a route in a Sidebar and a scaffold.
  const RouteWrapper({Key? key, required this.child}) : super(key: key);

  /// The child to wrap.
  final Widget child;

  static String _currentRoute = '';

  /// The current route that was pushed.
  static String get currentRoute => _currentRoute;

  /// Whether the current route is [LoginRoute.routeName].
  static bool get isLogin => _currentRoute == LoginRoute.routeName || _currentRoute == LoginSelectCoursesRoute.routeName;

  /// Generates a route.
  static PageRouteBuilder gnerateRoute(RouteSettings settings) {
    _currentRoute = settings.name ?? '';

    log("Navigating to '$currentRoute'", LogTypes.tracking);

    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) => Center(child: kRoutes[settings.name]?.call(context) ?? NcTitleText("404")),
      transitionsBuilder: (context, animation, secondaryAnimation, child) => RouteWrapper(
        child: SharedAxisTransition(
          transitionType: SharedAxisTransitionType.vertical,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
          fillColor: secondaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ContextMenuOverlay(
      buttonBuilder: (context, config, [_]) => HoverBuilder(
        builder: (_, hover) => Padding(
          padding: const EdgeInsets.all(NcSpacing.xsSpacing),
          child: Row(
            children: [
              if (config.icon != null && !(config.iconHover != null && hover)) config.icon!,
              if (config.iconHover != null && hover) config.iconHover!,
              if (config.icon != null) NcSpacing.small(),
              NcCaptionText(config.label),
            ],
          ),
        ),
        onTap: config.onPressed,
      ),
      cardBuilder: (context, children) => Container(
        padding: const EdgeInsets.all(NcSpacing.xsSpacing),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(kRadius),
          boxShadow: kElevationToShadow[3],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: secondaryColor,
          body: Sidebar(
            child: ConditionalWrapper(
              condition: !isLogin,
              wrapper: RouteTitle.builder,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
