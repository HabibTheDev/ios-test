import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../shared/model/single_task/steps_model.dart';
import '../../../shared/model/single_task_model.dart';
import '../../../shared/repository/remote/single_task_repo.dart';
import '../../../shared/utils/app_toast.dart';

class GeneralTaskController extends GetxController {
  GeneralTaskController({required this.singleTaskRepo});
  final SingleTaskRepo singleTaskRepo;

  // Variables
  final RxBool isLoading = false.obs;
  final RxBool stepLoading = false.obs;

  // Task
  final Rxn<SingleTaskModel> taskModel = Rxn();

  // Single task initially
  Future<void> fetchSingleTaskOnInitially({required int? taskId}) async {
    if (taskId == null) {
      showToast('Task ID not found');
      return;
    }
    isLoading(true);
    await fetchSingleTask(taskId: taskId);
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
  void stepActionOnTap({
    required int? taskId,
    required Steps? step,
    String? videoInspectionTitle,
    required AppLocalizations? locale,
  }) async {
    if (stepLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    stepLoading(true);
    final result = await singleTaskRepo.completeCommonStep(taskId: taskId, stepId: step?.id);
    if (result) await fetchSingleTask(taskId: taskId);
    stepLoading(false);
  }
}
