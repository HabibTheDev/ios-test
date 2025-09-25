import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_list.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/remote/my_task_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/enums/enums.dart';
import '../model/pending_task_filter_model.dart';
import '../model/task_model.dart';

class PendingTasksController extends GetxController {
  PendingTasksController({required this.myTaskRepo});
  final MyTaskRepo myTaskRepo;

  // Variables
  final RxBool isLoading = true.obs;
  final RxList<TaskModel> pendingTasks = <TaskModel>[].obs;
  final Rx<PendingTaskFilterModel> selectedTaskFilter = AppList.pendingTaskFilterList.first.obs;

  // Report Issue
  final RxBool issueReportLoading = false.obs;
  final TextEditingController reportIssueController = TextEditingController();
  final GlobalKey<FormState> reportIssueFormKey = GlobalKey();

  @override
  void onInit() async {
    isLoading(true);
    await fetchPendingTask();
    isLoading(false);

    super.onInit();
  }

  // Change task filter
  void changeTaskStatus(PendingTaskFilterModel? model) async {
    selectedTaskFilter.value = model ?? selectedTaskFilter.value;
    isLoading(true);
    await fetchPendingTask();
    isLoading(false);
  }

  // Fetch pending tasks
  Future<void> fetchPendingTask() async {
    final Map<String, String> queryParameters = {'status': TaskFilterType.pending.value};

    if (selectedTaskFilter.value.taskFilterType.value.isNotEmpty) {
      queryParameters['pendingTask'] = selectedTaskFilter.value.taskFilterType.value;
    }

    await myTaskRepo.getTask(queryParameters: queryParameters).then((result) {
      if (result != null) {
        pendingTasks.value = result;
      }
    });
  }

  // Report issue
  Future<bool> reportTaskIssue({required int taskId, required AppLocalizations? locale}) async {
    if (issueReportLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return false;
    }
    if (!reportIssueFormKey.currentState!.validate()) {
      return false;
    }
    issueReportLoading(true);
    final result = await myTaskRepo.reportTaskIssue(taskId: taskId, issue: reportIssueController.text.trim());
    if (result) {
      await fetchPendingTask();
      reportIssueController.clear();
      return true;
    }
    issueReportLoading(false);
    return false;
  }

  // Handle task navigation
  Future<void> handleTaskNavigation(TaskModel task) async {
    // General
    if (task.state == TaskStateEnum.defaultType.value) {
      await Get.toNamed(RouterPaths.generalTask, arguments: {ArgumentsKey.taskId: task.id});
    }
    // Entry Inspection
    if (task.state == TaskStateEnum.entryInspection.value) {
      await Get.toNamed(RouterPaths.entryInspection, arguments: {ArgumentsKey.taskId: task.id});
    }
    // General Inspection
    if (task.state == TaskStateEnum.generalInspection.value) {
      await Get.toNamed(RouterPaths.generalInspection, arguments: {ArgumentsKey.taskId: task.id});
    }
    // Handover
    if (task.state == TaskStateEnum.handover.value) {
      await Get.toNamed(RouterPaths.handover, arguments: {ArgumentsKey.taskId: task.id});
    }
    // Exchange
    if (task.state == TaskStateEnum.exchange.value) {
      await Get.toNamed(RouterPaths.exchange, arguments: {ArgumentsKey.taskId: task.id});
    }
    // Return
    if (task.state == TaskStateEnum.returnTask.value) {
      await Get.toNamed(RouterPaths.returnTask, arguments: {ArgumentsKey.taskId: task.id});
    }
    // Maintenance
    if (task.state == TaskStateEnum.maintenance.value) {
      await Get.toNamed(RouterPaths.maintenanceTask, arguments: {ArgumentsKey.taskId: task.id});
    }
    debugPrint('Fetch task called:::::::::::::');
    fetchPendingTask();
  }
}
