// ignore_for_file: library_prefixes

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_string.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/remote/my_task_repo.dart';
import '../../../shared/enums/enums.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_list.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../model/task_model.dart';
import '../model/task_overview_model.dart';
import '../model/task_filter_model.dart';

class MyTaskController extends GetxController {
  MyTaskController({required this.myTaskRepo});
  final MyTaskRepo myTaskRepo;

  final RxBool isLoading = true.obs;
  final Rx<TaskFilterModel> selectedTaskFilter = AppList.taskFilterList.first.obs;
  final Rx<DateTime> selectedTaskFilterDate = DateTime.now().obs;

  // Task Overview
  final Rxn<TaskOverviewModel> taskOverview = Rxn();
  // Task
  final RxList<TaskModel> taskList = <TaskModel>[].obs;
  final RxList<DateTime> taskDates = <DateTime>[].obs;

  @override
  void onInit() async {
    await Future.wait([fetchTaskOverView(), fetchTask(), fetchTaskDates()]);
    isLoading(false);
    super.onInit();
  }

  Future<void> refreshMyTask() async {
    await Future.wait([fetchTaskOverView(), fetchTask(showLoading: false), fetchTaskDates()]);
  }

  // UI functions:::::::::::::::::::::::::::::::
  void changeTaskDate(DateTime newDate) {
    selectedTaskFilterDate.value = newDate;
    fetchTask();
  }

  void changeTaskStatus(TaskFilterModel? model) {
    selectedTaskFilter.value = model ?? selectedTaskFilter.value;
    fetchTask();
  }

  // Handle task navigation
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
    // Refresh task
    refreshMyTask();
  }

  // Functions::::::::::::::::::::::::::::::::::
  Future<void> fetchTaskOverView() async {
    final result = await myTaskRepo.getTaskOverview();
    if (result != null) taskOverview(result);
  }

  // Fetch task list
  Future<void> fetchTask({bool showLoading = true}) async {
    if (showLoading) isLoading(true);
    final String date = readableDate(selectedTaskFilterDate.value, pattern: AppString.queryParamsDateFormat);
    final Map<String, String> queryParameters = {'date': date};

    if (selectedTaskFilter.value.taskFilterType.value.isNotEmpty) {
      queryParameters['status'] = selectedTaskFilter.value.taskFilterType.value;
    }
    await myTaskRepo.getTask(queryParameters: queryParameters).then((result) {
      if (result != null) {
        taskList.value = result;
      }
    });
    isLoading(false);
  }

  // Fetch task dates
  Future<void> fetchTaskDates() async {
    isLoading(true);
    await myTaskRepo.getTaskDates().then((result) => taskDates.value = result);
    isLoading(false);
  }

  // Showing incomplete task dialog
  void showIncompleteTaskWarningDialog({required dynamic data}) {
    debugPrint('Incomplete task event received::::::::::::::: $data');

    if (Get.key.currentState == null) {
      debugPrint('Context not found to show Incomplete Task Warning Dialog');
      return;
    }
    final locale = AppLocalizations.of(Get.key.currentState!.context);
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        title: '${locale?.incompleteTask} !',
        message: '${locale?.incompleteTaskMgs}',
        primaryButtonText: '${locale?.reportIssue}',
        themeColor: AppColors.warningColor,
        buttonAction: () {
          Get.back();
          Get.toNamed(RouterPaths.pendingTasks);
        },
      ),
    );
  }
}
