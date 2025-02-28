import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:eduplanner/config/posthog.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:eduplanner/src/auth/auth.dart';
import 'package:eduplanner/src/theming/theming.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:uicons_updated/uicons.dart';
import 'package:url_launcher/url_launcher.dart';

/// A widget that allows users to send feedback to the developers.
class FeedbackWidget extends StatefulWidget {
  /// A widget that allows users to send feedback to the developers.
  const FeedbackWidget({super.key});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  FeedbackType dropdownValue = FeedbackType.values.first;
  TextEditingController messageController = TextEditingController();

  bool sendingFeedback = false;
  bool agreed = false;

  @override
  void initState() {
    super.initState();

    messageController.addListener(() {
      setState(() {});
    });
  }

  // ignore: avoid_positional_boolean_parameters
  void onChanged(bool? value) {
    setState(() {
      agreed = value ?? !agreed;
    });
  }

  Future<void> _sendFeedback() async {
    if (sendingFeedback) {
      return;
    }

    setState(() {
      sendingFeedback = true;
    });

    final message = messageController.text.trim();

    try {
      final user = context.read<UserRepository>().state.requireData;

      final sentryFeedback = SentryFeedback(
        message: message,
        contactEmail: user.email,
        name: user.fullname,
      );

      final sentryId = await Sentry.captureFeedback(
        sentryFeedback,
        withScope: (scope) async {
          await scope.setTag('type', dropdownValue.name.capitalize);
          scope.level = dropdownValue.sentryLevel;
        },
      );

      messageController.clear();
      if (mounted) {
        await showAlertDialog(
          context,
          title: context.t.settings_feedback_sent_title,
          message: context.t.settings_feedback_sent_message(sentryId.toString()),
        );
      }
    } catch (e, s) {
      messageController.text = message;

      await Sentry.captureException(
        'Failed to send feedback: $e',
        stackTrace: s,
        withScope: (scope) async {
          await scope.setTag('type', dropdownValue.toString());
          scope.level = SentryLevel.fatal;
        },
      );

      if (mounted) {
        await showAlertDialog(
          context,
          title: context.t.settings_feedback_error_title,
          message: context.t.settings_feedback_error_message,
        );
      }
    } finally {
      setState(() {
        sendingFeedback = false;
      });
    }
  }

  Widget feedbackTypeIcon(FeedbackType type) {
    return Icon(
      switch (type) {
        FeedbackType.bug => FontAwesome5Solid.bug,
        FeedbackType.typo => UiconsSolid.text,
        FeedbackType.feature => FontAwesome5Solid.lightbulb,
        FeedbackType.other => FontAwesome5Solid.question_circle,
      },
      size: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: PaddingAll(),
        child: Column(
          children: [
            Text(
              context.t.settings_feedback_title,
              style: context.textTheme.titleMedium?.bold,
            ).alignAtTopLeft(),
            Spacing.small(),
            Expanded(
              child: Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Theme(
                          data: context.theme.copyWith(
                            colorScheme: context.theme.colorScheme.copyWith(onSurface: context.theme.colorScheme.primary),
                          ),
                          child: DropdownMenu(
                            width: 135,
                            alignmentOffset: const Offset(60, 65),
                            trailingIcon: const Icon(
                              FontAwesome5Solid.chevron_down,
                              size: 13,
                            ),
                            requestFocusOnTap: false, // disable text input
                            initialSelection: dropdownValue,
                            leadingIcon: feedbackTypeIcon(dropdownValue),
                            dropdownMenuEntries: FeedbackType.values.map<DropdownMenuEntry<FeedbackType>>((type) {
                              return DropdownMenuEntry<FeedbackType>(
                                value: type,
                                label: type.translate(context),
                                leadingIcon: feedbackTypeIcon(type),
                              );
                            }).toList(),
                            onSelected: (FeedbackType? value) {
                              if (value == null) return;

                              setState(() {
                                dropdownValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Spacing.small(),
                    TextField(
                      maxLines: null,
                      expands: true,
                      controller: messageController,
                      textAlignVertical: TextAlignVertical.top,
                      decoration: InputDecoration(
                        fillColor: context.theme.scaffoldBackgroundColor,
                        filled: true,
                        contentPadding: PaddingAll(Spacing.mediumSpacing),
                        hoverColor: context.theme.scaffoldBackgroundColor,
                        focusColor: context.theme.scaffoldBackgroundColor,
                        hintText: context.t.settings_feedback_description,
                        border: OutlineInputBorder(
                          borderRadius: squircle().borderRadius,
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ).expanded(),
                    Spacing.small(),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => onChanged(null),
                        child: Row(
                          children: [
                            Checkbox(value: agreed, onChanged: onChanged),
                            Text.rich(
                              TextSpan(
                                text: context.t.settings_feedback_consent,
                                children: [
                                  TextSpan(
                                    text: context.t.auth_privacyPolicy,
                                    style: context.bodySmall?.copyWith(
                                      color: context.theme.colorScheme.primary,
                                    ),
                                    mouseCursor: SystemMouseCursors.click,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(kPrivacyPolicyUrl);
                                      },
                                  ),
                                  TextSpan(
                                    text: context.t.settings_feedback_consentSuffix,
                                  ),
                                ],
                              ),
                              style: const TextStyle(fontSize: 12),
                            ).expanded(),
                          ],
                        ),
                      ),
                    ),
                    Spacing.small(),
                    ElevatedButton(
                      onPressed: agreed && messageController.text.isNotEmpty ? _sendFeedback : null,
                      child: Text(context.t.settings_feedback_submit),
                    ).stretch(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The type of feedback that can be sent.
enum FeedbackType {
  /// A bug report.
  bug(_bug, SentryLevel.error),

  /// Incorrect text or translation.
  typo(_typo, SentryLevel.warning),

  /// A feature request.
  feature(_feature, SentryLevel.info),

  /// Does not fit into any other category.
  other(_other, SentryLevel.debug);

  const FeedbackType(this.translate, this.sentryLevel);

  /// The translated string of the enum value.
  final String Function(BuildContext) translate;

  /// The [SentryLevel] equivalent of this type.
  final SentryLevel sentryLevel;

  static String _bug(BuildContext context) => context.t.settings_feedback_type_bug;
  static String _typo(BuildContext context) => context.t.settings_feedback_type_typo;
  static String _feature(BuildContext context) => context.t.settings_feedback_type_feature;
  static String _other(BuildContext context) => context.t.settings_feedback_type_other;
}
