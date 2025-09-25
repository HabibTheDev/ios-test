import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/app_color.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../controller/forgot_password_controller.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

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
                    ).paddingOnly(bottom: 60),

                    //Update message
                    TitleText(text: '${locale?.updatePassword}'),
                    const HeightBox(height: 4),
                    SmallText(
                      text: '${locale?.updatePassMgs}',
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 20),

                    //Password
                    TextFormFieldWidget(
                      controller: controller.password,
                      focusNode: controller.passwordFocusNode,
                      hintText: '${locale?.password}',
                      required: true,
                      obscure: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 20,
                    ).paddingOnly(bottom: 10),

                    //Re-enter Password
                    TextFormFieldWidget(
                      controller: controller.confirmPassword,
                      hintText: '${locale?.reEnterPassword}',
                      required: true,
                      obscure: true,
                      textInputType: TextInputType.visiblePassword,
                      maxLength: 20,
                    ).paddingOnly(bottom: 20),

                    //Save Changes
                    Obx(
                      () => SolidTextButton(
                        onTap: () => controller.updatePasswordOnTap(locale),
                        isLoading: controller.updatePassLoading.value,
                        buttonText: '${locale?.save} ${locale?.changes.toLowerCase()}',
                      ),
                    ),

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
