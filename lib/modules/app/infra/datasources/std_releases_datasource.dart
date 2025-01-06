import 'dart:convert';

import 'package:lb_planner/config/endpoints.dart';
import 'package:mcquenji_core/mcquenji_core.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// Standard implementation of the [ReleasesDatasource].
class StdReleasesDatasource extends ReleasesDatasource {
  final NetworkService _networkService;

  /// Standard implementation of the [ReleasesDatasource].
  StdReleasesDatasource(this._networkService);

  @override
  Future<Release> getLatestRelease(ReleaseChannel channel) async {
    final response = await _networkService.get(
      '$kLBPlannerWebsiteAdress/releases/latest',
    );

    response.raiseForStatusCode();

    final json = jsonDecode(response.body) as Map<String, dynamic>;

    return Release.fromJson(json);
  }

  @override
  Future<Map<ReleaseChannel, Release>> getReleases() async {
    final latestRelease = await getLatestRelease(ReleaseChannel.stable);

    return {
      latestRelease.channel: latestRelease,
    };
  }
}
