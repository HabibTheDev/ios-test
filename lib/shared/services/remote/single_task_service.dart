import 'dart:convert';
import 'package:flutter/material.dart';

import '../../model/single_task_model.dart';
import '../../repository/remote/single_task_repo.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';
import '../../utils/app_toast.dart';
import '../../enums/enums.dart';

class SingleTaskService extends ApiClient implements SingleTaskRepo {
  // Get single task
  @override
  Future<SingleTaskModel?> getSingleTask({required int? taskId}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getSingleTask}/$taskId');
      return singleTaskModelFromJson(jsonEncode(response.data['data']));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error, stackTrace) {
      showToast(error.toString());
      debugPrint(error.toString());
      debugPrint(stackTrace.toString());
    }
    return null;
  }

  // Common step
  @override
  Future<bool> startTask({required int? taskId, required int? stepId}) async {
    try {
      final response = await patchRequest(path: '${ApiEndpoint.startTask}/$taskId/$stepId');
      showToast(response.data['message']);
      return response.data['success'] ?? false;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  // Inspection step
  @override
  Future<bool> completeEntryInspectionStep({
    required int? taskId,
    required int? stepId,
    String? filePath,
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await multipartPatchRequest(
        path: '${ApiEndpoint.stepperInspection}/$taskId/$stepId',
        filePath: filePath,
        body: body,
      );
      showToast(response.data['message']);
      return response.data['success'] ?? false;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  // Exchange step
  @override
  Future<bool> completeExchangeStep({required int? taskId, required int? stepId}) async {
    try {
      final response = await patchRequest(path: '${ApiEndpoint.stepperExchange}/$taskId/$stepId');
      showToast(response.data['message']);
      return response.data['success'] ?? false;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  // Common step
  @override
  Future<bool> completeCommonStep({required int? taskId, required int? stepId}) async {
    try {
      final response = await patchRequest(path: '${ApiEndpoint.stepperCommon}/$taskId/$stepId');
      showToast(response.data['message']);
      return response.data['success'] ?? false;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  // Handover step
  @override
  Future<bool> completeHandoverStep({required int? taskId, required int? stepId}) async {
    try {
      final response = await patchRequest(path: '${ApiEndpoint.stepperHandover}/$taskId/$stepId');
      showToast(response.data['message']);
      return response.data['success'] ?? false;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  // Maintenance step
  @override
  Future<bool> completeMaintenanceStep({required int? taskId, required int? stepId}) async {
    try {
      final response = await patchRequest(path: '${ApiEndpoint.stepperMaintenance}/$taskId/$stepId');
      showToast(response.data['message']);
      return response.data['success'] ?? false;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  // Return step
  @override
  Future<bool> completeReturnStep({required int? taskId, required int? stepId}) async {
    try {
      final response = await patchRequest(path: '${ApiEndpoint.stepperReturn}/$taskId/$stepId');
      showToast(response.data['message']);
      return response.data['success'] ?? false;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }

  // Provide info
  @override
  Future<bool> provideMaintenanceInfo({
    required int carId,
    String? regularMaintenanceType,
    List<String>? filePaths,
    Map<String, dynamic>? body,
  }) async {
    try {
      final path = regularMaintenanceType == RegularMaintenanceType.regular.value
          ? ApiEndpoint.servicingProvideInfo
          : regularMaintenanceType == RegularMaintenanceType.damage.value
          ? ApiEndpoint.damageRepairProvideInfo
          : ApiEndpoint.provideInfo;
      final response = await multipartPostRequest(path: '$path/$carId', filePaths: filePaths, body: body);
      showToast(response.data['message'] ?? '');
      return response.data['success'] ?? false;
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
