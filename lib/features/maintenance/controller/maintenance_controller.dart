import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../shared/model/single_task/steps_model.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/model/single_task/regular_servicing_checklist_model.dart';
import '../../../shared/model/single_task_model.dart';
import '../../../shared/repository/local/media_repo.dart';
import '../../../shared/repository/remote/single_task_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/enums/enums.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../../inspection/model/inspection_arguments_model.dart';
import '../model/maintenance_repair_damage_model.dart';
import '../view/widgets/widget_imports.dart';

class MaintenanceController extends GetxController {
  MaintenanceController({required this.singleTaskRepo, required this.mediaRepo});
  final SingleTaskRepo singleTaskRepo;
  final MediaRepo mediaRepo;

  // Variables
  final RxBool isLoading = false.obs;
  final RxBool stepLoading = false.obs;
  final RxBool provideInfoLoading = false.obs;

  final Rxn<File> selectedFile = Rxn();
  final Rxn<double> selectedFileSize = Rxn();

  // Task
  final Rxn<SingleTaskModel> taskModel = Rxn();

  // Provide info
  final List<Map<String, dynamic>> selectedBodyDamages = [];
  final List<int> selectedServiceAreas = [];

  // Fetch Single task initially
  Future<void> fetchSingleTaskOnInitially({required int? taskId}) async {
    if (taskId == null) {
      showToast('Task id not found');
      return;
    }
    isLoading(true);
    await fetchSingleTask(taskId: taskId);
    // await fetchCurrentDamages();
    isLoading(false);
  }

  // Single task
  Future<void> fetchSingleTask({required int? taskId}) async {
    final result = await singleTaskRepo.getSingleTask(taskId: taskId);
    if (result != null) {
      taskModel.value = result;
    }
  }

  // Step action
  void stepActionOnTap({required Steps? step, required AppLocalizations? locale}) async {
    if (stepLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    if (taskModel.value?.task?.id == null) {
      showToast('Task ID not found');
      return;
    }

    if (step?.isInspection == true) {
      if (taskModel.value?.task?.carId == null) {
        showToast('Car ID not found');
        return;
      }
      await Get.toNamed(
        RouterPaths.carExteriorInstruction,
        arguments: {
          ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
            title: '${locale?.inspection}',
            returnScreen: RouterPaths.maintenanceTask,
            taskId: taskModel.value?.task?.id,
            carID: taskModel.value?.task?.carId,
            contactID: taskModel.value?.task?.contactId,
            taskStepId: step?.id,
            inspectionType: InspectionTypeEnum.maintenanceInspection,
            vin: taskModel.value?.carInfo?.vin,
            inspectionCaptureTypeEnum: InspectionCaptureTypeEnum.carExterior,
          ),
        },
      );
    }

    if (step?.isLastStep == true) {
      if (taskModel.value?.task?.type == TaskTypeEnum.regular.value) {
        showRegularDamageDetailsModal(step: step, locale: locale);
      } else if (taskModel.value?.task?.type == TaskTypeEnum.retrieve.value) {
        showRetrieveDamageDetailsModal(step: step, locale: locale);
      } else if (taskModel.value?.task?.type == TaskTypeEnum.dropOff.value) {
        showDropOffDamageDetailsModal(step: step, locale: locale);
      }
    } else {
      stepLoading(true);
      final result = await singleTaskRepo.completeMaintenanceStep(taskId: taskModel.value?.task?.id, stepId: step?.id);
      if (result) await fetchSingleTask(taskId: taskModel.value?.task?.id);
      stepLoading(false);
    }
  }

  // Drop-off Modal
  void showDropOffDamageDetailsModal({required Steps? step, required AppLocalizations? locale}) {
    modalBottomSheet(
      context: Get.key.currentState!.context,
      title: '${locale?.provideInfo}',
      child: DropOffDamageWidget(
        step: step,
        onComplete: (value) async {
          if (value) {
            Get.back();
            stepLoading(true);
            final result = await singleTaskRepo.completeMaintenanceStep(
              taskId: taskModel.value?.task?.id,
              stepId: step?.id,
            );
            if (result) await fetchSingleTask(taskId: taskModel.value?.task?.id);
            stepLoading(false);
          }
        },
      ),
    );
  }

  // Retrieve Modal
  void showRetrieveDamageDetailsModal({required Steps? step, required AppLocalizations? locale}) {
    modalBottomSheet(
      context: Get.key.currentState!.context,
      title: '${locale?.provideInfo}',
      child: RetrieveDamageWidget(
        step: step,
        onComplete: (value) async {
          if (value) {
            Get.back();
            stepLoading(true);
            final result = await singleTaskRepo.completeMaintenanceStep(
              taskId: taskModel.value?.task?.id,
              stepId: step?.id,
            );
            if (result) await fetchSingleTask(taskId: taskModel.value?.task?.id);
            stepLoading(false);
          }
        },
      ),
    );
  }

  // Regular Modal
  void showRegularDamageDetailsModal({required Steps? step, required AppLocalizations? locale}) {
    modalBottomSheet(
      context: Get.key.currentState!.context,
      title: '${locale?.provideInfo}',
      child: RegularDamageWidget(
        step: step,
        regularMaintenanceType: taskModel.value?.task?.requestMaintenance?.maintanainanceType,
        onComplete: (value) async {
          if (value) {
            Get.back();
            stepLoading(true);
            final result = await singleTaskRepo.completeMaintenanceStep(
              taskId: taskModel.value?.task?.id,
              stepId: step?.id,
            );
            if (result) await fetchSingleTask(taskId: taskModel.value?.task?.id);
            stepLoading(false);
          }
        },
      ),
    );
  }

  // Provide info API's::::::::::::::::::::::::::::::::::::::
  Future<void> selectFileOnTap() async {
    final file = await mediaRepo.getFile();
    if (file != null) {
      selectedFile.value = file;
      final fileSizeInBytes = await file.length();
      selectedFileSize.value = fileSizeInBytes / (1024 * 1024);
    }
  }

  Future<void> removeSelectFile() async {
    selectedFile.value = null;
    selectedFileSize.value = null;
  }

  // Future<void> fetchCurrentDamages() async {
  //   if (taskModel.value?.task?.carId == null) {
  //     showToast('Car ID not found');
  //     return;
  //   }
  //   reportLoading(true);
  //   final report =
  //       await ServiceLocator.get<InspectionRepo>().getCurrentDamageReport(carID: taskModel.value!.task!.carId!);
  //   if (report != null) {
  //     inspectionReportModel.value = report;
  //   }
  //   reportLoading(false);
  // }

  void bodyDamageOnChange(List<MaintenanceRepairDamageModel> damageList) {
    selectedBodyDamages.clear();
    for (MaintenanceRepairDamageModel section in damageList) {
      for (DamageList area in section.damageList!) {
        for (PartAreaList part in area.partAreaList!) {
          if (part.bodyDamage?.checkValue == true && part.damageId != null) {
            selectedBodyDamages.add({"damageId": part.damageId, "isRepaired": part.bodyDamage?.checkValue});
          }
        }
      }
    }

    debugPrint(jsonEncode(selectedBodyDamages));
  }

  void serviceAreaOnChange(List<RegularServicingChecklistModel> list) {
    selectedServiceAreas.clear();
    for (RegularServicingChecklistModel service in list) {
      for (CheckList area in service.checkList!) {
        if (area.isChecked == true && area.id != null) {
          if (area.availableCheckListId == null) {
            showToast('Id not found', toastLength: Toast.LENGTH_SHORT);
            return;
          }
          selectedServiceAreas.add(area.availableCheckListId!);
        }
      }
    }

    debugPrint(jsonEncode(selectedServiceAreas));
  }

  Future<bool> provideInfo({
    required Steps? step,
    required String maintenanceExpense,
    required AppLocalizations? locale,
    String? regularMaintenanceType,
  }) async {
    if (provideInfoLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return false;
    }
    if (taskModel.value?.task?.id == null) {
      showToast('Task ID not found');
      return false;
    }
    if (taskModel.value?.task?.carId == null) {
      showToast('Car ID not found');
      return false;
    }
    if (step?.id == null) {
      showToast('Step ID not found');
      return false;
    }
    if (selectedFileSize.value != null) {
      if (selectedFileSize.value! > 3.0) {
        showToast('File max limit is 3 MB');
        return false;
      }
    }
    if (regularMaintenanceType == RegularMaintenanceType.regular.value &&
        (taskModel.value?.task?.requestMaintenance?.regularRepairCheck ?? []).isNotEmpty) {
      if (selectedServiceAreas.isEmpty) {
        showToast('Please check repaired serviced areas');
        return false;
      }
    }
    if (regularMaintenanceType == RegularMaintenanceType.damage.value &&
        (taskModel.value?.task?.requestMaintenance?.repairDamage ?? []).isNotEmpty) {
      if (selectedBodyDamages.isEmpty) {
        showToast('Please check repaired damages');
        return false;
      }
    }
    late Map<String, dynamic> data;
    data = {
      "taskId": taskModel.value?.task?.id,
      "taskStepId": step?.id,
      "maintenanceExpense": double.parse(maintenanceExpense),
    };
    if (regularMaintenanceType == RegularMaintenanceType.regular.value) {
      data["regularRepairCheckList"] = selectedServiceAreas;
    } else if (regularMaintenanceType == RegularMaintenanceType.damage.value) {
      data["repairDamage"] = selectedBodyDamages;
    }

    provideInfoLoading(true);
    final result = await singleTaskRepo.provideMaintenanceInfo(
      carId: taskModel.value!.task!.carId!,
      regularMaintenanceType: regularMaintenanceType,
      filePaths: selectedFile.value != null ? [selectedFile.value!.path] : null,
      body: data,
    );
    provideInfoLoading(false);
    if (result) return true;
    return false;
  }
}
