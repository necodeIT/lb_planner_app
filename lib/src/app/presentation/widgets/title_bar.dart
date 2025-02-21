import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:data_widget/data_widget.dart';
import 'package:echidna_flutter/echidna_flutter.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/moodle/moodle.dart';
import 'package:eduplanner/src/notifications/notifications.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:popover/popover.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:window_manager/window_manager.dart';

/// A bar displaying the current route's title and the current user's name and profile picture.
class TitleBar extends StatefulWidget {
  /// A bar displaying the current route's title and the current user's name and profile picture.
  const TitleBar({super.key, required this.child});

  /// The child widget to display below the title bar.
  final Widget child;

  @override
  State<TitleBar> createState() => TitleBarState();
}

/// The state of the current route's title bar.
class TitleBarState extends State<TitleBar> with WindowListener, RouteAware, AdaptiveState {
  String? _prevRoute;

  @override
  void initState() {
    super.initState();

    Modular.to.addListener(_listener);
    WindowManager.instance.addListener(this);
  }

  /// Rebuild the widget when the route changes
  /// so we can update the title accordingly.
  void _listener() {
    setState(() {
      _parentRoute = null;
      _searchController = null;
      _trailing = null;
    });
  }

  BuildContext? _popupContext;

  String? _parentRoute;

  TextEditingController? _searchController;

  Widget? _trailing;

  /// Sets the trailing widget of the current route.
  ///
  /// This will appear on the end of the route's title.
  void setTrailingWidget(Widget widget) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _trailing = widget;
      });
    });
  }

  /// Set the search controller of the current route.
  ///
  /// This will show a search bar in the title bar if set.
  void setSearchController(TextEditingController? controller) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _searchController = controller;
      });
    });
  }

  /// Set the parent route of the current route.
  ///
  /// This will show a back button in the title bar and navigate to the parent route when pressed if set.
  void setParentRoute(String? route) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _parentRoute = route;
      });
    });
  }

  @override
  void onWindowResize() {
    _closeNotifications();
  }

  @override
  void onWindowResized() {
    _closeNotifications();
  }

  @override
  void onWindowMaximize() {
    _closeNotifications();
  }

  @override
  void onWindowUnmaximize() {
    _closeNotifications();
  }

  void _setPopupContext(BuildContext? context) {
    _popupContext = context;

    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  void _closeNotifications() {
    if (_popupContext == null) return;

    Navigator.of(_popupContext!).pop();

    _setPopupContext(null);
  }

  Future<void> _showNotifications(BuildContext context) async {
    if (_popupContext != null) return;

    final height = context.height * 0.5;
    final width = context.width * 0.2;

    await showPopover(
      context: context,
      bodyBuilder: (context) {
        _setPopupContext(context);

        return const NotificationsList();
      },
      onPop: () => _setPopupContext(null),
      barrierColor: Colors.transparent,
      direction: PopoverDirection.top,
      transition: PopoverTransition.other,
      contentDxOffset: -width + (context.size?.width ?? 0),
      backgroundColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
      arrowHeight: 0,
      arrowWidth: 0,
      constraints: BoxConstraints(
        maxWidth: width,
        maxHeight: height,
        minHeight: height,
        minWidth: width,
      ),
      popoverTransitionBuilder: (animation, child) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(
              Tween<Offset>(
                begin: const Offset(0, -0.02),
                end: Offset.zero,
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    // check if the route has changed and reset the search controller and parent route
    if (_prevRoute != Modular.to.path) {
      _prevRoute = Modular.to.path;

      setSearchController(null);
      setParentRoute(null);
    }

    final user = context.watch<UserRepository>().state.data ??
        User(
          id: -1,
          username: 'Loading',
          firstname: 'Loading',
          lastname: 'Loading',
        );

    final (title, featureId) = Modular.tryGet<TitleBuilder>()?.call(context) ?? (null, null);

    final notifications = context.watch<NotificationsRepository>();
    final license = context.watch<LicenseRepository>();

    final showLicenseBadge = featureId != null && license.state.data != null;

    return Column(
      children: [
        Padding(
          padding: PaddingAll(Spacing.mediumSpacing).Bottom(0),
          child: Row(
            key: ValueKey(title),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConditionalWrapper(
                    condition: _parentRoute != null,
                    wrapper: (_, child) => TextButton(
                      onPressed: () => Modular.to.navigate(_parentRoute!),
                      child: Row(
                        children: [
                          const Icon(FontAwesome5Solid.angle_left),
                          Spacing.xsHorizontal(),
                          child,
                        ],
                      ),
                    ),
                    child: Skeletonizer(
                      enabled: title == null,
                      child: Text(
                        title ?? kAppName,
                        style: context.textTheme.titleLarge,
                      ).fontSize(24),
                    ),
                  ),
                  if (showLicenseBadge) Spacing.smallHorizontal(),
                  if (showLicenseBadge)
                    Container(
                      padding: PaddingAll(Spacing.xsSpacing).Horizontal(Spacing.smallSpacing),
                      decoration: ShapeDecoration(
                        shape: squircle(
                          radius: 5000,
                          side: BorderSide(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                        color: context.theme.colorScheme.primary.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        license.state.requireData.active ? context.t.app_titleBar_pro : context.t.app_titleBar_trial,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  if (showLicenseBadge) Spacing.smallHorizontal(),
                  if (_trailing != null) _trailing!,
                ],
              ),
              if (_searchController != null)
                SizedBox(
                  width: context.width * 0.4,
                  child: TextField(
                    controller: _searchController,
                    style: context.textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: context.t.global_search,
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: context.theme.colorScheme.surface,
                      focusColor: context.theme.colorScheme.surface,
                      hoverColor: context.theme.colorScheme.surface,
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              Skeletonizer(
                enabled: user.id == -1,
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () => _showNotifications(context),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          icon: ConditionalWrapper(
                            condition: notifications.hasUnreadNotifications,
                            wrapper: (_, child) => Badge(
                              backgroundColor: context.theme.colorScheme.primary,
                              child: child,
                            ),
                            child: Icon(
                              _popupContext != null ? FontAwesome5Solid.bell : FontAwesome5Regular.bell,
                            ),
                          ),
                        );
                      },
                    ),
                    Spacing.xsHorizontal(),
                    const UserProfileImage(),
                    Spacing.xsHorizontal(),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.fullname,
                          style: context.textTheme.titleMedium?.semiBold,
                        ).fontSize(17),
                        if (user.vintage != null)
                          user.vintage!.humanReadable.text.color(context.theme.colorScheme.primary).color(context.theme.colorScheme.primary)
                        else if (user.capabilities.isNotEmpty)
                          Text(user.capabilities.highest.translate(context)).color(context.theme.colorScheme.primary),
                      ],
                    ),
                  ].show(),
                ),
              ),
            ].show(),
          ),
        ),
        Data.inherit(data: this, child: widget.child).expanded(),
      ],
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    // check if the route has changed and reset the search controller and parent route
    if (_prevRoute != Modular.to.path) {
      _prevRoute = Modular.to.path;

      setSearchController(null);
      setParentRoute(null);
    }

    final user = context.watch<UserRepository>().state.data ??
        User(
          id: -1,
          username: 'Loading',
          firstname: 'Loading',
          lastname: 'Loading',
        );

    final (title, featureId) = Modular.tryGet<TitleBuilder>()?.call(context) ?? (null, null);

    final notifications = context.watch<NotificationsRepository>();
    final license = context.watch<LicenseRepository>();

    final showLicenseBadge = featureId != null && license.state.data != null;

    // TODO: fix license widget not rendering if title is too long.
    return Column(
      children: [
        Padding(
          padding: PaddingAll(Spacing.mediumSpacing).Bottom(0),
          child: Row(
            key: ValueKey(title),
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ConditionalWrapper(
                    condition: _parentRoute != null,
                    wrapper: (_, child) => TextButton(
                      onPressed: () => Modular.to.navigate(_parentRoute!),
                      child: Row(
                        children: [
                          const Icon(FontAwesome5Solid.angle_left),
                          Spacing.xsHorizontal(),
                          child,
                        ],
                      ),
                    ),
                    child: Skeletonizer(
                      enabled: title == null,
                      child: Text(
                        title ?? kAppName,
                        style: context.textTheme.titleLarge,
                      ).fontSize(24),
                    ),
                  ),
                  if (showLicenseBadge) Spacing.smallHorizontal(),
                  if (showLicenseBadge)
                    Container(
                      padding: PaddingAll(Spacing.xsSpacing).Horizontal(Spacing.smallSpacing),
                      decoration: ShapeDecoration(
                        shape: squircle(
                          radius: 5000,
                          side: BorderSide(
                            color: context.theme.colorScheme.primary,
                          ),
                        ),
                        color: context.theme.colorScheme.primary.withValues(alpha: 0.1),
                      ),
                      child: Text(
                        license.state.requireData.active ? context.t.app_titleBar_pro : context.t.app_titleBar_trial,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  if (showLicenseBadge) Spacing.smallHorizontal(),
                  if (_trailing != null) _trailing!,
                ],
              ),
              // TODO: implement mobile notifications and user settings
              Skeletonizer(
                enabled: user.id == -1,
                child: Row(
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: () => _showNotifications(context),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          icon: ConditionalWrapper(
                            condition: notifications.hasUnreadNotifications,
                            wrapper: (_, child) => Badge(
                              backgroundColor: context.theme.colorScheme.primary,
                              child: child,
                            ),
                            child: Icon(
                              _popupContext != null ? FontAwesome5Solid.bell : FontAwesome5Regular.bell,
                            ),
                          ),
                        );
                      },
                    ),
                    Spacing.xsHorizontal(),
                    const UserProfileImage(),
                    // Spacing.xsHorizontal(),
                    // Column(
                    //   mainAxisSize: MainAxisSize.min,
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       user.fullname,
                    //       style: context.textTheme.titleMedium?.semiBold,
                    //     ).fontSize(17),
                    //     if (user.vintage != null)
                    //       user.vintage!.humanReadable.text.color(context.theme.colorScheme.primary).color(context.theme.colorScheme.primary)
                    //     else if (user.capabilities.isNotEmpty)
                    //       Text(user.capabilities.highest.translate(context)).color(context.theme.colorScheme.primary),
                    //   ],
                    // ),
                  ].show(),
                ),
              ),
            ].show(),
          ),
        ),
        Data.inherit(data: this, child: widget.child).expanded(),
      ],
    );
  }

  @override
  void dispose() {
    Modular.to.removeListener(_listener);
    WindowManager.instance.removeListener(this);
    super.dispose();
  }
}

/// Returns a record of the current route's localized title and it's feature id.`
typedef TitleBuilder = (String, int?) Function(BuildContext context);
