library lb_planner.config.version;

import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// The name off the app.
///
/// Read from environment variable `APP_NAME` at compile time.
const kAppName = String.fromEnvironment('APP_NAME', defaultValue: 'LB Planner');

const _majorVersion = int.fromEnvironment('MAJOR_VERSION');
const _minorVersion = int.fromEnvironment('MINOR_VERSION');
const _patchVersion = int.fromEnvironment('PATCH_VERSION');
const _buildNumber = int.fromEnvironment('BUILD_NUMBER');

const _releaseChannelString = String.fromEnvironment('BUILD_CHANNEL', defaultValue: 'canary');
final _releaseChannel = ReleaseChannel.values.byName(_releaseChannelString);

const _kReleaseDateString = String.fromEnvironment('RELEASE_DATE');
final _releaseDate = _kReleaseDateString.isNotEmpty ? DateTime.parse(_kReleaseDateString) : DateTime.now();

const _patchNotes = String.fromEnvironment('PATCH_NOTES');

/// The current release of the application.
///
/// This value is read from the following compile-time variables:
/// - `MAJOR_VERSION`: int
/// - `MINOR_VERSION`: int
/// - `PATCH_VERSION`: int
/// - `BUILD_NUMBER`: int
/// - `PATCH_NOTES`: String (Markdown)
/// - `RELEASE_DATE`: String (ISO 8601)
/// - `BUILD_CHANNEL`: String
///   - `canary`
///   - `dev`
///   - `beta`
///   - `stable`
final kInstalledRelease = Release(
  // These calues are set at compile-time.
  // ignore: use_named_constants
  version: const Version(
    major: _majorVersion,
    minor: _minorVersion,
    patch: _patchVersion,
    // This value is set at compile time.
    // ignore: avoid_redundant_argument_values
    build: _buildNumber,
  ),
  // This value is set at compile time.
  // ignore: avoid_redundant_argument_values
  patchNotes: _patchNotes,
  channel: _releaseChannel,
  releaseDate: _releaseDate,
);
