import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';
import '../../repository/remote/change_password_repo.dart';
import '../../utils/app_toast.dart';

class ChangePasswordService extends ApiClient implements ChangePasswordRepo {
  @override
  Future<bool> changePassword({required String email, required String password, required String newPassword}) async {
    try {
      final response = await postRequest(
        path: ApiEndpoint.requestChangePassword,
        body: {"email": email, "password": password, "newPassword": newPassword},
      );
      return response.statusCode == 200;
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
  Future<bool> verifyOtp({required String email, required int otpCode}) async {
    try {
      final response = await postRequest(
        path: ApiEndpoint.confirmChangePassword,
        body: {"email": email, 'otpCode': otpCode},
      );
      return response.statusCode == 200;
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
  Future<bool> resendOtp({required String email, required String otpType}) async {
    try {
      final response = await postRequest(path: ApiEndpoint.resendOtp, body: {"email": email, "otpType": otpType});
      return response.statusCode == 200;
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
