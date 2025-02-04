import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lb_planner/src/app/app.dart';

/// Shows a dialog with default animations.
Future<T?> showAnimatedDialog<T>({required BuildContext context, required RoutePageBuilder pageBuilder}) {
  return showGeneralDialog<T>(
    context: context,
    transitionBuilder: (context, a1, a2, child) => ScaleTransition(
      scale: Tween<double>(begin: 1.2, end: 1).animate(
        a1.drive(
          CurveTween(curve: Curves.easeInOut),
        ),
      ),
      child: FadeTransition(
        opacity: a1.drive(
          CurveTween(curve: Curves.easeInOut),
        ),
        child: child,
      ),
    ),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: pageBuilder,
    barrierDismissible: true,
    barrierLabel: context.t.global_dismiss,
  );
}

/// Shows a [GenericDialog] with the given [title] and [content] to the user.
Future<T?> showGenericDialog<T>(
  BuildContext context, {
  required String title,
  required Widget content,
  List<DialogAction>? actions,
  bool shrinkWrap = true,
  bool shrinkWrapWidth = false,
}) {
  return showAnimatedDialog<T>(
    context: context,
    pageBuilder: (_, __, ___) => GenericDialog(
      title: Text(title).bold(),
      content: content,
      actions: actions,
      shrinkWrap: shrinkWrap,
      shrinkWrapWidth: shrinkWrapWidth,
    ),
  );
}

/// Shows a confirmation dialog with the given [title] and [message] to the user.
///
/// The dialog will have a confirm and a cancel button and will return `true` if the confirm button is pressed and `false` if the cancel button is pressed.
Future<bool> showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
}) async {
  final result = await showGenericDialog<bool>(
    context,
    title: title,
    content: Text(message),
    shrinkWrapWidth: true,
    actions: [
      PrimaryDialogAction(
        label: confirmLabel ?? context.t.global_confirm,
        onPressed: (context) {
          Navigator.of(context).pop(true);
        },
      ),
      SecondaryDialogAction(
        label: cancelLabel ?? context.t.global_cancel,
        onPressed: (context) {
          Navigator.of(context).pop(false);
        },
      ),
    ],
  );

  return result ?? false;
}

/// Shows an alert dialog with the given [title] and [message] to the user.
/// The dialog will have an OK button to dismiss it.
Future<void> showAlertDialog(
  BuildContext context, {
  required String title,
  required String message,
  String? confirmLabel,
}) async {
  await showGenericDialog<void>(
    context,
    title: title,
    content: Text(message),
    shrinkWrapWidth: true,
    actions: [
      PrimaryDialogAction(
        label: confirmLabel ?? context.t.global_ok,
        onPressed: Navigator.pop,
      ),
    ],
  );
}

/// Shows an alert dialog but with a markdown body.
Future<void> showMarkdownDialog(BuildContext context, {required String title, required String markdown, String? confirmLabel}) async {
  await showGenericDialog<void>(
    context,
    title: title,
    content: MarkdownBody(data: markdown),
    actions: [
      PrimaryDialogAction(
        label: confirmLabel ?? context.t.global_ok,
        onPressed: Navigator.pop,
      ),
    ],
  );
}
