import 'dart:io';

import 'package:get/get.dart';

import '../model/inspection_result_model.dart';

class InspectionResultsController extends GetxController {
  final List<InspectionResultModel> inspectionResultList = <InspectionResultModel>[];

  @override
  void onInit() {
    inspectionResultList.addAll(InspectionResultModel.steps.map((e) => e.copy()).toList());

    super.onInit();
  }

  void questionRadioOnChanged({required int stepIndex, required int? newRadioValue}) {
    inspectionResultList[stepIndex].answerRadioValue.value = newRadioValue ?? -1;
  }

  void addImage({required int stepIndex, required File imageFile}) {
    final int insertedIndex = inspectionResultList[stepIndex].images.length - 1;
    inspectionResultList[stepIndex].images.insert(insertedIndex, imageFile);
  }

  void deleteSelectedImages({required stepIndex, required List<int> selectedIndex}) {
    selectedIndex.sort((a, b) => b.compareTo(a));
    for (int i in selectedIndex) {
      if (i >= 0 && i < inspectionResultList[stepIndex].images.length) {
        inspectionResultList[stepIndex].images.removeAt(i);
      }
    }
  }
}
