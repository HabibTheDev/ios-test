import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_list.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/remote/my_task_repo.dart';
import '../../../shared/enums/enums.dart';
import '../model/in_progress_task_filter_model.dart';
import '../model/task_model.dart';

class InProgressController extends GetxController {
  InProgressController({required this.myTaskRepo});
  final MyTaskRepo myTaskRepo;

  // Variables
  final RxBool isLoading = true.obs;
  final RxList<TaskModel> taskList = <TaskModel>[].obs;
  final Rx<InProgressTaskFilterModel> selectedTaskFilter = AppList.inProgressTaskFilterList.first.obs;

  @override
  void onInit() async {
    isLoading(true);
    await fetchInProgressTask();
    isLoading(false);
    super.onInit();
  }

  // Change task filter
  void changeTaskStatus(InProgressTaskFilterModel? model) async {
    selectedTaskFilter.value = model ?? selectedTaskFilter.value;
    isLoading(true);
    await fetchInProgressTask();
    isLoading(false);
  }

  // Fetch task
  Future<void> fetchInProgressTask() async {
    final Map<String, String> queryParameters = {'status': TaskFilterType.inProgress.value};

    if (selectedTaskFilter.value.taskFilterType.value.isNotEmpty) {
      queryParameters['priority'] = selectedTaskFilter.value.taskFilterType.value;
    }

    await myTaskRepo.getTask(queryParameters: queryParameters).then((result) {
      if (result != null) {
        taskList.value = result;
      }
    });
  }

  // Handle Task
  void handleTaskNavigation(TaskModel task) async {
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
    fetchInProgressTask();
  }
}
