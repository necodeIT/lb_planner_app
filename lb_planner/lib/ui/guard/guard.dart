import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'svg/error.dart';

// class NcGuard extends InheritedWidget {
//   NcGuard({required this.child}) : super(child: child);

//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return child;
//   }
// }

class Guard {
  static bool _showNextError = true;

  static const noInfo = 'No information proivided.';
  static const crashKey = "crash";

  static void init(BuildContext context) {
    _setErrorWidgetBuilder();
    _setFlutterErrorHandler(context);
  }

  static _pop(BuildContext context) => Navigator.of(context).pop();

  static _blockErrors() {
    _showNextError = false;
  }

  static _enableErrors() {
    _showNextError = true;
  }

  static reportError(BuildContext context, Object exception) {
    if (!_showNextError) return;

    // if (!kReleaseMode) return print(message);

    report(context, exception.toString());
  }

  static report(BuildContext context, String message, {String title = "Something went wrong!"}) {
    _blockErrors();

    showDialog(
      context: context,
      builder: (context) {
        return NcDialog(
          title: title,
          body: SingleChildScrollView(
            child: NcBodyText(
              message,
              overflow: TextOverflow.visible,
            ),
          ),
          onConfirm: () {
            // TODO: report error
            _enableErrors();
            _pop(context);
          },
          onCancel: () {
            _pop(context);

            _enableErrors();
          },
          confirmText: "Send Report",
          buttonWidth: 130,
        );
      },
    );
  }

  static run(BuildContext context, Function body) {
    try {
      body();
    } catch (e) {
      reportError(context, e);
    }
  }

  static checkForRecentCrash(BuildContext context) {
    print("Guard.checkForRecentCrash(BuildContext context) is not fully implemented yet!");
    // SharedPreferences.getInstance().then(
    //   (prefs) {
    //     var crash = prefs.getString(crashKey);
    //     if (crash != null) report(context, "Application crashed last time", crash);
    //   },
    // );
  }

  static handleFlutterError(BuildContext context, FlutterErrorDetails details) {
    // TODO: check if error is build error ? return : show dialog

    print("Guard.handleFlutterError(BuildContext context, FlutterErrorDetails details) is not fully implemented yet!");
    if (details.toString().contains("EXCEPTION CAUGHT BY RENDERING LIBRARY") || details.toString().contains("EXCEPTION CAUGHT BY WIDGETS LIBRAR")) return print("Error is builderror. Skipping dialog.");

    String message = "${details.context ?? noInfo}";

    // print('catgirl ${details.toString()}');

    report(context, message);

    // if (kReleaseMode) {
    //   SharedPreferences.getInstance().then((prefs) => prefs.setString(crashKey, message));
    // }
  }

  static _setFlutterErrorHandler(BuildContext context) {
    FlutterError.onError = (details) => Guard.handleFlutterError(context, details);
  }

  static _setErrorWidgetBuilder() {
    ErrorWidget.builder = kReleaseMode
        ? (details) => LayoutBuilder(
              builder: (context, size) {
                final message = "Internal Error:  '${details.context != null ? details.context!.name ?? Guard.noInfo : Guard.noInfo}'. Please restart the application and try again.";

                return Center(
                  child: Column(
                    children: [
                      NcSpacing.small(),
                      NcVectorImage(
                        code: error_svg,
                        width: size.maxWidth * .8,
                      ),
                      NcSpacing.small(),
                      Tooltip(
                        message: message,
                        child: NcBodyText(message),
                      ),
                      NcSpacing.small(),
                    ],
                  ),
                );
              },
            )
        : ErrorWidget.builder;
  }
}

guard(BuildContext context, Function body) => Guard.run;