import 'package:flutter_modular/flutter_modular.dart';
import 'package:posthog_dart/posthog_dart.dart';

/// Captures a posthog event.
Future<void> captureEvent(String eventName, {Map<String, Object>? properties}) {
  final posthog = Modular.get<PostHog>();

  return posthog.capture(eventName: eventName, properties: properties);
}
