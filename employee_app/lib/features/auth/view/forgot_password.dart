import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/app_color.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.find();
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: AppColors.lightCardColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Form(
                key: controller.forgotPassFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const HeightBox(height: 40),

                    //Logo
                    const LogoPrimary(height: 24, width: 136).paddingOnly(bottom: 60),

                    //Forgot message
                    TitleText(text: '${locale?.forgotPassword}').paddingOnly(bottom: 4),

                    SmallText(
                      text: '${locale?.forgotPassMgs}',
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 20),

                    //Email
                    TextFormFieldWidget(
                      controller: controller.email,
                      focusNode: controller.emailFocusNode,
                      hintText: '${locale?.email}',
                      required: true,
                      textInputType: TextInputType.emailAddress,
                    ).paddingOnly(bottom: 20),

                    //Send OTP Button
                    Obx(() => SolidTextButton(
                        onTap: () => controller.sendOtpOnTap(locale),
                        isLoading: controller.sendOtpLoading.value,
                        buttonText: '${locale?.sendOtp}')),

                    OutlineTextButton(onTap: () => Get.back(), buttonText: '${locale?.goBack}'),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
