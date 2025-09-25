import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/services/remote/push_notification_service.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../core/router/router_paths.dart';

class LoginController extends GetxController {
  LoginController({required this.authRepo, required this.localStorageRepo});
  final AuthRepo authRepo;
  final LocalStorageRepo localStorageRepo;

  final RxBool functionLoading = false.obs;

  final GlobalKey<FormState> loginFormKey = GlobalKey();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<void> login(AppLocalizations? locale) async {
    if (functionLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    functionLoading(true);
    final fcmToken = await FirebasePushApiService.getFcmToken();
    final model = await authRepo.login(email: email.text.trim(), password: password.text, fcmToken: fcmToken);
    if (model != null) {
      try {
        await localStorageRepo.saveAccessToken(token: model.accessToken);
        await localStorageRepo.saveRefreshToken(token: model.refreshToken);
        navigateToHome();
      } catch (e) {
        showToast('Error saving token');
      }
    }
    functionLoading(false);
  }

  Future<void> biometricLogin(AppLocalizations? locale) async {
    final jwtTokenModel = await authRepo.decodeJwtToken();
    if (jwtTokenModel == null) {
      showAlertDialog('${locale?.warning}!', description: '${locale?.biometricEnableInstruction}');
      return;
    }

    if (jwtTokenModel.isBiometric != true) {
      showAlertDialog('${locale?.warning}!', description: '${locale?.biometricNotEnableMgs}');
      return;
    }

    await authRepo.biometricAuthentication(
      localizedReason: '${locale?.addBiometricDescription}',
      onSuccess: () {
        showToast('${locale?.success}');
        navigateToHome();
      },
      onFailed: () {
        showAlertDialog('${locale?.failed}!', description: '${locale?.biometricAuthFailedMgs}');
      },
      biometricNotFound: () {
        showAlertDialog('${locale?.faceIdNotFound}!', description: '${locale?.addBiometricMgs}');
      },
    );
  }

  void navigateToHome() => Get.offAllNamed(RouterPaths.drawer);
}
