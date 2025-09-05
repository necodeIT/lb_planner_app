/// Settings widgets and utilities for building the settings UI.
///
/// This library provides a small set of composable primitives used to render
/// the Settings screen:
/// - `GenericSettingsItem`: base contract for a single settings row.
/// - `SettingsRowLayout`: common row layout with a trailing/leading suffix.
/// - `IconSettingsItem`: actionable row that shows an icon as its suffix.
/// - `BooleanSettingsItem`: toggle row rendered as a switch or checkbox.
/// - `EnumSettingsItem<T>`: dropdown row for choosing among predefined values.
/// - `GenericSettings`: titled group that lays out a list of items.
///
/// All widgets are designed to adapt to form factors via `AdaptiveWidget` and
/// share a consistent look-and-feel.
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

/// Base type for items rendered by [GenericSettings].
abstract class GenericSettingsItem {
  /// Base type for items rendered by [GenericSettings].
  const GenericSettingsItem({
    required this.name,
    this.onPressed,
    this.description,
  });

  /// Human-readable label displayed for this settings row.
  final String name;

  /// Callback invoked when the row is tapped/clicked.
  ///
  /// Implementations may choose to wire this to an inner interactive control
  /// (e.g. a toggle), or leave it unused. When null, the row is non-interactive
  /// except for its inner widgets.
  final VoidCallback? onPressed;

  /// Optional secondary text describing the setting.
  ///
  /// Not directly used by the base layout but available to concrete
  /// implementations that choose to display additional context.
  final String? description;

  /// Canonical max height used by suffix controls to align rows consistently.
  static const maxItemHeight = 35.0;

  /// Builds the visual representation of this item.
  ///
  /// The default implementation renders a simple [Text] with [name].
  /// Subclasses typically override this to provide richer content but should
  /// still respect the overall row height and spacing conventions.
  Widget build(BuildContext context) {
    return Text(name);
  }
}

/// Base layout for a single-line settings row with a suffix widget.
///
/// The main content (usually the [name] and optional description) is laid out
/// opposite a suffix built by [buildSuffix]. On mobile, the order is reversed
/// so the suffix appears on the leading side to improve reachability.
abstract class SettingsRowLayout extends GenericSettingsItem {
  /// Base layout for a single-line settings row with a suffix widget.
  ///
  /// The main content (usually the [name] and optional description) is laid out
  /// opposite a suffix built by [buildSuffix]. On mobile, the order is reversed
  /// so the suffix appears on the leading side to improve reachability.
  const SettingsRowLayout({
    required super.name,
    super.onPressed,
    super.description,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[
      super.build(context).expanded(),
      Spacing.smallHorizontal(),
      buildSuffix(context),
    ];

    return SizedBox(
      child: GestureDetector(
        onTap: onPressed,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: context.isMobile ? children.reversed.toList() : children,
        ),
      ),
    );
  }

  /// Builds the trailing/leading widget shown opposite to the main content.
  ///
  /// On desktop the suffix appears at the end of the row; on mobile, the row
  /// order is reversed to improve ergonomics.
  Widget buildSuffix(BuildContext context);
}

/// An actionable row with an icon on the trailing/leading side.
class IconSettingsItem extends SettingsRowLayout {
  /// An actionable row with an icon on the trailing/leading side.
  const IconSettingsItem({
    required super.name,
    required this.icon,
    super.onPressed,
    this.hoverColor,
    this.iconSize = 20,
    super.description,
  });

  /// Icon to display as the row suffix.
  final IconData icon;

  /// Optional color applied to the icon when the row is hovered.
  final Color? hoverColor;

  /// Size of the icon in logical pixels.
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return HoverBuilder(
      cursor: onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onTap: onPressed,
      builder: (context, hovering) => IconTheme(
        data: IconThemeData(color: hovering ? hoverColor ?? context.theme.colorScheme.primary : context.theme.colorScheme.onSurface),
        child: super.build(context),
      ),
    );
  }

  @override
  Widget buildSuffix(BuildContext context) {
    return ConditionalWrapper(
      condition: !context.isMobile,
      child: Icon(
        icon,
        size: iconSize,
      ),
      wrapper: (context, child) => Container(
        width: GenericSettingsItem.maxItemHeight,
        height: GenericSettingsItem.maxItemHeight,
        decoration: ShapeDecoration(
          shape: squircle(),
          color: context.theme.scaffoldBackgroundColor,
        ),
        child: child,
      ),
    );
  }
}

/// A boolean setting rendered as a switch or checkbox.
///
/// - By default this shows a [Checkbox].
/// - Set [checkbox] to false to use a [Switch] instead.
/// - Tapping the row toggles the value by calling [onChanged] with `!value`.
class BooleanSettingsItem extends SettingsRowLayout {
  /// A boolean setting rendered as a switch or checkbox.
  ///
  /// - By default this shows a [Checkbox].
  /// - Set [checkbox] to false to use a [Switch] instead.
  /// - Tapping the row toggles the value by calling [onChanged] with `!value`.
  BooleanSettingsItem({
    required super.name,
    required this.value,
    required this.onChanged,
    this.checkbox = true,
    super.description,
  }) : super(onPressed: () => onChanged(!value));

  /// Current value of the toggle.
  final bool value;

  /// Callback fired when the toggle changes.
  final ValueChanged<bool?> onChanged;

  /// If true, renders a [Checkbox]; otherwise renders a [Switch].
  final bool checkbox;

  @override
  Widget buildSuffix(BuildContext context) {
    return checkbox
        ? Checkbox(value: value, onChanged: onChanged)
        : Switch(
            value: value,
            onChanged: onChanged,
          );
  }
}

/// A dropdown row for choosing one value from a predefined list.
///
/// Generic over [T] and uses [itemBuilder] (and optional [iconBuilder]) to map
/// each value to its presentation.
class EnumSettingsItem<T> extends SettingsRowLayout {
  /// A dropdown row for choosing one value from a predefined list.
  ///
  /// Generic over [T] and uses [itemBuilder] (and optional [iconBuilder]) to map
  /// each value to its presentation.
  EnumSettingsItem({
    required super.name,
    required this.value,
    required this.values,
    required this.onChanged,
    required this.itemBuilder,
    this.iconBuilder,
    this.iconSize = 16,
    this.label,
    this.helperText,
    super.description,
    this.dropDownWidth,
  }) : super(onPressed: null);

  /// Currently selected value.
  final T value;

  /// All available values that can be selected.
  final List<T> values;

  /// Called when a new value is selected from the dropdown.
  final ValueChanged<T?> onChanged;

  /// Returns the display label for a value.
  ///
  /// This allows the widget to remain generic over `T` while presenting a
  /// meaningful string in the UI.
  final String Function(BuildContext, T) itemBuilder;

  /// Optionally returns an icon to show next to the value.
  final IconData? Function(BuildContext, T)? iconBuilder;

  /// Icon size used for both the selected value and entries.
  final double iconSize;

  /// Optional label displayed above the dropdown field.
  final String? label;

  /// Optional helper text displayed below the dropdown field.
  final String? helperText;

  /// Fixed width for the dropdown; defaults to intrinsic width when null.
  final double? dropDownWidth;

  @override
  Widget buildSuffix(BuildContext context) {
    final icon = iconBuilder?.call(context, value);

    return Theme(
      data: context.theme.copyWith(
        colorScheme: context.theme.colorScheme.copyWith(onSurface: context.theme.colorScheme.primary),
      ),
      child: SizedBox(
        height: GenericSettingsItem.maxItemHeight,
        child: DropdownMenu<T>(
          inputDecorationTheme: context.theme.dropdownMenuTheme.inputDecorationTheme?.copyWith(
            contentPadding: PaddingAll(Spacing.xsSpacing).Horizontal(Spacing.smallSpacing),
          ),
          width: dropDownWidth,
          trailingIcon: const Icon(
            FontAwesome5Solid.chevron_down,
            size: 13,
          ),
          enableSearch: false,
          requestFocusOnTap: false,
          label: label != null ? Text(label!) : null,
          helperText: helperText,
          onSelected: onChanged,
          initialSelection: value,
          leadingIcon: icon != null ? Icon(icon, size: iconSize) : null,
          dropdownMenuEntries: values.map((e) {
            final icon = iconBuilder?.call(context, e);

            return DropdownMenuEntry(
              value: e,
              label: itemBuilder(context, e),
              leadingIcon: icon != null ? Icon(icon, size: iconSize) : null,
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Renders a list of settings items with consistent layout and behavior.
class GenericSettings extends StatelessWidget with AdaptiveWidget {
  /// Renders a list of settings items with consistent layout and behavior.
  const GenericSettings({
    super.key,
    required this.title,
    required this.items,
  });

  /// Title shown above the group of settings items.
  final String title;

  /// Items to render in order.
  final List<GenericSettingsItem> items;

  /// Builds the list of item widgets separated by vertical spacing.
  List<Widget> _buildItemWidgets(BuildContext context) {
    return items.map((e) => e.build(context)).toList().vSpaced(Spacing.smallSpacing);
  }

  @override

  /// Builds the desktop variant: a titled [Card] with a scrolling list.
  Widget buildDesktop(BuildContext context) {
    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Expanded(
              child: ListView(
                children: _buildItemWidgets(context).show(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override

  /// Builds the mobile variant: a titled [Column] without a card shell.
  Widget buildMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.textTheme.titleMedium?.bold,
        ).alignAtTopLeft(),
        Spacing.smallVertical(),
        Column(
          children: _buildItemWidgets(context).show(),
        ),
      ],
    );
  }
}
