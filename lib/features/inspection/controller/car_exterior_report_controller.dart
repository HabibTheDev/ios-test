import 'dart:convert';

import 'package:get/get.dart';

import '../../../core/constants/api_endpoint.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/enums/enums.dart';
import '../../../shared/repository/remote/inspection_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../model/inspection_arguments_model.dart';
import '../model/inspection_report_model.dart';
import 'inspection_capture_controller.dart';

class CarExteriorReportController extends GetxController {
  CarExteriorReportController({required this.inspectionRepo});
  final InspectionRepo inspectionRepo;

  final RxBool isLoading = false.obs;
  final RxBool functionLoading = false.obs;
  final Rxn<InspectionReportModel> inspectionReportModel = Rxn();

  bool deletedDamageFromDamageCustomization = false;

  Future<void> putExteriorDamageReport({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (inspectionArgumentsModel == null) {
      showToast('Inspection arguments not found');
      return;
    }
    final CaptureFileModel? captureFileModel = inspectionArgumentsModel.captureFileModel;

    if (inspectionArgumentsModel.carID == null) {
      showToast('Car not found');
      return;
    }
    if (inspectionArgumentsModel.taskId == null) {
      showToast('Task not found');
      return;
    }
    if (inspectionArgumentsModel.taskStepId == null) {
      showToast('Task step not found');
      return;
    }

    if (inspectionArgumentsModel.damageResponse == null) {
      showToast('AI damages not found');
      return;
    }

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
      'rightSideImage': captureFileModel.rightSideImage!.path,
      'rearSideImage': captureFileModel.rearSideImage!.path,
    };

    final Map<String, dynamic> data = {
      "taskId": inspectionArgumentsModel.taskId,
      "taskStepId": inspectionArgumentsModel.taskStepId,
      "status": InspectionStateEnum.draft.value,
      "resultsFromAi": jsonDecode(inspectionArgumentsModel.damageResponse!),
    };
    if (inspectionArgumentsModel.contactID != null) {
      data.addEntries({"ContactId": inspectionArgumentsModel.contactID}.entries);
    }

    String endPoint = '';
    if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.entryInspection) {
      endPoint = ApiEndpoint.entryInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.generalInspection) {
      endPoint = ApiEndpoint.generalInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.departureInspection) {
      endPoint = ApiEndpoint.departureInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.returnInspection) {
      endPoint = ApiEndpoint.returnInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.maintenanceInspection) {
      endPoint = ApiEndpoint.maintenanceInspectionReport;
    } else {
      showToast('Invalid operation!');
      return;
    }

    isLoading(true);
    final String jsonPayload = jsonEncode(data);
    final result = await inspectionRepo.putExteriorDamageReport(
      endPoint: endPoint,
      carID: inspectionArgumentsModel.carID!,
      filePathsMap: filePathsMap,
      data: jsonPayload,
    );

    if (result != null) inspectionReportModel.value = result;
    isLoading(false);
  }

  Future<void> fetchExteriorInspectionReport({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (inspectionArgumentsModel == null || inspectionArgumentsModel.carID == null) {
      showToast('Car not found');
      return;
    }

    String endPoint = '';
    if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.entryInspection) {
      endPoint = ApiEndpoint.getEntryInspection;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.generalInspection) {
      endPoint = ApiEndpoint.generalInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.departureInspection) {
      endPoint = ApiEndpoint.departureInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.returnInspection) {
      endPoint = ApiEndpoint.returnInspectionReport;
    } else if (inspectionArgumentsModel.inspectionType == InspectionTypeEnum.maintenanceInspection) {
      endPoint = ApiEndpoint.maintenanceInspectionReport;
    } else {
      showToast('Invalid operation!');
      return;
    }

    isLoading(true);
    final result = await inspectionRepo.getExteriorInspectionReport(
      endPoint: endPoint,
      carID: inspectionArgumentsModel.carID!,
      inspectionStatus: InspectionStateEnum.draft.value,
    );

    if (result != null) inspectionReportModel.value = result;
    isLoading(false);
  }

  Future<void> recaptureButtonOnTap() async {
    final InspectionCaptureController controller = Get.find();
    controller.recaptureExterior();
    Get.until((route) => route.settings.name == RouterPaths.carExteriorInstruction);
  }

  Future<void> finishButtonOnTap({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (inspectionArgumentsModel?.damageResponse == null) {
      showToast('Damage not found');
      return;
    }
    if (inspectionArgumentsModel?.returnScreen == RouterPaths.entryInspection) {
      final InspectionCaptureController inspectionCaptureController = Get.find();
      inspectionCaptureController.damageResponse = inspectionArgumentsModel?.damageResponse;
      Get.until((route) => route.settings.name == RouterPaths.inspectionCaptureType);
    } else {
      // Get.until((route) => route.settings.name == inspectionArgumentsModel?.returnScreen);
    }
  }
}
