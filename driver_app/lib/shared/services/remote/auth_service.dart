// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:local_auth/local_auth.dart';

import '../../../shared/api/api_client.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/router/router_paths.dart';
import '../../../features/auth/model/jwt_token_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../../features/auth/model/token_model.dart';
import '../../repository/local/local_storage_repo.dart';
import '../../repository/remote/auth_repo.dart';
import '../../utils/app_toast.dart';
import '../../api/api_exception.dart';
import '../../widgets/app_alert_dialog.dart';
import '../service_locator.dart';
import 'socket_service.dart';

class AuthService extends ApiClient implements AuthRepo {
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  Future<TokenModel?> login({required String userId, required String password, required String? fcmToken}) async {
    final body = {'userId': userId, 'password': password, 'fcmToken': fcmToken ?? ''};

    try {
      final response = await postRequest(
        path: ApiEndpoint.login,
        body: body,
        isTokenRequired: false,
      );
      return tokenModelFromJson(jsonEncode(response.data['data']));
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
  Future<TokenModel?> signUp({
    required String userId,
    required String fullName,
    required String phone,
    required int countryId,
    required String password,
  }) async {
    final body = {"userId": userId, "name": fullName, "phone": phone, "password": password, "countryId": countryId};
    try {
      final response = await postRequest(
        path: ApiEndpoint.signUp,
        body: body,
        isTokenRequired: false,
      );
      showToast(response.data['message']);
      return tokenModelFromJson(jsonEncode(response.data['data']['tokens']));
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
  Future<bool> biometricAuthentication({
    required String localizedReason,
    required Function() onSuccess,
    required Function() onFailed,
    required Function() biometricNotFound,
  }) async {
    try {
      List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();
      if (availableBiometrics.contains(BiometricType.face) ||
          availableBiometrics.contains(BiometricType.weak) ||
          availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.iris)) {
        final bool didAuthenticate = await _auth.authenticate(
            localizedReason: 'Add biometric authentication to get faster login.',
            options: const AuthenticationOptions(biometricOnly: false, stickyAuth: false));
        if (didAuthenticate) {
          showToast('Success');
          return true;
        } else {
          showAlertDialog('Failed!', description: 'Authentication failed! please try again.');
          return false;
        }
      } else {
        showAlertDialog('Face ID not found!', description: 'Add biometric on your device to get this feature.');
        return false;
      }
    } catch (error) {
      showAlertDialog('Error!', description: '$error');
      return false;
    }
  }

  @override
  Future<JwtTokenModel?> decodeJwtToken() async {
    try {
      final String? accessToken = await ServiceLocator.get<LocalStorageRepo>().getAccessToken();
      if (accessToken == null) return null;
      final Map<String, dynamic> decodedTokenMap = JwtDecoder.decode(accessToken);
      debugPrint('$decodedTokenMap');
      return jwtTokenModelFromJson(jsonEncode(decodedTokenMap));
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }

  @override
  Future<String?> addOrRemoveBiometric({required bool isBiometric}) async {
    try {
      final response = await putRequest(
        path: ApiEndpoint.isBiometric,
        body: {"isBiometric": isBiometric},
      );
      return response.data['data']['accessToken'];
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
  Future<void> logout() async {
    try {
      await ServiceLocator.get<LocalStorageRepo>().clearAll();
      SocketService.instance.disconnectSocket();
      Get.offAllNamed(RouterPaths.login);
    } catch (error) {
      final context = Get.key.currentState?.context;
      if (context == null) return;
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AppAlertDialog(
          title: 'Error',
          message: 'Unable to logout',
          primaryButtonText: 'OK',
          themeColor: AppColors.warningColor,
          buttonAction: () => Get.back(),
        ),
      );
    }
  }
}
