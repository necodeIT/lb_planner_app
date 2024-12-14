/// Contains configs for all endpoints used by the app.
library lb_planner.configs.endpoints;

/// The url of the moodle server.
///
/// This detrmines where the app will send requests to.
///
/// This value is read from the compile-time variable `MOODLE_ENDPOINT` and defaults to `localhost:8080`.
///
/// In order to set the variable use `--dart-define` when building the app:
///
/// ```bash
/// flutter build [os] --dart-define=MOODLE_ENDPOINT=`VALUE`
/// ```
const kMoodleServerAdress = String.fromEnvironment('MOODLE_ENDPOINT', defaultValue: 'http://localhost:6000');

/// The url of the LB Planner website.
///
/// This is used to use the public API of the LB Planner which does not require authentication for retrieving metadata.
///
/// This value is read from the compile-time variable `LB_PLANNER_ENDPOINT` and defaults to `localhost:8081`.
///
/// In order to set the variable use `--dart-define` when building the app:
///
/// ```bash
/// flutter build [os] --dart-define=LB_PLANNER_ENDPOINT=`VALUE`
/// ```
const kLBPlannerWebsiteAdress = String.fromEnvironment('LB_PLANNER_ENDPOINT', defaultValue: 'http://localhost:6008');

/// The interval in milliseconds to refresh data from the server at.
const kRefreshInterval = int.fromEnvironment('REFRESH_INTERVAL', defaultValue: 10000);

/// The interval to refresh data from the server at.
///
/// Based on [kRefreshInterval].
const kRefreshIntervalDuration = Duration(milliseconds: kRefreshInterval);

/// The interval in milliseconds to refresh data that needs to be updated more often at.
const kImportantRefreshInterval = int.fromEnvironment('IMPORTANT_REFRESH_INTERVAL', defaultValue: 500);

/// The interval to refresh data that needs to be updated more often.
///
/// Based on [kImportantRefreshInterval].
const kImportantRefreshIntervalDuration = Duration(milliseconds: kImportantRefreshInterval);

/// The interval in milliseconds to refresh data that needs to be updated less often at.
const kLessImportantRefreshInterval = int.fromEnvironment('LESS_IMPORTANT_REFRESH_INTERVAL', defaultValue: 300000);

/// The interval to refresh data that needs to be updated less often.
///
/// Based on [kLessImportantRefreshInterval].
const kLessImportantRefreshIntervalDuration = Duration(milliseconds: kLessImportantRefreshInterval);
