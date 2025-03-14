import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// [DistributionType.msix] implementation of the [PatchService].
class MsixPatchService extends PatchService {
  final Dio _dio;

  /// [DistributionType.msix] implementation of the [PatchService].
  MsixPatchService(this._dio);

  @override
  Stream<double> applyPatch(Release release, Version currentVersion, ReleaseChannel currentChannel) async* {
    final dir = await Directory.systemTemp.createTemp();

    final file = File('${dir.path}/latest.msix');

    final controller = StreamController<double>();

    try {
      await _dio.download(
        release.downloads[Platform.windows]!,
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
    return (context) => context.t.app_update_download(release.downloads[Platform.windows]!);
  }
}
