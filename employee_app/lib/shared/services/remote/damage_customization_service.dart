import 'package:flutter/material.dart';

import '../../../core/constants/api_endpoint.dart';
import '../../../core/constants/app_string.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';
import '../../repository/remote/damage_customization_repo.dart';
import '../../utils/app_toast.dart';

class DamageCustomizationService extends ApiClient implements DamageCustomizationRepo {
  @override
  Future<bool> addNewDamage({required String? filePath, required Map<String, dynamic>? body}) async {
    try {
      final response = await multipartPatchRequest(path: ApiEndpoint.addNewDamage, filePath: filePath, body: body);
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
  Future<bool> updateCurrentDamage({required String? filePath, required Map<String, dynamic>? body}) async {
    try {
      final response = await multipartPatchRequest(path: ApiEndpoint.editCurrentDamage, filePath: filePath, body: body);
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
  Future<bool> deleteCurrentDamage({required int? id}) async {
    try {
      final response = await deleteRequest(path: '${ApiEndpoint.deleteCurrentDamage}/$id');
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
