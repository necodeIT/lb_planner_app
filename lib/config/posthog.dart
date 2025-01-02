/// API key used to authenticate with PostHog.
const kPostHogAPIkey = String.fromEnvironment('POSTHOG_API_KEY');

/// Host of the PostHog instance (e.g. https://app.posthog.com).
const kPostHogHost = String.fromEnvironment('POSTHOG_HOST');

/// URL of the privacy policy.
final kPrivacyPolicyUrl = Uri.parse(const String.fromEnvironment('PRIVACY_POLICY_URL', defaultValue: 'example.com'));
