import 'package:flutter/material.dart' show showDialog, Icons;
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/remote/damage_customization_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../model/damage_customization_model.dart';
import '../model/inspection_report_model.dart';
import 'car_exterior_report_controller.dart';

class DamageCustomizationController extends GetxController {
  DamageCustomizationController({required this.damageCustomizationRepo});
  final DamageCustomizationRepo damageCustomizationRepo;

  final CarExteriorReportController carExteriorReportController = Get.find();

  final RxBool isLoading = false.obs;
  final RxList<DamageCustomizationModel> newDamageList = <DamageCustomizationModel>[].obs;
  final RxList<DamageCustomizationModel> existingDamageList = <DamageCustomizationModel>[].obs;
  final List<DamageCustomizationModel> existingUnchangedDamageList = [];

  final RxBool isAddedNewDamage = false.obs;
  final RxBool isUpdatedCurrentDamage = false.obs;

  // Existing damage function
  void mapExistingDamageList({
    required String? reportOverviewId,
    required int? carId,
    required List<PartAreaList>? partAreaList,
  }) {
    if (partAreaList != null && partAreaList.isNotEmpty) {
      for (var element in partAreaList) {
        DamageCustomizationModel model = DamageCustomizationModel();
        model.id = element.id;
        model.inspectionReportId = reportOverviewId;
        model.carId = carId;
        model.part = element.part;
        model.partName = element.partName;
        model.partArea = element.area;
        model.type.value = element.type;
        model.count = element.count;
        model.severity.value = element.severity;
        model.recommendation.value = element.recommendation;
        model.image = element.image;
        model.imagePath.value = null;
        existingDamageList.add(model);
      }
      existingUnchangedDamageList.addAll(existingDamageList);
    }
  }

  void changeExistingDamageType({required int index, required String? newValue}) {
    final updatedModel = existingDamageList[index].copyWith(type: newValue);
    existingDamageList[index] = updatedModel;
    checkIfAbleToUpdate();
  }

  void changeExistingDamageSeverity({required int index, required String? newValue}) {
    final updatedModel = existingDamageList[index].copyWith(severity: newValue);
    existingDamageList[index] = updatedModel;
    checkIfAbleToUpdate();
  }

  void changeExistingRecommendation({required int index, required String? newValue}) {
    final updatedModel = existingDamageList[index].copyWith(recommendation: newValue);
    existingDamageList[index] = updatedModel;
    checkIfAbleToUpdate();
  }

  void changeExistingDamageImage({required int index, required String? newValue}) {
    final updatedModel = existingDamageList[index].copyWith(imagePath: newValue);
    existingDamageList[index] = updatedModel;
    checkIfAbleToUpdate();
  }

  void deleteExistingDamageImagePath({required int index}) {
    final updatedModel = existingDamageList[index].copyWith(imagePath: '');
    existingDamageList[index] = updatedModel;
    checkIfAbleToUpdate();
  }

  Future<void> deleteExistingDamage({required int index, required AppLocalizations? locale}) async {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.delete,
        title: '${locale?.areYouSure}',
        message: '${locale?.deleteMessage}',
        primaryButtonText: '${locale?.ok}',
        themeColor: AppColors.errorColor,
        buttonAction: () async {
          Get.back();
          isLoading(true);
          final bool result = await damageCustomizationRepo.deleteCurrentDamage(id: existingDamageList[index].id);
          if (result == true) {
            existingDamageList.removeAt(index);
            existingUnchangedDamageList.removeAt(index);
            checkIfAbleToUpdate();
            carExteriorReportController.deletedDamageFromDamageCustomization = true;
          }
          isLoading(false);
        },
      ),
    );
  }

  // New damage function
  void addNewDamage({required String? reportOverviewId, required int? carId, required String? part}) {
    newDamageList.add(
      DamageCustomizationModel(inspectionReportId: reportOverviewId, carId: carId, part: part, count: 1),
    );
    checkIfAbleToUpdate();
  }

  void changeNewDamageType({required int index, required String? newValue}) {
    final updatedModel = newDamageList[index].copyWith(type: newValue);
    newDamageList[index] = updatedModel;
  }

  void changeNewDamageSeverity({required int index, required String? newValue}) {
    final updatedModel = newDamageList[index].copyWith(severity: newValue);
    newDamageList[index] = updatedModel;
  }

  void changeNewRecommendation({required int index, required String? newValue}) {
    final updatedModel = newDamageList[index].copyWith(recommendation: newValue);
    newDamageList[index] = updatedModel;
  }

  void changeNewDamageImage({required int index, required String? newValue}) {
    final updatedModel = newDamageList[index].copyWith(imagePath: newValue);
    newDamageList[index] = updatedModel;
  }

  void deleteNewDamage({required int index}) {
    newDamageList.removeAt(index);
    checkIfAbleToUpdate();
  }

  void checkIfAbleToUpdate() {
    // Condition 1: If newDamageList has data
    if (newDamageList.isNotEmpty) {
      isAddedNewDamage.value = true;
      return;
    }
    // Condition 2: If any data changed in existingDamageList
    for (int i = 0; i < existingDamageList.length; i++) {
      if (i >= existingUnchangedDamageList.length) {
        isUpdatedCurrentDamage.value = true;
        return;
      }

      final current = existingDamageList[i];
      final original = existingUnchangedDamageList[i];

      if (current.imagePath.value == '') {
        current.imagePath.value = null;
      }

      if (current.type.value != original.type.value ||
          current.severity.value != original.severity.value ||
          current.recommendation.value != original.recommendation.value ||
          current.imagePath.value != original.imagePath.value) {
        isUpdatedCurrentDamage.value = true;
        return;
      }
    }
    // If no changes detected
    isAddedNewDamage.value = false;
    isUpdatedCurrentDamage.value = false;
  }

  Future<void> updateButtonOnTap(AppLocalizations? locale) async {
    if (isLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }

    // Check if there are any operations to perform
    if (!isAddedNewDamage.value && !isUpdatedCurrentDamage.value) {
      Get.back(result: false);
      return;
    }

    bool allOperationsSuccessful = true;
    isLoading(true);

    try {
      // Save new damages
      if (isAddedNewDamage.value == true) {
        // Validate all new damages first
        for (var e in newDamageList) {
          if (e.inspectionReportId == null ||
              e.carId == null ||
              e.type.value == null ||
              e.severity.value == null ||
              e.count == null ||
              e.recommendation.value == null ||
              e.part == null ||
              e.imagePath.value == null) {
            showToast('${locale?.missingDamageDataMsg}');
            isLoading(false);
            return;
          }
        }

        // Build payloads for new damages
        final List<Map<String, dynamic>> newDamagePayloads = [];
        final List<String?> newDamageFilePaths = [];
        final List<DamageCustomizationModel> newDamageModels = [];

        for (var e in newDamageList) {
          final String? filePath = e.imagePath.value;
          final Map<String, dynamic> payloadData = {
            "inspectionReportId": e.inspectionReportId,
            "carId": e.carId,
            "count": e.count,
            "partName": e.part?.split('_').first,
            "partArea": e.part?.split('_').last,
            "type": e.type.value,
            "severity": e.severity.value,
            "recommendation": e.recommendation.value,
            "part": e.part,
          };

          newDamagePayloads.add(payloadData);
          newDamageFilePaths.add(filePath);
          newDamageModels.add(e);
        }

        // Call new damage APIs in parallel
        final List<Future<bool>> newDamageFutures = [];
        for (int i = 0; i < newDamagePayloads.length; i++) {
          newDamageFutures.add(
            damageCustomizationRepo.addNewDamage(filePath: newDamageFilePaths[i], body: newDamagePayloads[i]),
          );
        }

        final List<bool> newDamageResults = await Future.wait(newDamageFutures);

        // Check if all new damage operations were successful
        for (bool result in newDamageResults) {
          if (result == false) {
            allOperationsSuccessful = false;
            break;
          }
        }

        // If any new damage operation failed, show error and return
        if (!allOperationsSuccessful) {
          isLoading(false);
          damageUpdateFailedDialog(locale);
          return;
        }
      }

      // Update current damages
      if (isUpdatedCurrentDamage.value == true) {
        // Build payloads for existing damages
        final List<Map<String, dynamic>> existingDamagePayloads = [];
        final List<String?> existingDamageFilePaths = [];

        for (var e in existingDamageList) {
          final String? filePath = e.imagePath.value;
          final Map<String, dynamic> payloadData = {
            "id": e.id,
            "inspectionReportId": e.inspectionReportId,
            "carId": e.carId,
            "count": e.count,
            "partName": e.part?.split('_').first,
            "partArea": e.part?.split('_').last,
            "type": e.type.value,
            "severity": e.severity.value,
            "recommendation": e.recommendation.value,
            "part": e.part,
          };

          existingDamagePayloads.add(payloadData);
          existingDamageFilePaths.add(filePath);
        }

        // Call existing damage APIs in parallel
        final List<Future<bool>> existingDamageFutures = [];
        for (int i = 0; i < existingDamagePayloads.length; i++) {
          existingDamageFutures.add(
            damageCustomizationRepo.updateCurrentDamage(
              filePath: existingDamageFilePaths[i],
              body: existingDamagePayloads[i],
            ),
          );
        }

        final List<bool> existingDamageResults = await Future.wait(existingDamageFutures);

        // Check if all existing damage operations were successful
        for (bool result in existingDamageResults) {
          if (result == false) {
            allOperationsSuccessful = false;
            break;
          }
        }

        // If any existing damage operation failed, show error and return
        if (!allOperationsSuccessful) {
          isLoading(false);
          damageUpdateFailedDialog(locale);
          return;
        }
      }

      isLoading(false);

      // Only call Get.back if all operations were successful
      if (allOperationsSuccessful) {
        showToast('${locale?.damageUpdateSuccessMsg}');
        Get.back(result: true);
      }
    } catch (e) {
      isLoading(false);
      damageUpdateFailedDialog(locale);
    }
  }

  void damageUpdateFailedDialog(AppLocalizations? locale) {
    showDialog(
      barrierDismissible: true,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.info,
        title: '${locale?.failed}',
        message: '${locale?.damageUpdateFailedMsg}',
        primaryButtonText: '${locale?.ok}',
        themeColor: AppColors.warningColor,
        buttonAction: () => Get.back(),
      ),
    );
  }
}
