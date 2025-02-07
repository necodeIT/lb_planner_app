import 'package:flutter/material.dart';

/// Adds utility methods to [IconButton].
extension IconButtonX on IconButton {
  /// Creates an [IconButton] with no splash effect on hover or tap.
  Widget noSplash() {
    return IconButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onPressed: onPressed,
      icon: icon,
      alignment: alignment,
      padding: padding,
      iconSize: iconSize,
      color: color,
      constraints: constraints,
      autofocus: autofocus,
      tooltip: tooltip,
      enableFeedback: enableFeedback,
      focusColor: focusColor,
      disabledColor: disabledColor,
      focusNode: focusNode,
      isSelected: isSelected,
      mouseCursor: mouseCursor,
      selectedIcon: selectedIcon,
      splashRadius: splashRadius,
      style: style,
      visualDensity: visualDensity,
      key: key,
    );
  }
}
