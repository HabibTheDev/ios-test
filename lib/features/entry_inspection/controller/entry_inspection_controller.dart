import 'package:get/get.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/model/single_task/steps_model.dart';
import '../../../shared/repository/local/orientation_repo.dart';
import '../../../shared/repository/remote/single_task_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/model/single_task_model.dart';
import '../../../shared/enums/enums.dart';
import '../../inspection/model/inspection_arguments_model.dart';
import '../../inspection/model/inspection_report_model.dart';

class EntryInspectionController extends GetxController {
  EntryInspectionController({required this.singleTaskRepo, required this.orientationRepo});
  final SingleTaskRepo singleTaskRepo;
  final OrientationRepo orientationRepo;

  // Variables
  final RxBool isLoading = false.obs;
  final RxBool stepLoading = false.obs;

  // Task
  final Rxn<SingleTaskModel> taskModel = Rxn();

  InspectionArgumentsModel? inspectionArgumentsModel;
  InspectionReportModel? inspectionReportModel;

  bool eligibleToFinishLastStep = false;

  // Single task
  Future<void> fetchSingleTask({required int? taskId}) async {
    final result = await singleTaskRepo.getSingleTask(taskId: taskId);
    if (result != null) {
      taskModel.value = result;
    }
  }

  // Single task initially
  Future<void> fetchSingleTaskOnInitially({required int? taskId}) async {
    if (taskId == null) {
      showToast('Task id not found');
      return;
    }
    isLoading(true);
    await fetchSingleTask(taskId: taskId);
    isLoading(false);
  }

  // Step action
  void stepActionOnTap({required Steps? step, required AppLocalizations? locale}) async {
    if (stepLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    if (taskModel.value?.task?.id == null) {
      showToast('Task not found');
      return;
    }
    if (taskModel.value?.task?.carId == null) {
      showToast('Car not found');
      return;
    }

    if (step?.step == 1) {
      // Reach vehicle location
      _completeStep(step: step);
      inspectionArgumentsModel = null;
    } else if (step?.step == 2) {
      // Verify the vehicle VIN
      inspectionArgumentsModel = null;
      await Get.toNamed(
        RouterPaths.captureVin,
        arguments: {
          ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
            title: '${locale?.verifyVin}',
            returnScreen: RouterPaths.entryInspection,
            inspectionType: InspectionTypeEnum.entryInspection,
            taskId: taskModel.value?.task?.id,
            carID: taskModel.value?.task?.carId,
            contactID: taskModel.value?.task?.contactId,
            taskStepId: step?.id,
            vin: taskModel.value?.carInfo?.vin,
          ),
        },
      );
      if (inspectionArgumentsModel?.extractedVin == null ||
          inspectionArgumentsModel?.captureFileModel?.doorVINStickerImage == null) {
        showToast(' VIN image not found');
        return;
      }
      // Start stepper action
      stepLoading(true);
      final result = await singleTaskRepo.completeEntryInspectionStep(
        taskId: taskModel.value?.task?.id,
        stepId: step?.id,
        filePath: inspectionArgumentsModel?.captureFileModel?.doorVINStickerImage?.path,
        body: {'vin': inspectionArgumentsModel?.extractedVin},
      );
      if (result) await fetchSingleTask(taskId: taskModel.value?.task?.id);
      stepLoading(false);
    } else if (step?.step == 3) {
      // Capture vehicle images
      inspectionReportModel = null;
      await Get.toNamed(
        RouterPaths.inspectionCaptureType,
        arguments: {
          ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
            title: '${locale?.vehicleImages}',
            returnScreen: RouterPaths.entryInspection,
            inspectionType: InspectionTypeEnum.entryInspection,
            taskId: taskModel.value?.task?.id,
            carID: taskModel.value?.task?.carId,
            contactID: taskModel.value?.task?.contactId,
            taskStepId: step?.id,
            vin: taskModel.value?.carInfo?.vin,
            extractedVin: inspectionArgumentsModel?.extractedVin,
            captureFileModel: inspectionArgumentsModel?.captureFileModel,
          ),
        },
      );
      if (inspectionReportModel != null) {
        _completeStep(step: step);
      }
    } else if (step?.step == 4) {
      // Review and submit report
      eligibleToFinishLastStep = false;
      await Get.toNamed(
        RouterPaths.reviewReport,
        arguments: {
          ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
            title: '${locale?.reviewReport}',
            returnScreen: RouterPaths.entryInspection,
            inspectionType: InspectionTypeEnum.entryInspection,
            taskId: taskModel.value?.task?.id,
            carID: taskModel.value?.task?.carId,
            contactID: taskModel.value?.task?.contactId,
            taskStepId: step?.id,
            vin: taskModel.value?.carInfo?.vin,
          ),
        },
      );
      if (eligibleToFinishLastStep == true) {
        _completeStep(step: step);
      }
    }
    orientationRepo.portraitOrientation();
    orientationRepo.showStatusBar();
    inspectionReportModel = null;
    eligibleToFinishLastStep = false;
    fetchSingleTask(taskId: taskModel.value?.task?.id);
  }

  Future<void> _completeStep({required Steps? step}) async {
    stepLoading(true);
    final result = await singleTaskRepo.completeEntryInspectionStep(
      taskId: taskModel.value?.task?.id,
      stepId: step?.id,
    );
    if (result) await fetchSingleTask(taskId: taskModel.value?.task?.id);
    stepLoading(false);
  }
}
