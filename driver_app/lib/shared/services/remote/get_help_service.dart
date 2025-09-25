import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/get_help/model/message_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_client.dart';
import '../../repository/remote/get_help_repo.dart';
import '../../utils/app_toast.dart';

class GetHelpService extends ApiClient implements GetHelpRepo {
  @override
  Future<MessageModel?> getMessages({required int page, required int limit}) async {
    try {
      final response =
          await getRequest(path: ApiEndpoint.getMyMessage, queryParameters: {'page': page, 'limit': limit});
      return messageModelFromJson(jsonEncode(response.data));
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
  Future<MessageModel?> sendMessage({List<String>? filePaths, Map<String, dynamic>? body}) async {
    try {
      final response = await multipartPostRequest(
        path: ApiEndpoint.sendHelpMessage,
        filePaths: filePaths,
        body: body,
      );
      return messageModelFromJson(jsonEncode(response.data));
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }
}
