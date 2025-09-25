import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_string.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/services/remote/push_notification_service.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../core/router/router_paths.dart';

class LoginController extends GetxController {
  final _authRepo = ServiceLocator.get<AuthRepo>();
  final _localStorageRepo = ServiceLocator.get<LocalStorageRepo>();

  final RxBool functionLoading = false.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final TextEditingController userId = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> login() async {
    if (functionLoading.value) {
      showToast(AppString.anotherProcessRunning);
      return;
    }
    if (!loginFormKey.currentState!.validate()) return;

    functionLoading(true);
    final fcmToken = await FirebasePushApiService.getFcmToken();
    final model = await _authRepo.login(userId: userId.text.trim(), password: password.text, fcmToken: fcmToken);
    if (model != null) {
      try {
        await _localStorageRepo.saveAccessToken(token: model.accessToken);
        await _localStorageRepo.saveRefreshToken(token: model.refreshToken);
        Get.offAllNamed(RouterPaths.drawer);
      } catch (e) {
        showToast('Error saving token');
      }
    }
    functionLoading(false);
  }

  Future<void> biometricLogin() async {
    final jwtTokenModel = await _authRepo.decodeJwtToken();
    if (jwtTokenModel == null) {
      showAlertDialog('Warning!', description: 'To enable biometric login you have to login first.');
      return;
    }

    if (jwtTokenModel.isBiometric == null || jwtTokenModel.isBiometric == false) {
      showAlertDialog('Warning!', description: 'Biometric is not enabled yet to your profile.');
      return;
    }

    await _authRepo.biometricAuthentication(
      localizedReason: 'To enable biometric login you have to login first.',
      onSuccess: () {
        showToast('Success!');
        Get.offAllNamed(RouterPaths.drawer);
      },
      onFailed: () {
        showAlertDialog('Failed!', description: 'Authentication failed! please try again.');
      },
      biometricNotFound: () {
        showAlertDialog('Face ID not found!', description: 'Add biometric on your device to get this feature.');
      },
    );
  }
}
