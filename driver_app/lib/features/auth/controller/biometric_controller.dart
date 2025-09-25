import 'package:driver_app/shared/utils/app_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/services/service_locator.dart';

class BiometricController extends GetxController {
  final _authRepo = ServiceLocator.get<AuthRepo>();
  final RxBool biometricLoading = false.obs;

  Future<void> addBiometricOnTap() async {
    await _authRepo.biometricAuthentication(
      localizedReason: 'To enable biometric login you have to login first.',
      onSuccess: () => enableBiometric(),
      onFailed: () {
        showAlertDialog('Failed!', description: 'Authentication failed! please try again.');
      },
      biometricNotFound: () {
        showAlertDialog('Face ID not found!', description: 'Add biometric on your device to get this feature.');
      },
    );
  }

  Future<void> enableBiometric() async {
    biometricLoading(true);
    final result = await _authRepo.addOrRemoveBiometric(isBiometric: true);
    debugPrint('addOrRemoveBiometric response:::::::::::::::::::::::::: $result');
    if (result != null) {
      await ServiceLocator.get<LocalStorageRepo>().saveAccessToken(token: result);
      Get.back();
    }
    biometricLoading(false);
  }
}
