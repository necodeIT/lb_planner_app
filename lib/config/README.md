# Config

This folder contains configuration files for the app. These files define various constants and configurations that can be customized at compile-time using Dart's compile-time variables feature (`--dart-define`).

## Endpoints

- **`kMoodleServerAddress`**
  - **Description**: The URL of the Moodle server where the app sends requests.
  - **Default Value**: `http://localhost:6000`
  - **Usage**: This value is set using the compile-time variable `MOODLE_ENDPOINT`. To set this variable, use the `--dart-define` flag when building the app:

    ```bash
    flutter build [os] --dart-define=MOODLE_ENDPOINT=VALUE
    ```

- **`kLBPlannerWebsiteAddress`**
  - **Description**: The URL of the LB Planner website, used for accessing the public API to retrieve metadata without authentication.
  - **Default Value**: `http://localhost:6008`
  - **Usage**: This value is set using the compile-time variable `LB_PLANNER_ENDPOINT`. To set this variable, use the `--dart-define` flag when building the app:

    ```bash
    flutter build [os] --dart-define=LB_PLANNER_ENDPOINT=VALUE
    ```

- **`kRefreshInterval`**
  - **Description**: The interval (in milliseconds) at which the app refreshes data from the server.
  - **Default Value**: `10000` (10 seconds)
  - **Usage**: This value can be customized at compile-time using the `REFRESH_INTERVAL` environment variable:

    ```bash
    flutter build [os] --dart-define=REFRESH_INTERVAL=VALUE
    ```

## Usage

When building your Flutter app, you can customize these configurations by defining the necessary variables using the `--dart-define` option. This allows you to tailor the app's behavior for different environments or requirements.

```bash
flutter build apk --dart-define=MOODLE_ENDPOINT=https://your-moodle-server.com --dart-define=LB_PLANNER_ENDPOINT=https://your-lb-planner.com --dart-define=REFRESH_INTERVAL=15000
```

or for development:

```bash
flutter run --dart-define=MOODLE_ENDPOINT=https://your-moodle-server.com --dart-define=LB_PLANNER_ENDPOINT=https://your-lb-planner.com --dart-define=REFRESH_INTERVAL=15000
```

If you have [mockoon](../../test/mockoon/README.md) running on your machine you don't need to change the endpoints as they are already set to the mockoon server.
