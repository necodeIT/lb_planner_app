import 'package:lb_planner/config/version.dart';
import 'package:lb_planner/modules/app/app.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// [DistributionType.appImage] implementation of the [PatchService].
class AppImagePatchService extends PatchService {
  @override
  Stream<double> applyPatch(Release release, Version currentVersion, ReleaseChannel currentChannel) {
    throw ManualInstallRequiredException(getManualInstructions(release, currentVersion, currentChannel));
  }

  @override
  bool canApplyPatch(Release release, Version currentVersion, ReleaseChannel currentChannel) => false;

  @override
  Translator getManualInstructions(Release release, Version currentVersion, ReleaseChannel currentChannel) {
    return (context) => 'Download the [latest version](${release.downloads[Platform.linux]}) and replace the current version with the new one.';
  }
}
