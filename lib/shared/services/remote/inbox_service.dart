import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../features/inbox/model/message_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';
import '../../repository/remote/inbox_repo.dart';
import '../../utils/app_toast.dart';

class InboxService extends ApiClient implements InboxRepo {
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
        path: ApiEndpoint.sendInboxMessage,
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
