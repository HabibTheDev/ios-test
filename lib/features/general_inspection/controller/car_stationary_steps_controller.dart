import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/router/router_paths.dart';
import '../../../shared/enums/enums.dart';
import '../model/car_stationary_step_model.dart';
import 'vehicle_performance_controller.dart';

class CarStationaryStepsController extends GetxController {
  final List<CarStationaryStepModel> carStationaryStepList = [];
  final PageController stepPageController = PageController();
  final RxInt currentPageIndex = 0.obs;
  final RxBool ableToGoNext = false.obs;

  late VehiclePerformanceController vehiclePerformanceController;

  @override
  void onInit() {
    vehiclePerformanceController = Get.find();
    carStationaryStepList.addAll(CarStationaryStepModel.carStationarySteps.map((e) => e.copy()).toList());

    // Clear the previous saved list
    vehiclePerformanceController.carStationaryStepList.clear();
    super.onInit();
  }

  @override
  void dispose() {
    stepPageController.dispose();
    carStationaryStepList.clear();
    super.dispose();
  }

  void onPageChange(int newValue) {
    currentPageIndex(newValue);
  }

  void nextButtonOnTap() {
    if (!ableToGoNext.value) return;

    final int targetIndex = currentPageIndex.value + 1;
    if (targetIndex < carStationaryStepList.length) {
      stepPageController.jumpToPage(targetIndex);
      checkAbleToGoNext();
    } else if ((currentPageIndex.value + 1) == (carStationaryStepList.length)) {
      // After completion of car stationary back to the Vehicle performance screen
      completeAllStepAction();
    }
  }

  void previousButtonOnTap() {
    final int targetIndex = currentPageIndex.value - 1;
    if (targetIndex >= 0) {
      stepPageController.jumpToPage(targetIndex);
      checkAbleToGoNext();
    }
  }

  void questionRadioOnChanged({required int stepIndex, required int quesIndex, required int? newRadioValue}) {
    carStationaryStepList[stepIndex].questions[quesIndex].answerRadioValue.value = newRadioValue ?? -1;
    checkAbleToGoNext();
  }

  void checkAbleToGoNext() {
    // Check if all questions are answered (none equal to -1)
    ableToGoNext.value =
        carStationaryStepList[currentPageIndex.value].questions.every((q) => q.answerRadioValue.value != -1);
  }

  void addImage({required int stepIndex, required File imageFile}) {
    final int insertedIndex = carStationaryStepList[stepIndex].images.length - 1;
    carStationaryStepList[stepIndex].images.insert(insertedIndex, imageFile);
  }

  void deleteSelectedImages({required stepIndex, required List<int> selectedIndex}) {
    selectedIndex.sort((a, b) => b.compareTo(a));
    for (int i in selectedIndex) {
      if (i >= 0 && i < carStationaryStepList[stepIndex].images.length) {
        carStationaryStepList[stepIndex].images.removeAt(i);
      }
    }
  }

  void completeAllStepAction() {
    // Save Stationary Steps
    vehiclePerformanceController.carStationaryStepList = carStationaryStepList;
    // Update completed Performance Test Type status
    final int index = vehiclePerformanceController.performanceTestTypeList
        .indexWhere((element) => element.type == VehiclePerformanceType.stationary);
    final updatablePerformanceTestType = vehiclePerformanceController.performanceTestTypeList[index];

    vehiclePerformanceController.performanceTestTypeList[index] =
        updatablePerformanceTestType.copyWith(status: StepStatus.complete);

    final nextPerformanceTestType = vehiclePerformanceController.performanceTestTypeList[index + 1];
    vehiclePerformanceController.performanceTestTypeList[index + 1] =
        nextPerformanceTestType.copyWith(status: StepStatus.awaiting);

    Get.until((route) => route.settings.name == RouterPaths.vehiclePerformance);
  }
}
