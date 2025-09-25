import 'package:get/get.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/utils/enums.dart';
import '../model/issue_model.dart';

class IssueSelectionController extends GetxController {
  final Rxn<IssueModel> selectedIssue = Rxn();

  // UI functions
  void changeIssue(IssueModel model) {
    selectedIssue(model);
  }

  void nextButtonOnTap() {
    final issueTitle = selectedIssue.value?.issue;
    final issueType = selectedIssue.value?.issueType;
    if (issueType == null) {
      showToast('Select an issue');
      return;
    }
    if (issueType == ReportIssueType.damageOrBroken ||
        issueType == ReportIssueType.weatherDamage ||
        issueType == ReportIssueType.none) {
      Get.toNamed(RouterPaths.basicInquirySelection, arguments: {ArgumentsKey.issueTitle: issueTitle});
    } else if (issueType == ReportIssueType.theftOrVandalism) {
      Get.toNamed(RouterPaths.theftVandalismSelection, arguments: {ArgumentsKey.issueTitle: issueTitle});
    } else if (issueType == ReportIssueType.vehicleHit || issueType == ReportIssueType.collidedOrFell) {
      Get.toNamed(RouterPaths.vehicleHitCollidedSelection, arguments: {
        ArgumentsKey.issueTitle: issueTitle,
        ArgumentsKey.issueType:
            issueType == ReportIssueType.vehicleHit ? 'What did the vehicle hit?' : 'What collided with the vehicle?'
      });
    }
  }
}
