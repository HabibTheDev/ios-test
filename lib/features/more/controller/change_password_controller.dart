import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/remote/change_password_repo.dart';
import '../../../shared/enums/enums.dart';
import '../../../features/more/controller/profile_controller.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/utils/app_toast.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordController({required this.changePassRepo});
  final ChangePasswordRepo changePassRepo;

  final RxBool changePassLoading = false.obs;
  final RxBool resendOtpLoading = false.obs;
  final RxBool finishLoading = false.obs;

  final GlobalKey<FormState> changePassFormKey = GlobalKey();
  final FocusNode currentPasswordFocusNode = FocusNode();
  final FocusNode otpFocusNode = FocusNode();

  final TextEditingController currentPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController reEnterNewPassword = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  late String? email;

  @override
  void onInit() {
    super.onInit();
    currentPasswordFocusNode.requestFocus();

    // Get email from profile controller
    final ProfileController profileController = Get.find();
    email = profileController.employeeModel.value?.email;
    debugPrint('Email Address: $email');
  }

  @override
  void onClose() {
    currentPasswordFocusNode.dispose();
    otpFocusNode.dispose();
    super.onClose();
  }

  Future<void> changePassword(AppLocalizations? locale) async {
    if (changePassLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
    }
    if (!changePassFormKey.currentState!.validate()) {
      return;
    }
    if (newPassword.text != reEnterNewPassword.text) {
      showToast('Password doesn\'t match');
      return;
    }
    if (currentPassword.text == newPassword.text) {
      showToast('New password must be different');
      return;
    }
    if (email == null) {
      showToast('Email not found');
      return;
    }
    changePassLoading(true);
    final result = await changePassRepo.changePassword(
      email: email!,
      password: currentPassword.text,
      newPassword: newPassword.text,
    );
    changePassLoading(false);
    if (result) {
      showToast('OTP send to $email');
      Get.toNamed(RouterPaths.changePasswordOtp);
      otpFocusNode.requestFocus();
    }
  }

  Future<void> finishButtonOnTap(AppLocalizations? locale) async {
    if (finishLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
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
    final result = await changePassRepo.verifyOtp(email: email!, otpCode: int.parse(otpController.text));
    finishLoading(false);
    if (result) {
      showToast('Password changed successfully');
      Get.until((route) => route.settings.name == RouterPaths.drawer);
    }
  }

  Future<void> resendOtp(AppLocalizations? locale) async {
    if (resendOtpLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
    }
    if (email == null) {
      showToast('Email not found');
      return;
    }

    resendOtpLoading(true);
    final result = await changePassRepo.resendOtp(email: email!, otpType: ResendOtpType.changePassword.value);
    resendOtpLoading(false);
    if (result) {
      showToast('OTP resend to $email');
    }
  }
}
