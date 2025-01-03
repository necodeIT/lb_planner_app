import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/moodle/moodle.dart';
import 'package:lb_planner/modules/notifications/notifications.dart';
import 'package:lb_planner/modules/theming/theming.dart';
import 'package:popover/popover.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:window_manager/window_manager.dart';

/// A bar displaying the current route's title and the current user's name and profile picture.
class TitleBar extends StatefulWidget {
  /// A bar displaying the current route's title and the current user's name and profile picture.
  const TitleBar({super.key});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> with WindowListener {
  @override
  void initState() {
    super.initState();

    Modular.to.addListener(_listener);
    WindowManager.instance.addListener(this);
  }

  /// Rebuild the widget when the route changes
  /// so we can update the title accordingly.
  void _listener() => setState(() {});

  BuildContext? popupContext;

  @override
  void onWindowResize() {
    closeNotifications();
  }

  @override
  void onWindowResized() {
    closeNotifications();
  }

  @override
  void onWindowMaximize() {
    closeNotifications();
  }

  @override
  void onWindowUnmaximize() {
    closeNotifications();
  }

  void setPopupContext(BuildContext? context) {
    popupContext = context;

    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
  }

  void closeNotifications() {
    if (popupContext == null) return;

    Navigator.of(popupContext!).pop();

    setPopupContext(null);
  }

  Future<void> showNotifications(BuildContext context) async {
    if (popupContext != null) return;

    final height = context.height * 0.5;
    final width = context.width * 0.2;

    await showPopover(
      context: context,
      bodyBuilder: (context) {
        setPopupContext(context);

        return const NotificationsList();
      },
      onPop: () => setPopupContext(null),
      barrierColor: Colors.transparent,
      direction: PopoverDirection.top,
      transition: PopoverTransition.other,
      contentDxOffset: -width + (context.size?.width ?? 0),
      backgroundColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 300),
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
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>().state.data ??
        User(
          id: -1,
          username: 'Loading',
          firstname: 'Loading',
          lastname: 'Loading',
        );

    final title = Modular.tryGet<TitleBuilder>()?.call(context);

    final notifications = context.watch<NotificationsRepository>();

    return Row(
      key: ValueKey(title),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Skeletonizer(
          enabled: title == null,
          child: Text(
            title ?? kAppName,
            style: context.textTheme.titleLarge?.bold,
          ).fontSize(24),
        ),
        Skeletonizer(
          enabled: user.id == -1,
          child: Row(
            children: [
              Builder(
                builder: (context) {
                  return IconButton(
                    onPressed: () => showNotifications(context),
                    icon: ConditionalWrapper(
                      condition: notifications.hasUnreadNotifications,
                      wrapper: (_, child) => Badge(
                        backgroundColor: context.theme.colorScheme.primary,
                        child: child,
                      ),
                      child: Icon(
                        popupContext != null ? FontAwesome5Solid.bell : FontAwesome5Regular.bell,
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
    );
  }

  @override
  void dispose() {
    Modular.to.removeListener(_listener);
    WindowManager.instance.removeListener(this);
    super.dispose();
  }
}

/// Returns the localized title of the current route.
typedef TitleBuilder = String Function(BuildContext context);
