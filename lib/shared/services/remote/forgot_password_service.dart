import 'package:flutter/material.dart';

import '../../../core/constants/app_string.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../api/api_exception.dart';
import '../../repository/remote/forgot_password_repo.dart';
import '../../api/api_imports.dart';
import '../../utils/app_toast.dart';

class ForgotPasswordService extends ApiClient implements ForgotPasswordRepo {
  @override
  Future<bool> sendOtp({required String email}) async {
    try {
      final response = await postRequest(path: ApiEndpoint.sendOtp, body: {"email": email});
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
      final response = await postRequest(path: ApiEndpoint.verifyOtp, body: {"email": email, 'otpCode': otpCode});
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
  Future<bool> updatePassword({required String email, required String password}) async {
    try {
      final response = await postRequest(path: ApiEndpoint.resetPassword, body: {"email": email, 'password': password});
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
