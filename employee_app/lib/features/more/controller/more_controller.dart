import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../../auth/model/jwt_token_model.dart';

import 'profile_controller.dart';

class MoreController extends GetxController {
  MoreController({required this.authRepo, required this.localStorageRepo});
  final AuthRepo authRepo;
  final LocalStorageRepo localStorageRepo;

  // Variables
  final RxBool isLoading = true.obs;
  final RxBool biometricSwitchValue = false.obs;
  final RxBool darkModeSwitchValue = false.obs;
  final RxBool biometricLoading = false.obs;
  JwtTokenModel? jwtTokenModel;

  // Package info
  final Rxn<PackageInfo> packageInfo = Rxn();

  @override
  Future<void> onInit() async {
    super.onInit();

    final ProfileController profileController = Get.find();
    await getBiometricStatus();
    getPackageInfo();
    await profileController.fetchEmployeeInfo();
    isLoading(false);
  }

  // UI Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::
  void changeBiometric(bool val) {
    biometricSwitchValue.value = val;
    if (biometricSwitchValue.value == true) {
      addBiometric();
    } else {
      removeBiometric();
    }
  }

  void changeDarkMode(bool val) {
    darkModeSwitchValue.value = val;
  }

  Future<void> getPackageInfo() async {
    packageInfo.value = await PackageInfo.fromPlatform();
  }

  // API Functions:::::::::::::::::::::::::::::::::::::::::::::::::::::::
  Future<void> addBiometric() async {
    await Get.toNamed(RouterPaths.addBiometric)?.then((vale) async {
      await getBiometricStatus();
    });
  }

  Future<void> getBiometricStatus() async {
    jwtTokenModel = await authRepo.decodeJwtToken();
    biometricSwitchValue.value = jwtTokenModel?.isBiometric ?? false;
  }

  Future<void> removeBiometric() async {
    biometricLoading(true);
    final result = await authRepo.addOrRemoveBiometric(isBiometric: false);
    if (result != null) {
      await localStorageRepo.saveAccessToken(token: result);
    } else {
      biometricSwitchValue.value = !biometricSwitchValue.value;
    }
    biometricLoading(false);
  }

  Future<void> logoutOnTap(AppLocalizations? locale) async {
    Get.back();
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.logout,
        title: '${locale?.areYouSure}',
        message: '${locale?.logoutMessage}',
        primaryButtonText: '${locale?.ok}',
        themeColor: AppColors.errorColor,
        buttonAction: () async => await authRepo.logout(),
      ),
    );
  }
}
