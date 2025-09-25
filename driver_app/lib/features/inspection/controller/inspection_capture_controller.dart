import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/utils/app_toast.dart';
import '../model/car_side_model.dart';

class InspectionCaptureController extends GetxController {
  // Variables
  final int totalExteriorCarSide = 4;
  final RxList<File> carExteriorImageFiles = <File>[].obs;
  final RxBool showInstruction = false.obs;

  // Capture variables
  List<CameraDescription> cameras = <CameraDescription>[];
  final Rxn<CameraController> cameraController = Rxn();
  Rx<CarSideModel> currentSide = CarSideModel.carSides.first.obs;

  @override
  onClose() {
    cameraController.value?.dispose();
    super.onClose();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras.isEmpty) {
      // showToast('Camera not found!');
      showSnackbar(
        'Camera not found!',
        isError: true,
        margin: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
      );
      return;
    }
    cameraController.value = CameraController(
      cameras.first,
      ResolutionPreset.veryHigh,
      fps: 30,
      enableAudio: false,
    );
    await cameraController.value?.initialize();
    update();
  }

  void nextButtonOnTap({required String screenTitle, required String issueTitle, required String returnScreen}) {
    showInstruction(false);
    // Exterior Car
    if (carExteriorImageFiles.length != totalExteriorCarSide) {
      return;
    } else {
      Get.toNamed(
        RouterPaths.processingImage,
        arguments: {
          ArgumentsKey.title: screenTitle,
          ArgumentsKey.issueTitle: issueTitle,
          ArgumentsKey.returnScreen: returnScreen,
        },
      );
    }
  }

  void captureButtonOnTap() async {
    try {
      final xFile = await cameraController.value?.takePicture();
      if (xFile != null) {
        if (carExteriorImageFiles.length < totalExteriorCarSide) {
          carExteriorImageFiles.add(File(xFile.path));
        }
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
    carExteriorImageFiles.value = [];
  }

  bool showExteriorSideChangeInstruction() =>
      showInstruction.value && carExteriorImageFiles.length < totalExteriorCarSide;

  bool showCompleteButton() {
    return carExteriorImageFiles.length == 4;
  }
}
