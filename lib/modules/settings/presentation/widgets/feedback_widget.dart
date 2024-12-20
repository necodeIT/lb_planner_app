import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:lb_planner/modules/settings/settings.dart';
import 'package:lb_planner/gen/assets/assets.gen.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  FeedbackType dropdownValue = FeedbackType.values.first;
  TextEditingController messageController = TextEditingController();

  bool sendingFeedback = false;

  Future<void> _sendFeedback() async {
    //log('Sending user feedback.');

    if (sendingFeedback) {
      return;
    }

    sendingFeedback = true;

    final sentryFeedback = SentryFeedback(
      message: messageController.text,
      contactEmail: 'email@test.com',
      name: 'Max Mustermann',
    );

    try {
      final sentryId = await Sentry.captureFeedback(sentryFeedback);

      await Sentry.configureScope((scope) async {
        await scope.applyToEvent(SentryEvent(eventId: sentryId), Hint());
        await scope.setTag('feedback-type', dropdownValue.name);
      });

      messageController.clear();

      //log('User feedback sent successfully.');
    } catch (e, s) {
      rethrow;
      //log('Failed to send user feedback.');
    }

    sendingFeedback = false;
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
                        DropdownMenu(
                          initialSelection: dropdownValue,
                          enableFilter: false,
                          enableSearch: false,
                          dropdownMenuEntries: FeedbackType.values.map<DropdownMenuEntry<FeedbackType>>((type) {
                            return DropdownMenuEntry<FeedbackType>(
                              value: type,
                              label: type.langString,
                            );
                          }).toList(),
                          onSelected: (FeedbackType? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    Spacing.small(),
                    TextField(
                            maxLines: null,
                            expands: true,
                            controller: messageController,
                            decoration: InputDecoration.collapsed(hintText: "Please describe your problem."))
                        .expanded(),
                    TextButton(onPressed: _sendFeedback, child: Text('Submit')),
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

enum FeedbackType {
  bug(langString: 'Bug'),
  typo(langString: 'Typo'),
  feature(langString: 'Feature'),
  other(langString: 'Other');

  const FeedbackType({required this.langString});

  final String langString;
}
