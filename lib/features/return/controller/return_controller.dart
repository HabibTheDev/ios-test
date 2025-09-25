import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/model/single_task/steps_model.dart';
import '../../../shared/model/single_task_model.dart';
import '../../../shared/repository/remote/single_task_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/enums/enums.dart';
import '../../inspection/model/inspection_arguments_model.dart';

class ReturnController extends GetxController {
  ReturnController({required this.singleTaskRepo});
  final SingleTaskRepo singleTaskRepo;

  // Variables
  final RxBool isLoading = true.obs;
  final RxBool stepLoading = false.obs;

  // Task
  final Rxn<SingleTaskModel> taskModel = Rxn();

  // Step action
  void stepActionOnTap({required Steps? step, required AppLocalizations? locale}) async {
    if (stepLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    if (step?.isInspection == true) {
      if (taskModel.value?.task?.id == null || taskModel.value?.task?.carId == null) {
        showToast('Task & Car ID not found');
        return;
      }
      await Get.toNamed(
        RouterPaths.carExteriorInstruction,
        arguments: {
          ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
            title: 'Return inspection',
            returnScreen: RouterPaths.returnTask,
            taskId: taskModel.value?.task?.id,
            carID: taskModel.value?.task?.carId,
            contactID: taskModel.value?.task?.contactId,
            taskStepId: step?.id,
            inspectionType: InspectionTypeEnum.returnInspection,
            vin: taskModel.value?.carInfo?.vin,
            inspectionCaptureTypeEnum: InspectionCaptureTypeEnum.carExterior,
          ),
        },
      );
    }
    stepLoading(true);
    final result = await singleTaskRepo.completeReturnStep(taskId: taskModel.value?.task?.id, stepId: step?.id);
    if (result) await fetchSingleTask(taskId: taskModel.value?.task?.id);
    stepLoading(false);
  }

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
    await fetchSingleTask(taskId: taskId);
    isLoading(false);
  }
}
