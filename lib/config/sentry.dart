/// Configuration for [Sentry](https://sentry.io/).
library lb_planner.config.sentry;

/// The DSN for Sentry.
///
/// Read from environment variable `SENTRY_DSN` at compile time.
const kSentryDSN = String.fromEnvironment('SENTRY_DSN');
