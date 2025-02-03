import 'package:posthog_dart/posthog_dart.dart';

/// Captures a posthog event.
Future<void> captureEvent(String eventName, {Map<String, Object>? properties}) {
  return PostHog().capture(eventName: eventName, properties: properties);
}
