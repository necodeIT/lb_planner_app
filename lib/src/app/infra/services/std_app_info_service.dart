import 'package:eduplanner/config/version.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// Standard implementation of the [AppInfoService].
class StdAppInfoService extends AppInfoService {
  @override
  Future<ReleaseChannel> getCurrentReleaseChannel() async => kInstalledRelease.channel;

  @override
  Future<Version> getCurrentVersion() async => kInstalledRelease.version;
}
