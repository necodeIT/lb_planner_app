import 'package:eduplanner/config/version.dart';
import 'package:eduplanner/src/app/app.dart';
import 'package:mcquenji_versioning/mcquenji_versioning.dart';

/// [DistributionType.aur] implementation of the [PatchService].
class AurPatchService extends PatchService {
  @override
  Stream<double> applyPatch(Release release, Version currentVersion, ReleaseChannel currentChannel) {
    throw ManualInstallRequiredException(getManualInstructions(release, currentVersion, currentChannel));
  }

  @override
  bool canApplyPatch(Release release, Version currentVersion, ReleaseChannel currentChannel) => false;

  @override
  Translator getManualInstructions(Release release, Version currentVersion, ReleaseChannel currentChannel) {
    return (context) => 'Run `yay -S lb-planner` to update to the latest version.';
  }
}
