import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/notification/model/notification_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_client.dart';
import '../../repository/remote/notification_repo.dart';
import '../../utils/app_toast.dart';

class NotificationService extends ApiClient implements NotificationRepo {
  @override
  Future<NotificationModel?> getNotification({required int page, required int limit}) async {
    try {
      final response =
          await getRequest(path: ApiEndpoint.getNotification, queryParameters: {'page': page, 'limit': limit});
      return notificationModelFromJson(jsonEncode(response.data));
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
  Future<bool> deleteNotification({required int id}) async {
    try {
      final response = await deleteRequest(path: '${ApiEndpoint.deleteNotification}/$id');
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

  @override
  Future<bool> readNotification({required int id}) async {
    try {
      final response = await patchRequest(path: '${ApiEndpoint.readNotification}/$id');
      // showToast(response.data['message']);
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

  @override
  Future<bool> markAllAsRead() async {
    try {
      final response = await patchRequest(path: ApiEndpoint.markAllAsRead);
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
