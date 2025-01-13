import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

export 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Adds a [AppLocalizations] getter to [BuildContext].
extension ContextUtils on BuildContext {
  /// The [AppLocalizations] of this context.
  AppLocalizations get t => AppLocalizations.of(this);
}

/// Adds a [AppLocalizations] getter to [State].
extension StateUtils on State {
  /// The [AppLocalizations] of this state's context.
  AppLocalizations get t => AppLocalizations.of(context);
}

/// A function that returns a translated string based on the [BuildContext].
typedef Translator = String Function(BuildContext context);
