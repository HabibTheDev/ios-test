import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/repository/remote/forgot_password_repo.dart';
import '../../../shared/services/service_locator.dart';
import '../../../shared/utils/enums.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../core/constants/app_string.dart';

class ForgotPasswordController extends GetxController {
  final _forgotPassRepo = ServiceLocator.get<ForgotPasswordRepo>();

  final RxBool sendOtpLoading = false.obs;
  final RxBool verifyOtpLoading = false.obs;
  final RxBool resendOtpLoading = false.obs;
  final RxBool updatePassLoading = false.obs;

  final GlobalKey<FormState> forgotPassFormKey = GlobalKey();
  final GlobalKey<FormState> updatePassFormKey = GlobalKey();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final FocusNode otpFocusNode = FocusNode();

  Future<void> sendOtpOnTap() async {
    if (sendOtpLoading.value) {
      showToast(AppString.anotherProcessRunning);
    }
    if (!forgotPassFormKey.currentState!.validate()) {
      return;
    }
    sendOtpLoading(true);
    final result = await _forgotPassRepo.sendOtp(email: email.text.trim());
    sendOtpLoading(false);
    if (result) {
      showToast('OTP send to ${email.text}');
      Get.toNamed(RouterPaths.otpScreen);
      otpFocusNode.requestFocus();
    }
  }

  Future<void> verifyOtpOnTap() async {
    if (verifyOtpLoading.value) {
      showToast(AppString.anotherProcessRunning);
    }
    if (otpController.text.isEmpty || otpController.text.length < 5) {
      showToast('Invalid OTP');
      return;
    }
    verifyOtpLoading(true);
    final result = await _forgotPassRepo.verifyOtp(email: email.text.trim(), otpCode: int.parse(otpController.text));
    verifyOtpLoading(false);
    if (result) {
      Get.toNamed(RouterPaths.updatePassword);
    }
  }

  Future<void> resendOtpOnTap() async {
    if (resendOtpLoading.value || verifyOtpLoading.value) {
      showToast(AppString.anotherProcessRunning);
    }
    resendOtpLoading(true);
    final result = await _forgotPassRepo.resendOtp(
      email: email.text.trim(),
      otpType: ResendOtpType.forgotPassword.value,
    );
    resendOtpLoading(false);
    if (result) {
      otpController.clear();
      otpFocusNode.requestFocus();
      showToast('OTP resend to ${email.text}');
    }
  }

  Future<void> updatePasswordOnTap() async {
    if (updatePassLoading.value) {
      showToast(AppString.anotherProcessRunning);
    }
    if (!updatePassFormKey.currentState!.validate()) {
      return;
    }
    if (password.text != confirmPassword.text) {
      showToast('Password doesn\'t match');
      return;
    }
    updatePassLoading(true);
    final result = await _forgotPassRepo.updatePassword(
      email: email.text.trim(),
      password: password.text,
    );
    updatePassLoading(false);
    if (result) {
      showToast('Password successfully updated');
      Get.until((route) => route.settings.name == RouterPaths.login);
    }
  }
}
