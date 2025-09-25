part of 'widget_imports.dart';

class ChangePassOtpScreen extends StatelessWidget {
  const ChangePassOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.find();
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: Scaffold(
        backgroundColor: AppColors.lightCardColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: const Icon(Icons.key, size: 20, color: AppColors.lightAppBarIconColor),
          title: ButtonText(text: '${locale?.changePassword}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const HeightBox(height: 40),

                //OTP message
                TitleText(text: '${locale?.enterCode}'),
                const HeightBox(height: 4),
                SmallText(
                  text: '${locale?.otpMessage}',
                  textColor: AppColors.lightSecondaryTextColor,
                  textAlign: TextAlign.center,
                ),
                const HeightBox(height: 40),

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
                ),
                const HeightBox(height: 40),

                // Verify Button
                Obx(
                  () => SolidTextButton(
                      onTap: () => controller.finishButtonOnTap(locale),
                      isLoading: controller.finishLoading.value,
                      buttonText: '${locale?.finish}'),
                ),

                // Resend Code
                Obx(
                  () => OutlineTextButton(
                      onTap: () => controller.resendOtp(locale),
                      isLoading: controller.resendOtpLoading.value,
                      buttonText: '${locale?.resendCode}'),
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
