import 'package:logging/logging.dart';
import 'package:posthog_dart/posthog_dart.dart';

/// Captures a posthog event.
Future<void> captureEvent(String eventName, {Map<String, Object>? properties}) async {
  final logger = Logger('Analytics.PostHog');

  try {
    logger.finest('Sending analytics event');

    await PostHog().capture(eventName: eventName, properties: properties);
    logger.finest('Analytics event sent successfully');
  } catch (e, s) {
    logger.finest('Failed to send analytics event', e, s);
  }
}
