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

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

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
              key: controller.updatePassFormKey,
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

                  //Update message
                  const TitleText(text: 'Update Password'),
                  const HeightBox(height: 4),
                  const SmallText(
                    text: 'Enter and confirm your new password',
                    textColor: AppColors.lightSecondaryTextColor,
                    textAlign: TextAlign.center,
                  ),
                  const HeightBox(height: 20),

                  //Password
                  TextFormFieldWidget(
                    controller: controller.password,
                    hintText: AppString.password,
                    required: true,
                    obscure: true,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const HeightBox(height: 10),

                  //Re-enter Password
                  TextFormFieldWidget(
                    controller: controller.confirmPassword,
                    hintText: AppString.reEnterPassword,
                    required: true,
                    obscure: true,
                    textInputType: TextInputType.visiblePassword,
                  ),
                  const HeightBox(height: 20),

                  //Save Button
                  Obx(
                    () => SolidTextButton(
                      onTap: () => controller.updatePasswordOnTap(),
                      isLoading: controller.updatePassLoading.value,
                      buttonText: 'Save Changes',
                    ),
                  ),

                  OutlineTextButton(
                      onTap: () => Get.back(), buttonText: 'Go Back'),
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
