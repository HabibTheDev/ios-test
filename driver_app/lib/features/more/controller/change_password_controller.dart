import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_string.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/remote/change_password_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/utils/enums.dart';
import 'profile_controller.dart';

class ChangePasswordController extends GetxController {
  final _changePassRepo = ServiceLocator.get<ChangePasswordRepo>();

  final RxBool changePassLoading = false.obs;
  final RxBool resendOtpLoading = false.obs;
  final RxBool finishLoading = false.obs;

  final GlobalKey<FormState> changePassFormKey = GlobalKey();
  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController reEnterNewPassword = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  late String? email;

  @override
  void onInit() {
    super.onInit();

    // Get email from profile controller
    final ProfileController profileController = Get.find();
    email = profileController.customerModel.value?.email;
    debugPrint('Email Address: $email');
  }

  Future<void> changePassword() async {
    if (changePassLoading.value) {
      showToast(AppString.anotherProcessRunning);
    }
    if (!changePassFormKey.currentState!.validate()) {
      return;
    }
    if (newPassword.text != reEnterNewPassword.text) {
      showToast('Password doesn\'t match');
      return;
    }
    if (email == null) {
      showToast('Email not found');
      return;
    }
    changePassLoading(true);
    final result = await _changePassRepo.changePassword(
      email: email!,
      password: currentPassword.text,
      newPassword: newPassword.text,
    );
    changePassLoading(false);
    if (result) {
      showToast('OTP send to $email');
      Get.toNamed(RouterPaths.changePasswordOtp);
    }
  }

  Future<void> finishButtonOnTap() async {
    if (finishLoading.value) {
      showToast(AppString.anotherProcessRunning);
    }
    if (otpController.text.isEmpty || otpController.text.length < 5) {
      showToast('Invalid OTP');
      return;
    }
    if (email == null) {
      showToast('Email not found');
      return;
    }

    finishLoading(true);
    final result = await _changePassRepo.verifyOtp(email: email!, otpCode: int.parse(otpController.text));
    finishLoading(false);
    if (result) {
      showToast('Password changed successfully');
      Get.until((route) => route.settings.name == RouterPaths.drawer);
    }
  }

  Future<void> resendOtp() async {
    if (resendOtpLoading.value) {
      showToast(AppString.anotherProcessRunning);
    }
    if (email == null) {
      showToast('Email not found');
      return;
    }

    resendOtpLoading(true);
    final result = await _changePassRepo.resendOtp(
      email: email!,
      otpType: ResendOtpType.changePassword.value,
    );
    resendOtpLoading(false);
    if (result) {
      showToast('OTP resend to $email');
    }
  }
}
