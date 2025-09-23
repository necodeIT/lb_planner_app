/// Contains the config for `echidna_flutter`.
library lb_planner.configs.echidna;

/// The client key for the echidna server.
@Deprecated('Licensing has been removed for the time being')
const kEchidnaClientKey = String.fromEnvironment('ECHIDNA_CLIENT_KEY');

/// The client id for the echidna server.
@Deprecated('Licensing has been removed for the time being')
const kEchidnaClientID = int.fromEnvironment('ECHIDNA_CLIENT_ID');

/// The url to the echidna server.
@Deprecated('Licensing has been removed for the time being')
const kEchidnaHost = String.fromEnvironment('ECHIDNA_HOST');

/// The feature id for the calendar plan feature in echidna.
@Deprecated('Licensing has been removed for the time being')
const kCalendarPlanFeatureID = int.fromEnvironment('CALENDAR_PLAN_FEATURE_ID');
