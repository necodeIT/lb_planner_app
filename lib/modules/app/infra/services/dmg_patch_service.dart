import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// [DistributionType.dmg] implementation of the [PatchService].
class DmgPatchService extends PatchService {
  final Dio _dio;

  /// [DistributionType.dmg] implementation of the [PatchService].
  DmgPatchService(this._dio);

  @override
  Stream<double> applyPatch(Release release, Version currentVersion, ReleaseChannel currentChannel) async* {
    final dir = await Directory.systemTemp.createTemp();

    final file = File('${dir.path}/latest.msix');

    final controller = StreamController<double>();

    try {
      await _dio.download(
        release.downloads[Platform.macos]!,
        file.path,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            controller.add(received / total);
          }
        },
      );

      controller.add(1);

      await Process.start(file.path, []);
    } finally {
      await controller.close();
    }

    yield* controller.stream;
  }

  @override
  bool canApplyPatch(Release release, Version currentVersion, ReleaseChannel currentChannel) => true;

  @override
  Translator getManualInstructions(Release release, Version currentVersion, ReleaseChannel currentChannel) {
    return (context) => 'Download the [latest version](${release.downloads[Platform.macos]}) and install it.';
  }
}
