import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/logo_primary.dart';
import '../../../shared/widgets/solid_text_button.dart';
import '../../../shared/widgets/text_field_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/login_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Form(
              key: controller.loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const HeightBox(height: 40),

                  //Logo
                  const LogoPrimary(height: 24, width: 136).paddingOnly(bottom: 60),

                  //Login message
                  const TitleText(text: AppString.login).paddingOnly(bottom: 4),
                  const SmallText(
                    text: 'Log in with your User ID password',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 20),

                  //Email
                  TextFormFieldWidget(
                    controller: controller.userId,
                    hintText: AppString.userId,
                    required: true,
                    textInputType: TextInputType.number,
                  ).paddingOnly(bottom: 10),

                  // Password
                  Container(
                    decoration: const BoxDecoration(
                      color: AppColors.lightTextFieldFillColor,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: controller.password,
                            hintText: 'Password',
                            required: true,
                            obscure: true,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          height: 24,
                          width: 1,
                          color: Colors.grey.withAlpha(127),
                        ),
                        InkWell(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          onTap: () => controller.biometricLogin(),
                          child: SvgPicture.asset(Assets.assetsSvgScanFaceId)
                              .paddingSymmetric(horizontal: 10, vertical: 12),
                        ).paddingOnly(left: 8)
                      ],
                    ),
                  ).paddingOnly(bottom: 20),

                  //Login Button
                  Obx(
                    () => SolidTextButton(
                        onTap: () => controller.login(),
                        isLoading: controller.functionLoading.value,
                        buttonText: AppString.login),
                  ).paddingOnly(bottom: 22),

                  //Forgot password
                  InkWell(
                      onTap: () => Get.toNamed(RouterPaths.forgotPassword),
                      child: const BodyText(
                        text: 'Forgot password',
                        textColor: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      )).paddingOnly(bottom: 30),

                  // Don\'t have an account?
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: AppColors.lightTextColor, fontSize: 14),
                      children: [
                        const TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(
                            text: AppString.signUp,
                            style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap = () => Get.back()),
                      ],
                    ),
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
