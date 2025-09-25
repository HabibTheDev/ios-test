import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/remote/forgot_password_repo.dart';
import '../../../shared/enums/enums.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/utils/app_toast.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController({required this.forgotPasswordRepo});
  final ForgotPasswordRepo forgotPasswordRepo;

  final RxBool sendOtpLoading = false.obs;
  final RxBool verifyOtpLoading = false.obs;
  final RxBool resendOtpLoading = false.obs;
  final RxBool updatePassLoading = false.obs;

  final GlobalKey<FormState> forgotPassFormKey = GlobalKey();
  final GlobalKey<FormState> updatePassFormKey = GlobalKey();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode otpFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    emailFocusNode.requestFocus();
    super.onInit();
  }

  Future<void> sendOtpOnTap(AppLocalizations? locale) async {
    if (sendOtpLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
    }
    if (!forgotPassFormKey.currentState!.validate()) {
      return;
    }
    sendOtpLoading(true);
    final result = await forgotPasswordRepo.sendOtp(email: email.text.trim());
    sendOtpLoading(false);
    if (result) {
      showToast('OTP send to ${email.text}');
      Get.toNamed(RouterPaths.otpScreen);
      otpFocusNode.requestFocus();
    }
  }

  Future<void> verifyOtpOnTap(AppLocalizations? locale) async {
    if (verifyOtpLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
    }
    if (otpController.text.isEmpty || otpController.text.length < 5) {
      showToast('${locale?.invalidOtp}');
      return;
    }
    verifyOtpLoading(true);
    final result = await forgotPasswordRepo.verifyOtp(email: email.text.trim(), otpCode: int.parse(otpController.text));
    verifyOtpLoading(false);
    if (result) {
      Get.toNamed(RouterPaths.updatePassword);
      passwordFocusNode.requestFocus();
    }
  }

  Future<void> resendOtpOnTap(AppLocalizations? locale) async {
    if (resendOtpLoading.value || verifyOtpLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
    }
    resendOtpLoading(true);
    final result = await forgotPasswordRepo.resendOtp(
      email: email.text.trim(),
      otpType: ResendOtpType.forgotPassword.value,
    );
    resendOtpLoading(false);
    if (result) {
      otpController.clear();
      otpFocusNode.requestFocus();
      showToast('OTP send to ${email.text}');
    }
  }

  Future<void> updatePasswordOnTap(AppLocalizations? locale) async {
    if (updatePassLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
    }
    if (!updatePassFormKey.currentState!.validate()) {
      return;
    }
    if (password.text != confirmPassword.text) {
      showToast('${locale?.password} ${locale?.doesNotMatch.toLowerCase()}');
      return;
    }
    updatePassLoading(true);
    final result = await forgotPasswordRepo.updatePassword(email: email.text.trim(), password: password.text);
    updatePassLoading(false);
    if (result) {
      showToast('${locale?.password} ${locale?.successfullyUpdated.toLowerCase()}');
      Get.until((route) => route.settings.name == RouterPaths.login);
    }
  }

  @override
  void onClose() {
    emailFocusNode.dispose();
    otpFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }
}
