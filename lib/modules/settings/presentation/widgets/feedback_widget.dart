import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:lb_planner/config/posthog.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:lb_planner/modules/auth/auth.dart';
import 'package:lb_planner/modules/theming/theming.dart';
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
          await scope.setTag('type', dropdownValue.toString());
          scope.level = dropdownValue.sentryLevel;
        },
      );

      messageController.clear();
      if (mounted) {
        await showAlertDialog(
          context,
          title: 'Feedback sent',
          message: 'Thank you for your feedback. We will get back to you as soon as possible.\n\nYour feedback ID is: $sentryId',
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
          title: 'Unable to send feedback',
          message: 'An error occurred while sending your feedback and the error has been reported to the developers. Please try again later.',
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
              'Feedback',
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
                            // alignmentOffset: const Offset(60, 70),
                            width: 135,

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
                        hintText: 'Please describe your problem.',
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
                                text: 'I agree to sharing my email address and name with the developers in accordance with our ',
                                children: [
                                  TextSpan(
                                    text: 'Privacy Policy.',
                                    style: context.bodySmall?.copyWith(
                                      color: context.theme.colorScheme.primary,
                                    ),
                                    mouseCursor: SystemMouseCursors.click,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        launchUrl(kPrivacyPolicyUrl);
                                      },
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
                      child: const Text('Submit Feedback'),
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

  static String _bug(BuildContext context) => 'Bug';
  static String _typo(BuildContext context) => 'Typo';
  static String _feature(BuildContext context) => 'Feature';
  static String _other(BuildContext context) => 'Other';
}
