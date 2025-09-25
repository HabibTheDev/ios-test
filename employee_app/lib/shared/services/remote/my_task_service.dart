import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/my_task/model/task_date_model.dart';
import '../../../features/my_task/model/task_model.dart';
import '../../../features/my_task/model/task_overview_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../repository/remote/my_task_repo.dart';
import '../../utils/app_toast.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';

class MyTaskService extends ApiClient implements MyTaskRepo {
  @override
  Future<TaskOverviewModel?> getTaskOverview() async {
    try {
      final response = await getRequest(path: ApiEndpoint.overviewUserTask);
      return taskOverviewModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }

  @override
  Future<List<DateTime>> getTaskDates() async {
    try {
      final response = await getRequest(path: ApiEndpoint.taskDates);
      return taskDateModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return [];
  }

  @override
  Future<List<TaskModel>?> getTask({required Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await getRequest(path: ApiEndpoint.getUserTask, queryParameters: queryParameters);
      return taskModelFromJson(jsonEncode(response.data['data']['tasks']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }

  @override
  Future<bool> reportTaskIssue({required int taskId, required String issue}) async {
    try {
      final response = await putRequest(path: '${ApiEndpoint.reportTaskIssue}/$taskId', body: {"issue": issue});
      showToast(response.data['message']);
      return response.data['success'];
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }
}
