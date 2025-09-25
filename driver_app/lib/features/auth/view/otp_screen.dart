import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/app_color.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/logo_primary.dart';
import '../../../shared/widgets/outline_text_button.dart';
import '../../../shared/widgets/solid_text_button.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/forgot_password_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
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

                //OTP message
                const TitleText(text: 'Enter Code'),
                const HeightBox(height: 4),
                const SmallText(
                  text:
                      'We have sent a verification code to your email. Please enter the code to update your password.',
                  textColor: AppColors.lightSecondaryTextColor,
                  textAlign: TextAlign.center,
                ),
                const HeightBox(height: 20),

                //OTP field
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Pinput(
                    length: 5,
                    controller: controller.otpController,
                    focusNode: controller.otpFocusNode,
                    separatorBuilder: (index) => const SizedBox(width: 8),
                    hapticFeedbackType: HapticFeedbackType.heavyImpact,
                    onCompleted: (pin) {
                      debugPrint('onCompleted: $pin');
                    },
                    defaultPinTheme: PinTheme(
                        height: 60,
                        width: 60,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            border: Border.all(
                                color: AppColors.lightTextFieldHintColor,
                                width: 1))),
                    cursor: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 9),
                          width: 22,
                          height: 1,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                const HeightBox(height: 20),

                //Verify Button
                Obx(
                  () => SolidTextButton(
                      onTap: () => controller.verifyOtpOnTap(),
                      isLoading: controller.verifyOtpLoading.value,
                      buttonText: 'Verify'),
                ),

                Obx(
                  () => OutlineTextButton(
                      onTap: () => controller.resendOtpOnTap(),
                      isLoading: controller.resendOtpLoading.value,
                      buttonText: 'Resend Code'),
                ),
                const HeightBox(height: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
