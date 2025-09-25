import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/logo_primary.dart';
import '../../../shared/widgets/outline_text_button.dart';
import '../../../shared/widgets/solid_text_button.dart';
import '../../../shared/widgets/text_field_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/forgot_password_controller.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.find();
    return Scaffold(
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
                  const LogoPrimary(
                    height: 24,
                    width: 136,
                  ),
                  const HeightBox(height: 60),

                  //Forgot message
                  const TitleText(text: 'Forgot Password'),
                  const HeightBox(height: 4),
                  const SmallText(
                    text: 'Enter your email to receive the verification code',
                    textColor: AppColors.lightSecondaryTextColor,
                  ),
                  const HeightBox(height: 20),

                  //Email
                  TextFormFieldWidget(
                    controller: controller.email,
                    hintText: AppString.email,
                    required: true,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const HeightBox(height: 20),

                  //Send OTP Button
                  Obx(
                    () => SolidTextButton(
                        onTap: () => controller.sendOtpOnTap(),
                        isLoading: controller.sendOtpLoading.value,
                        buttonText: 'Send OTP'),
                  ),

                  OutlineTextButton(
                    onTap: () => Get.back(),
                    buttonText: 'Go Back',
                  ),
                  const HeightBox(height: 22),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
