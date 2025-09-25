import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/api_endpoint.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/local/media_repo.dart';
import '../../../shared/repository/remote/inspection_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/enums/enums.dart';
import '../../entry_inspection/controller/entry_inspection_controller.dart';
import '../model/car_side_model.dart';
import '../model/inspection_arguments_model.dart';
import '../model/inspection_report_model.dart';
import '../model/inspection_type_model.dart';

class InspectionCaptureController extends GetxController {
  InspectionCaptureController({required this.inspectionRepo, required this.mediaRepo});
  final InspectionRepo inspectionRepo;
  final MediaRepo mediaRepo;

  // Variables
  final int totalExteriorCarSide = 4;
  final RxList<InspectionTypeModel> inspectionCaptureTypeList = <InspectionTypeModel>[].obs;
  final RxList<File> carExteriorImageFiles = <File>[].obs;
  final Rxn<File> licensePlateImageFile = Rxn();
  final Rxn<File> odometerImageFile = Rxn();
  final RxBool showInstruction = false.obs;
  final RxBool disableFinishButton = true.obs;
  final RxBool finishLoading = false.obs;

  String? damageResponse;

  // Capture variables
  List<CameraDescription> cameras = <CameraDescription>[];
  final Rxn<CameraController> cameraController = Rxn();
  final Rx<CarSideModel> currentSide = CarSideModel.carSides.first.obs;

  @override
  void onInit() async {
    inspectionCaptureTypeList.addAll(InspectionTypeModel.inspectionTypes);
    super.onInit();
  }

  @override
  onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }

  Future<void> init({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    cameras = await availableCameras();
    if (cameras.isEmpty) {
      showSnackbar(
        'Camera not found!',
        isError: true,
        margin: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
      );
      return;
    }
    cameraController.value = CameraController(cameras.first, ResolutionPreset.veryHigh, fps: 30, enableAudio: false);
    await cameraController.value?.initialize();

    update();
  }

  void nextButtonOnTap({required InspectionArgumentsModel? inspectionArgumentsModel}) {
    showInstruction(false);
    if (inspectionArgumentsModel?.returnScreen == RouterPaths.entryInspection) {
      if (inspectionArgumentsModel?.inspectionCaptureTypeEnum == InspectionCaptureTypeEnum.carExterior) {
        // Exterior Car
        if (carExteriorImageFiles.length != totalExteriorCarSide) {
          return;
        } else {
          inspectionCaptureTypeList[0] = inspectionCaptureTypeList[0].copyWith(status: StepStatus.complete);
          inspectionCaptureTypeList[1] = inspectionCaptureTypeList[1].copyWith(status: StepStatus.awaiting);
          goToCarExteriorReportScreen(inspectionArgumentsModel: inspectionArgumentsModel);
        }
      } else if (inspectionArgumentsModel?.inspectionCaptureTypeEnum == InspectionCaptureTypeEnum.licensePlate) {
        // License
        inspectionCaptureTypeList[1] = inspectionCaptureTypeList[1].copyWith(status: StepStatus.complete);
        inspectionCaptureTypeList[2] = inspectionCaptureTypeList[2].copyWith(status: StepStatus.awaiting);
        Get.until((route) => route.settings.name == RouterPaths.inspectionCaptureType);
      } else if (inspectionArgumentsModel?.inspectionCaptureTypeEnum == InspectionCaptureTypeEnum.odometer) {
        // Odometer
        inspectionCaptureTypeList[2] = inspectionCaptureTypeList[2].copyWith(status: StepStatus.complete);
        Get.until((route) => route.settings.name == RouterPaths.inspectionCaptureType);
      }
    } else {
      // Exterior Car
      if (carExteriorImageFiles.length != totalExteriorCarSide) {
        return;
      } else {
        cameraController.value?.pausePreview();

        Get.toNamed(
          RouterPaths.processingImage,
          arguments: {
            ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel?.copyWith(
              captureFileModel: CaptureFileModel(
                leftSideImage: carExteriorImageFiles[0],
                frontSideImage: carExteriorImageFiles[1],
                rightSideImage: carExteriorImageFiles[2],
                rearSideImage: carExteriorImageFiles[3],
              ),
            ),
          },
        );
      }
    }
  }

  void captureButtonOnTap({required InspectionCaptureTypeEnum? type}) async {
    try {
      final xFile = await cameraController.value?.takePicture();
      if (xFile != null) {
        final File? savedFile = await mediaRepo.saveFileToAppDirectory(file: File(xFile.path));
        if (savedFile == null) return;

        // Only for debugging purpose
        // getImageHeightWidth(savedFile);

        if (type == InspectionCaptureTypeEnum.carExterior) {
          if (carExteriorImageFiles.length < totalExteriorCarSide) {
            carExteriorImageFiles.add(File(savedFile.path));
          }
        } else if (type == InspectionCaptureTypeEnum.licensePlate) {
          licensePlateImageFile(File(savedFile.path));
        } else if (type == InspectionCaptureTypeEnum.odometer) {
          odometerImageFile(File(savedFile.path));
        }
        showInstruction(true);
      } else {
        showToast('Error capturing photo!');
      }
    } catch (e) {
      showToast('Error: $e');
    }
    checkDisableFinishButton();
  }

  void resetCapturedFile({required InspectionCaptureTypeEnum? type}) {
    showInstruction(false);
    if (type == InspectionCaptureTypeEnum.carExterior) {
      carExteriorImageFiles.value = [];
    } else if (type == InspectionCaptureTypeEnum.licensePlate) {
      licensePlateImageFile.value = null;
    } else if (type == InspectionCaptureTypeEnum.odometer) {
      odometerImageFile.value = null;
    }
    checkDisableFinishButton();
  }

  int getCapturedCount({required InspectionCaptureTypeEnum? type}) {
    if (type == InspectionCaptureTypeEnum.licensePlate) {
      return licensePlateImageFile.value == null ? 0 : 1;
    } else if (type == InspectionCaptureTypeEnum.odometer) {
      return odometerImageFile.value == null ? 0 : 1;
    } else {
      return 0;
    }
  }

  bool showExteriorSideChangeInstruction() =>
      showInstruction.value && carExteriorImageFiles.length < totalExteriorCarSide;

  bool showCompleteButton({required InspectionCaptureTypeEnum? type}) {
    if (type == InspectionCaptureTypeEnum.carExterior) {
      return carExteriorImageFiles.length == 4;
    } else if (type == InspectionCaptureTypeEnum.licensePlate) {
      return licensePlateImageFile.value != null;
    } else if (type == InspectionCaptureTypeEnum.odometer) {
      return odometerImageFile.value != null;
    } else {
      return false;
    }
  }

  void goToCarExteriorReportScreen({required InspectionArgumentsModel? inspectionArgumentsModel}) {
    cameraController.value?.pausePreview();
    damageResponse = null;
    Get.toNamed(
      RouterPaths.processingImage,
      arguments: {
        ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel?.copyWith(
          captureFileModel: CaptureFileModel(
            leftSideImage: carExteriorImageFiles[0],
            frontSideImage: carExteriorImageFiles[1],
            rightSideImage: carExteriorImageFiles[2],
            rearSideImage: carExteriorImageFiles[3],
          ),
        ),
      },
    );
  }

  void checkDisableFinishButton() {
    disableFinishButton.value =
        carExteriorImageFiles.isEmpty || licensePlateImageFile.value == null || odometerImageFile.value == null;
  }

  void recaptureExterior() {
    carExteriorImageFiles.clear();
    inspectionCaptureTypeList.first = inspectionCaptureTypeList.first.copyWith(status: StepStatus.awaiting);
    for (int i = 1; i < inspectionCaptureTypeList.length; i++) {
      inspectionCaptureTypeList[i] = inspectionCaptureTypeList[i].copyWith(status: StepStatus.incomplete);
    }
    checkDisableFinishButton();
    damageResponse = null;
    cameraController.value?.resumePreview();
    update();
  }

  Future<void> finishButtonOnTap({required InspectionArgumentsModel? inspectionArgumentsModel}) async {
    if (disableFinishButton()) {
      return;
    }
    if (finishLoading.value) {
      showToast('Another process running');
      return;
    }
    if (damageResponse == null) {
      showToast('Review damage first');
      return;
    }
    if (inspectionArgumentsModel?.carID == null) {
      showToast('Car not found');
      return;
    }
    if (inspectionArgumentsModel?.taskId == null) {
      showToast('Task not found');
      return;
    }
    if (inspectionArgumentsModel?.taskStepId == null) {
      showToast('Task step not found');
      return;
    }

    final Map<String, String> filePathsMap = {
      'licensePlateImage': licensePlateImageFile.value!.path,
      'odometerImage': odometerImageFile.value!.path,
    };

    final Map<String, dynamic> data = {
      "taskId": inspectionArgumentsModel?.taskId,
      "taskStepId": inspectionArgumentsModel?.taskStepId,
      "status": InspectionStateEnum.draft.value,
    };
    if (inspectionArgumentsModel?.contactID != null) {
      data.addEntries({"ContactId": inspectionArgumentsModel?.contactID}.entries);
    }

    String endPoint = '';
    if (inspectionArgumentsModel?.inspectionType == InspectionTypeEnum.entryInspection) {
      endPoint = ApiEndpoint.entryInspectionReport;
    } else if (inspectionArgumentsModel?.inspectionType == InspectionTypeEnum.generalInspection) {
      endPoint = ApiEndpoint.generalInspectionReport;
    } else if (inspectionArgumentsModel?.inspectionType == InspectionTypeEnum.departureInspection) {
      endPoint = ApiEndpoint.departureInspectionReport;
    } else if (inspectionArgumentsModel?.inspectionType == InspectionTypeEnum.returnInspection) {
      endPoint = ApiEndpoint.returnInspectionReport;
    } else if (inspectionArgumentsModel?.inspectionType == InspectionTypeEnum.maintenanceInspection) {
      endPoint = ApiEndpoint.maintenanceInspectionReport;
    } else {
      endPoint = ApiEndpoint.generalInspectionReport;
    }

    final String jsonPayload = jsonEncode(data);
    finishLoading(true);
    final InspectionReportModel? result = await inspectionRepo.putExteriorDamageReport(
      endPoint: endPoint,
      carID: inspectionArgumentsModel!.carID!,
      filePathsMap: filePathsMap,
      data: jsonPayload,
    );
    finishLoading(false);

    if (result == null) {
      showToast('Something went wrong! Please try again');
      return;
    }

    if (inspectionArgumentsModel.returnScreen == RouterPaths.entryInspection) {
      final EntryInspectionController entryInspectionController = Get.find();
      entryInspectionController.inspectionReportModel = result;
      Get.until((router) => router.settings.name == inspectionArgumentsModel.returnScreen);
    } else {
      // Get.until((router) => router.settings.name == inspectionArgumentsModel.returnScreen);
    }
  }
}
