import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/utils/app_toast.dart';

class BiometricController extends GetxController {
  BiometricController({required this.authRepo, required this.localStorageRepo});
  final AuthRepo authRepo;
  final LocalStorageRepo localStorageRepo;

  final RxBool biometricLoading = false.obs;

  Future<void> addBiometricOnTap(AppLocalizations? locale) async {
    await authRepo.biometricAuthentication(
      localizedReason: '${locale?.addBiometricDescription}',
      onSuccess: () => enableBiometric(),
      onFailed: () {
        showAlertDialog('${locale?.failed}!', description: '${locale?.biometricAuthFailedMgs}');
      },
      biometricNotFound: () {
        showAlertDialog('${locale?.faceIdNotFound}!', description: '${locale?.addBiometricMgs}');
      },
    );
  }

  Future<void> enableBiometric() async {
    biometricLoading(true);
    final result = await authRepo.addOrRemoveBiometric(isBiometric: true);
    debugPrint('addOrRemoveBiometric response:::::::::::::::::::::::::: $result');
    if (result != null) {
      await localStorageRepo.saveAccessToken(token: result);
      Get.back();
    }
    biometricLoading(false);
  }
}
