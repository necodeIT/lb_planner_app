import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// Provides a [DropdownMenu] that allows the user to switch between different slot views based on their [UserCapability]s.
///
/// If there is <=1 options this returns [SizedBox.shrink].
class SlotsViewSwitcher extends StatelessWidget {
  /// Provides a [DropdownMenu] that allows the user to switch between different slot views based on their [UserCapability]s.
  ///
  /// If there is <=1 options this returns [SizedBox.shrink].
  const SlotsViewSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserRepository>();

    final currentRoute = Modular.to.path;
    final capabilities = user.state.data?.capabilities.toList() ?? [];

    if (capabilities.length <= 1) return const SizedBox.shrink();

    return DropdownMenu<UserCapability>(
      inputDecorationTheme: context.theme.dropdownMenuTheme.inputDecorationTheme
          ?.copyWith(fillColor: context.theme.cardColor, contentPadding: PaddingHorizontal(Spacing.smallSpacing)),
      dropdownMenuEntries: [
        for (final r in capabilities)
          DropdownMenuEntry(
            value: r,
            label: r.translateSlotRoute(context),
            labelWidget: Text(r.translateSlotRoute(context)),
            leadingIcon: Icon(r.slotIcon, size: 16),
          ),
      ],

      trailingIcon: const Icon(
        FontAwesome5Solid.chevron_down,
        size: 13,
      ),
      leadingIcon: Icon(
        SlotUserCapabilityX.capabilityFromRoute(currentRoute).slotIcon,
        size: 16,
      ),
      requestFocusOnTap: false, // disable text input
      initialSelection: SlotUserCapabilityX.capabilityFromRoute(currentRoute),
      onSelected: (r) {
        if (r == null) return;

        /// Do not use `navigate` as this will replace all loaded repositories.
        Modular.to.pushNamed(r.slotRoute);
      },
    );
  }
}

/// Extension on [UserCapability] for [SlotsViewSwitcher] to determine routes based on capabilities.
extension SlotUserCapabilityX on UserCapability {
  /// Returns the route (from root) to the screen slot screen linked to this capability.
  String get slotRoute {
    return switch (this) {
      UserCapability.teacher => '/slots/overview/',
      UserCapability.student => '/slots/book/',
      UserCapability.slotMaster => '/slots/',
    };
  }

  /// Returns the [UserCapability] linked to the given [route].
  ///
  /// If no matching capability is found this throws.
  static UserCapability capabilityFromRoute(String route) {
    if (route.startsWith(UserCapability.teacher.slotRoute)) {
      return UserCapability.teacher;
    }
    if (route.startsWith(UserCapability.student.slotRoute)) {
      return UserCapability.student;
    }
    if (route.startsWith(UserCapability.slotMaster.slotRoute)) {
      return UserCapability.slotMaster;
    }

    throw ArgumentError.value(route, 'route', 'Unkown route');
  }

  /// Returns a human readable name for the items in the dropdown menu.
  String translateSlotRoute(BuildContext context) {
    // TODO(mastermarcohd): localize values

    return switch (this) {
      UserCapability.teacher => 'View Reservations',
      UserCapability.student => 'Book Slots',
      UserCapability.slotMaster => 'Manage Slots',
    };
  }

  /// The icon used to represent this view in the dropdown.
  IconData get slotIcon {
    return switch (this) {
      UserCapability.teacher => FontAwesome5Solid.chalkboard_teacher,
      UserCapability.student => FontAwesome5Solid.book,
      UserCapability.slotMaster => FontAwesome5Solid.cogs,
    };
  }
}
