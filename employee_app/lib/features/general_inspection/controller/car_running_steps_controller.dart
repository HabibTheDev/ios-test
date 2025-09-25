import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/router/router_paths.dart';
import '../../../shared/enums/enums.dart';
import '../model/car_running_step_model.dart';
import 'vehicle_performance_controller.dart';

class CarRunningStepsController extends GetxController {
  final List<CarRunningStepModel> carRunningStepList = [];
  final PageController stepPageController = PageController();
  final RxInt currentPageIndex = 0.obs;
  final RxBool ableToGoNext = false.obs;

  late VehiclePerformanceController vehiclePerformanceController;

  @override
  void onInit() {
    vehiclePerformanceController = Get.find();
    carRunningStepList.addAll(CarRunningStepModel.carRunningSteps.map((e) => e.copy()).toList());

    // Clear the previous saved list
    vehiclePerformanceController.carRunningStepList.clear();

    checkAbleToGoNext();
    super.onInit();
  }

  @override
  void dispose() {
    stepPageController.dispose();
    carRunningStepList.clear();
    super.dispose();
  }

  void onPageChange(int newValue) {
    currentPageIndex(newValue);
  }

  void nextButtonOnTap() {
    if (!ableToGoNext.value) return;

    final int targetIndex = currentPageIndex.value + 1;
    if (targetIndex < carRunningStepList.length) {
      stepPageController.jumpToPage(targetIndex);
      checkAbleToGoNext();
    } else if ((currentPageIndex.value + 1) == (carRunningStepList.length)) {
      // After completion of car stationary back to the Vehicle performance screen
      completeAllStepAction();
    }
  }

  void questionRadioOnChanged({required int stepIndex, required int quesIndex, required int? newRadioValue}) {
    carRunningStepList[stepIndex].questions[quesIndex].answerRadioValue.value = newRadioValue ?? -1;
    checkAbleToGoNext();
  }

  void checkAbleToGoNext() {
    // Check if all questions are answered (none equal to -1)
    if (carRunningStepList[currentPageIndex.value].questions.isNotEmpty) {
      ableToGoNext.value =
          carRunningStepList[currentPageIndex.value].questions.every((q) => q.answerRadioValue.value != -1);
    } else {
      ableToGoNext.value = true;
    }
  }

  void addImage({required int stepIndex, required File imageFile}) {
    final int insertedIndex = carRunningStepList[stepIndex].images.length - 1;
    carRunningStepList[stepIndex].images.insert(insertedIndex, imageFile);
  }

  void deleteSelectedImages({required stepIndex, required List<int> selectedIndex}) {
    selectedIndex.sort((a, b) => b.compareTo(a));
    for (int i in selectedIndex) {
      if (i >= 0 && i < carRunningStepList[stepIndex].images.length) {
        carRunningStepList[stepIndex].images.removeAt(i);
      }
    }
  }

  void completeAllStepAction() {
    // Save Stationary Steps
    vehiclePerformanceController.carRunningStepList = carRunningStepList;
    // Update completed Performance Test Type status
    final int index = vehiclePerformanceController.performanceTestTypeList
        .indexWhere((element) => element.type == VehiclePerformanceType.running);
    final updatablePerformanceTestType = vehiclePerformanceController.performanceTestTypeList[index];

    vehiclePerformanceController.performanceTestTypeList[index] =
        updatablePerformanceTestType.copyWith(status: StepStatus.complete);

    Get.until((route) => route.settings.name == RouterPaths.vehiclePerformance);
  }
}
