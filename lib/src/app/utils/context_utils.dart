import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/eduplanner.dart';
import 'package:flutter/material.dart';

export 'package:eduplanner/gen/l10n/app_localizations.dart';

/// Adds a [AppLocalizations] getter to [BuildContext].
extension ContextUtils on BuildContext {
  /// The [AppLocalizations] of this context.
  AppLocalizations get t => AppLocalizations.of(this);

  /// The [TaskStatusTheme] of this context's theme.
  TaskStatusTheme get taskStatusTheme => theme.extension<TaskStatusTheme>()!;
}

/// Adds a [AppLocalizations] getter to [State].
extension StateUtils on State {
  /// The [AppLocalizations] of this state's context.
  AppLocalizations get t => AppLocalizations.of(context);

  /// The [TaskStatusTheme] of this state's context's theme.
  TaskStatusTheme get taskStatusTheme => context.theme.extension<TaskStatusTheme>()!;
}

/// A function that returns a translated string based on the [BuildContext].
typedef Translator = String Function(BuildContext context);
