import 'package:get/get.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/remote/inspection_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../model/inspection_arguments_model.dart';

class ProcessingImageController extends GetxController {
  ProcessingImageController({required this.inspectionRepo});
  final InspectionRepo inspectionRepo;

  Future<void> detectDamage({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    final CaptureFileModel? captureFileModel = inspectionArgumentsModel?.captureFileModel;

    if (captureFileModel == null ||
        captureFileModel.leftSideImage == null ||
        captureFileModel.frontSideImage == null ||
        captureFileModel.rightSideImage == null ||
        captureFileModel.rearSideImage == null) {
      showToast('Car images not found.');
      return;
    }

    final Map<String, String> filePathsMap = {
      'leftSideImage': captureFileModel.leftSideImage!.path,
      'rightSideImage': captureFileModel.rightSideImage!.path,
      'frontSideImage': captureFileModel.frontSideImage!.path,
      'rearSideImage': captureFileModel.rearSideImage!.path,
    };

    final String? damageResponse = await inspectionRepo.detectDamage(filePathsMap: filePathsMap);

    if (damageResponse == null) {
      showToast('Unexpected error! Please try again');
      Get.until((route) => route.settings.name == inspectionArgumentsModel?.returnScreen);
    } else {
      Get.toNamed(
        RouterPaths.carExteriorReport,
        arguments: {
          ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel?.copyWith(damageResponse: damageResponse),
        },
      );
    }
  }
}
