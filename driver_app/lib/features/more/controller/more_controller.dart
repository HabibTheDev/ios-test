import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_list.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/auth_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/widgets/app_alert_dialog.dart';
import '../../auth/model/jwt_token_model.dart';
import 'profile_controller.dart';

class MoreController extends GetxController {
  final _authRepo = ServiceLocator.get<AuthRepo>();
  // Variables
  final RxBool isLoading = true.obs;
  final RxBool biometricSwitchValue = false.obs;
  final RxBool darkModeSwitchValue = false.obs;
  final RxBool biometricLoading = false.obs;
  JwtTokenModel? jwtTokenModel;
  final RxString selectedDistanceUnit = AppList.distanceUnitList.first.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    final ProfileController profileController = Get.find();
    await getBiometricStatus();
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

  void changeDistanceUnit(String newModel) {
    selectedDistanceUnit.value = newModel;
  }

  Future<void> addBiometric() async {
    await Get.toNamed(RouterPaths.addBiometric)?.then((vale) {
      getBiometricStatus();
    });
  }

  Future<void> getBiometricStatus() async {
    jwtTokenModel = await _authRepo.decodeJwtToken();
    biometricSwitchValue.value = jwtTokenModel?.isBiometric ?? false;
  }

  Future<void> removeBiometric() async {
    biometricLoading(true);
    final result = await _authRepo.addOrRemoveBiometric(isBiometric: false);
    if (result != null) {
      await ServiceLocator.get<LocalStorageRepo>().saveAccessToken(token: result);
    } else {
      biometricSwitchValue.value = !biometricSwitchValue.value;
    }
    biometricLoading(false);
  }

  Future<void> logoutOnTap() async {
    Get.back();
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.logout,
        title: 'Are you sure?',
        message: 'If you proceed, you will be logged out from the app.',
        primaryButtonText: 'OK',
        themeColor: AppColors.errorColor,
        buttonAction: () async => await _authRepo.logout(),
      ),
    );
  }
}
