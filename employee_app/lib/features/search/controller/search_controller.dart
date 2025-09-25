import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/local/debounce_repo.dart';
import '../../../shared/repository/remote/my_task_repo.dart';
import '../../../shared/enums/enums.dart';
import '../../my_task/model/task_model.dart';

class TaskSearchController extends GetxController {
  TaskSearchController({required this.debounceRepo, required this.myTaskRepo});
  final DebounceRepo debounceRepo;
  final MyTaskRepo myTaskRepo;

  String searchKey = '';
  final FocusNode searchFocusNode = FocusNode();

  // Task
  final RxBool isLoading = false.obs;
  final RxList<TaskModel> taskList = <TaskModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (searchFocusNode.canRequestFocus) {
      searchFocusNode.requestFocus();
    }
  }

  @override
  onClose() {
    searchFocusNode.dispose();
    debounceRepo.dispose();
    super.onClose();
  }

  Future<void> searchTask() async {
    debounceRepo.debounce(() async {
      if (searchKey.isEmpty) {
        taskList.clear();
        return;
      }
      isLoading(true);

      await myTaskRepo.getTask(queryParameters: {'searchQuery': searchKey}).then((result) {
        if (result != null) {
          taskList.value = result;
          if (taskList.isNotEmpty) {
            searchFocusNode.unfocus();
          }
        }
      });
      isLoading(false);
    });
  }

  // Handle task navigation
  void handleTaskNavigation(TaskModel task) async {
    // General Task
    if (task.state == TaskStateEnum.defaultType.value) {
      await Get.toNamed(RouterPaths.generalTask, arguments: {ArgumentsKey.taskId: task.id});
    }
    // Entry Inspection
    if (task.state == TaskStateEnum.entryInspection.value) {
      await Get.toNamed(RouterPaths.entryInspection, arguments: {ArgumentsKey.taskId: task.id});
    }
    // General Inspection
    // if (task.state == TaskStateEnum.generalInspection.value) {
    //   await Get.toNamed(RouterPaths.generalInspection, arguments: {ArgumentsKey.taskId: task.id});
    // }
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
    debugPrint('Fetch task called:::::::::::::${task.state}');
    searchTask();
  }
}
