import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';
import 'package:pinput/pinput.dart';

import '../../../core/constants/app_color.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../controller/forgot_password_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeightBox(height: 40),

                  //Logo
                  const LogoPrimary(height: 24, width: 136).paddingOnly(bottom: 60),

                  //OTP message
                  TitleText(text: '${locale?.enterCode}'),
                  const HeightBox(height: 4),
                  SmallText(
                    text: '${locale?.otpMgs}',
                    textColor: AppColors.lightSecondaryTextColor,
                    textAlign: TextAlign.center,
                  ).paddingOnly(bottom: 20),

                  //OTP field
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      length: 5,
                      controller: controller.otpController,
                      focusNode: controller.otpFocusNode,
                      separatorBuilder: (index) => const SizedBox(width: 8),
                      hapticFeedbackType: HapticFeedbackType.heavyImpact,
                      onCompleted: (pin) => debugPrint('onCompleted: $pin'),
                      defaultPinTheme: PinTheme(
                          height: 60,
                          width: 60,
                          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(6)),
                              border: Border.all(color: AppColors.lightTextFieldHintColor, width: 1))),
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
                  ).paddingOnly(bottom: 20),

                  //Verify Button
                  Obx(
                    () => SolidTextButton(
                        onTap: () => controller.verifyOtpOnTap(locale),
                        isLoading: controller.verifyOtpLoading.value,
                        buttonText: '${locale?.verify}'),
                  ),

                  Obx(
                    () => OutlineTextButton(
                        onTap: () => controller.resendOtpOnTap(locale),
                        isLoading: controller.resendOtpLoading.value,
                        buttonText: '${locale?.resend} ${locale?.code.toLowerCase()}'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
