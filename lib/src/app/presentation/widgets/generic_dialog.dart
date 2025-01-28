import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lb_planner/src/theming/theming.dart';

/// A generic dialog that can be used to display information to the user.
class GenericDialog extends StatelessWidget {
  /// A generic dialog that can be used to display information to the user.
  const GenericDialog({super.key, required this.title, required this.content, this.actions, this.shrinkWrap = true, this.shrinkWrapWidth = false});

  /// The title of the dialog.
  final Widget title;

  /// The content of the dialog.
  final Widget content;

  /// If true, the height of the dialog will be the height of the content.
  final bool shrinkWrap;

  /// If true, the width of the dialog will be the width of the content.
  final bool shrinkWrapWidth;

  /// The actions that can be taken in the dialog.
  final List<DialogAction>? actions;

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: FocusNode(),
      onKeyEvent: (value) {
        if (value.physicalKey != PhysicalKeyboardKey.escape) return;

        Navigator.of(context).pop();
      },
      child: AlertDialog(
        backgroundColor: context.theme.cardColor,
        title: title is Text ? (title as Text).bold() : title,
        shape: squircle(),
        content: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: context.height * 0.8,
            minHeight: shrinkWrap ? 0 : context.height * 0.8,
            maxWidth: context.width * 0.5,
            minWidth: shrinkWrapWidth ? 0 : context.width * 0.5,
          ),
          child: content,
        ),
        actions: actions,
      ),
    );
  }
}

/// Represents an action that can be taken in a dialog.
abstract class DialogAction extends StatelessWidget {
  /// Represents an action that can be taken in a dialog.
  const DialogAction({super.key, required this.label, required this.onPressed});

  /// The label of the action.
  final String label;

  /// The action to be taken when the action is pressed.
  final void Function(BuildContext)? onPressed;
}

/// Represents a primary action that can be taken in a dialog.
class PrimaryDialogAction extends DialogAction {
  /// Represents a primary action that can be taken in a dialog.
  const PrimaryDialogAction({super.key, required super.label, required super.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed != null ? () => onPressed!(context) : null,
      child: Text(label),
    );
  }
}

/// Represents a secondary action that can be taken in a dialog.
class SecondaryDialogAction extends DialogAction {
  /// Represents a secondary action that can be taken in a dialog.
  const SecondaryDialogAction({super.key, required super.label, required super.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed != null ? () => onPressed!(context) : null,
      child: Text(label),
    );
  }
}

/// Represents a destructive action that can be taken in a dialog.
class DestructiveDialogAction extends DialogAction {
  /// Represents a destructive action that can be taken in a dialog.
  const DestructiveDialogAction({super.key, required super.label, required super.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed != null ? () => onPressed!(context) : null,
      style: TextButton.styleFrom(
        foregroundColor: context.theme.colorScheme.error,
      ),
      child: Text(label),
    );
  }
}
