import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_list.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/remote/my_task_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/enums/enums.dart';
import '../model/task_model.dart';
import '../model/time_slot_model.dart';

class CompletedTasksController extends GetxController {
  final _myTaskRepo = ServiceLocator.get<MyTaskRepo>();

  // Variables
  final RxBool isLoading = true.obs;
  final RxList<TaskModel> completedTasks = <TaskModel>[].obs;
  final Rx<TimeSlotModel> selectedTimeSlot = AppList.timeSlotList.first.obs;

  @override
  void onInit() async {
    isLoading(true);
    await fetchCompletedTask();
    isLoading(false);

    super.onInit();
  }

  // Fetch pending tasks
  Future<void> fetchCompletedTask() async {
    final Map<String, String> queryParameters = {
      'status': TaskFilterType.completed.value,
      'timePeriod': selectedTimeSlot.value.timeSlotEnum.value,
    };

    await _myTaskRepo.getTask(queryParameters: queryParameters).then((result) {
      if (result != null) {
        completedTasks.value = result;
      }
    });
  }

  // Change time slot
  Future<void> changeTimeSlot(TimeSlotModel model) async {
    selectedTimeSlot.value = model;
    isLoading(true);
    await fetchCompletedTask();
    isLoading(false);
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
    fetchCompletedTask();
  }
}
