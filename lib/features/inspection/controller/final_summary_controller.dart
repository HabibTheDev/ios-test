import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/constants/api_endpoint.dart';
import '../../../shared/repository/remote/inspection_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/enums/enums.dart';
import '../model/inspection_arguments_model.dart';
import '../model/inspection_report_model.dart';

class FinalSummaryController extends GetxController {
  FinalSummaryController({required this.inspectionRepo});
  final InspectionRepo inspectionRepo;

  final RxBool isLoading = false.obs;

  final RxBool functionLoading = false.obs;
  final Rxn<InspectionReportModel> inspectionReportModel = Rxn();

  Future<void> fetchFinalSummary({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (inspectionArgumentsModel?.carID == null) {
      showToast('Car ID not found');
      return;
    }
    if (inspectionArgumentsModel?.contactID == null) {
      showToast('Contract ID not found');
      return;
    }
    isLoading(true);
    final result = await inspectionRepo.getFinalReport(
      carID: inspectionArgumentsModel!.carID!,
      contractID: inspectionArgumentsModel.contactID!,
    );
    isLoading(false);
    if (result != null) inspectionReportModel.value = result;
  }

  Future<void> finishInspection({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (inspectionArgumentsModel?.carID == null) {
      showToast('Car ID not found');
      return;
    }
    if (inspectionArgumentsModel?.taskId == null) {
      showToast('Task ID not found');
      return;
    }
    if (inspectionArgumentsModel?.taskStepId == null) {
      showToast('Task step ID not found');
      return;
    }

    final CaptureFileModel? captureFileModel = inspectionArgumentsModel?.captureFileModel!;

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
      'frontSideImage': captureFileModel.frontSideImage!.path,
      'rightSideImage': captureFileModel.rearSideImage!.path,
      'rearSideImage': captureFileModel.rearSideImage!.path,
    };

    final data = {
      "taskId": inspectionArgumentsModel?.taskId,
      "taskStepId": inspectionArgumentsModel?.taskStepId,
      "status": InspectionStateEnum.completed.value,
      "resultsFromAi": jsonDecode(inspectionArgumentsModel?.damageResponse ?? ""),
    };
    if (inspectionArgumentsModel?.contactID != null) {
      data.addEntries({"ContactId": inspectionArgumentsModel?.contactID}.entries);
    }
    functionLoading(true);
    final result = await inspectionRepo.putExteriorDamageReport(
      endPoint: ApiEndpoint.returnInspectionReport,
      carID: inspectionArgumentsModel!.carID!,
      filePathsMap: filePathsMap,
      data: jsonEncode(data),
    );
    functionLoading(false);
    if (result != null) {
      showToast('Success');
      Get.until((route) => route.settings.name == inspectionArgumentsModel.returnScreen);
    }
  }
}
