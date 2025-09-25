// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/router_paths.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/repository/local/orientation_repo.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../../../shared/repository/remote/inspection_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../entry_inspection/controller/entry_inspection_controller.dart';
import '../../inspection/model/inspection_arguments_model.dart';

class VerifyVinController extends GetxController {
  VerifyVinController({required this.inspectionRepo, required this.orientationRepo});
  final InspectionRepo inspectionRepo;
  final OrientationRepo orientationRepo;

  // Camera variables
  List<CameraDescription> cameras = <CameraDescription>[];
  final Rxn<CameraController> cameraController = Rxn();
  final Rxn<File> vinImageFile = Rxn();
  final RxBool showInstruction = false.obs;
  late Directory appDir;

  @override
  void onInit() async {
    super.onInit();
    appDir = await getApplicationDocumentsDirectory();
  }

  @override
  void onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }

  Future<void> initializeCamera() async {
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

  void captureButtonOnTap() async {
    try {
      final xFile = await cameraController.value?.takePicture();
      if (xFile != null) {
        final String fileName = "${DateTime.now().toIso8601String()}.jpg";
        final File savedFile = await File(xFile.path).copy('${appDir.path}/$fileName');
        vinImageFile(File(savedFile.path));
        showInstruction(true);
      } else {
        showToast('Error capturing photo!');
      }
    } catch (e) {
      showToast('Error: $e');
    }
  }

  void resetCapturedFile() {
    showInstruction(false);
    vinImageFile.value = null;
  }

  int getCapturedCount() {
    return vinImageFile.value == null ? 0 : 1;
  }

  bool showCompleteButton() {
    return vinImageFile.value != null;
  }

  Future<void> nextButtonOnTap({
    required InspectionArgumentsModel? inspectionArgumentsModel,
    required AppLocalizations? locale,
  }) async {
    if (vinImageFile.value == null) {
      showToast('Please capture VIN image first');
      return;
    }

    // Showing analyzing VIN screen
    Get.toNamed(RouterPaths.analyzingVin, arguments: {ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel});
    orientationRepo.showStatusBar();
    orientationRepo.portraitOrientation();

    final String? extractedVin = await inspectionRepo.extractVin(filePath: vinImageFile.value!.path);

    if (extractedVin == inspectionArgumentsModel?.vin) {
      // VIN matched
      showDialog(
        barrierDismissible: false,
        context: Get.key.currentState!.context,
        builder: (_) => AppAlertDialog(
          hideSecondaryButton: true,
          iconData: Icons.check_circle_outline,
          title: '${locale?.vinMatched}',
          message: '${locale?.vinMatchedMsg}',
          primaryButtonText: '${locale?.continueStr}',
          buttonAction: () {
            // Logic for entry inspection
            if (inspectionArgumentsModel?.returnScreen == RouterPaths.entryInspection) {
              InspectionArgumentsModel? updatedInspectionArgumentsModel = inspectionArgumentsModel;

              final CaptureFileModel newCaptureFileModel =
                  (inspectionArgumentsModel?.captureFileModel ?? CaptureFileModel()).copyWith(
                    doorVINStickerImage: vinImageFile.value,
                  );

              updatedInspectionArgumentsModel = inspectionArgumentsModel?.copyWith(
                extractedVin: extractedVin,
                captureFileModel: newCaptureFileModel,
              );

              final EntryInspectionController entryInspectionController = Get.find();
              entryInspectionController.inspectionArgumentsModel = updatedInspectionArgumentsModel;
            }

            Get.until((route) => route.settings.name == inspectionArgumentsModel?.returnScreen);
          },
        ),
      );
    } else {
      showDialog(
        barrierDismissible: true,
        context: Get.key.currentState!.context,
        builder: (_) => AppAlertDialog(
          hideSecondaryButton: true,
          themeColor: AppColors.errorColor,
          iconData: Icons.block,
          title: '${locale?.vinNotMatched}',
          message: '${locale?.vinNotMatchedMsg}',
          primaryButtonText: '${locale?.continueStr}',
          buttonAction: () {
            resetCapturedFile();
            Get.back();
            Get.back();
            orientationRepo.hideStatusBar();
            orientationRepo.landscapeOrientation();
          },
        ),
      );
    }
  }
}
