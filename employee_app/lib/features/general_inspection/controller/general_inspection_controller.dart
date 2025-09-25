import 'package:get/get.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../shared/repository/remote/single_task_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/model/single_task_model.dart';
import '../../../shared/enums/enums.dart';
import '../../inspection/model/inspection_arguments_model.dart';

class GeneralInspectionController extends GetxController {
  GeneralInspectionController({required this.singleTaskRepo});
  final SingleTaskRepo singleTaskRepo;

  // Variables
  final RxBool isLoading = false.obs;
  final RxBool stepLoading = false.obs;

  // Task
  final Rxn<SingleTaskModel> taskModel = Rxn();

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

  Future<void> startInspectionOnTap({required int? taskStepId}) async {
    if (taskModel.value?.task?.id == null || taskModel.value?.task?.carId == null) {
      showToast('Task & Car ID not found');
      return;
    }
    if (taskModel.value?.task?.status == TaskStepStatusEnum.awaiting.value) {
      stepLoading(true);
      final result = await singleTaskRepo.startTask(taskId: taskModel.value?.task?.id, stepId: taskStepId);
      stepLoading(false);

      if (result) {
        await Get.toNamed(
          RouterPaths.carExteriorInstruction,
          arguments: {
            ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
              title: 'General inspection',
              returnScreen: RouterPaths.generalInspection,
              taskId: taskModel.value?.task?.id,
              carID: taskModel.value?.task?.carId,
              contactID: taskModel.value?.task?.contactId,
              taskStepId: taskStepId,
              inspectionType: InspectionTypeEnum.generalInspection,
              vin: taskModel.value?.carInfo?.vin,
              inspectionCaptureTypeEnum: InspectionCaptureTypeEnum.carExterior,
            ),
          },
        );
      }
    } else {
      await Get.toNamed(
        RouterPaths.carExteriorInstruction,
        arguments: {
          ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
            title: 'General inspection',
            returnScreen: RouterPaths.generalInspection,
            taskId: taskModel.value?.task?.id,
            carID: taskModel.value?.task?.carId,
            contactID: taskModel.value?.task?.contactId,
            taskStepId: taskStepId,
            inspectionType: InspectionTypeEnum.generalInspection,
            vin: taskModel.value?.carInfo?.vin,
            inspectionCaptureTypeEnum: InspectionCaptureTypeEnum.carExterior,
          ),
        },
      );
    }
    fetchSingleTask(taskId: taskModel.value?.task?.id);
  }
}
