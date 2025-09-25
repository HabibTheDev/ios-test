import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/widgets/country_code_dropdown.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/loading_widget.dart';
import '../../../shared/widgets/logo_primary.dart';
import '../../../shared/widgets/solid_text_button.dart';
import '../../../shared/widgets/text_field_widget.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/signup_controller.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Form(
              key: controller.signUpFormKey,
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

                  //SignUp Message
                  const TitleText(text: AppString.signUp).paddingOnly(bottom: 4),

                  const SmallText(
                    text: 'Sign up and set up your password',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 20),

                  //Name
                  TextFormFieldWidget(
                    controller: controller.name,
                    hintText: AppString.name,
                    required: true,
                    textInputType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                  ).paddingOnly(bottom: 10),

                  //Phone
                  Container(
                    decoration: const BoxDecoration(
                        color: AppColors.lightTextFieldFillColor, borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Obx(
                          () => controller.isLoading.value
                              ? const CenterLoadingWidget()
                              : CountryCodeDropdown(
                                  items: controller.countries,
                                  selectedValue: controller.selectedCountryCode.value,
                                  hintText: 'Select',
                                  onChanged: (value) {
                                    controller.changeCountryCode(value);
                                  },
                                ),
                        ),
                        //Divider
                        Container(
                          height: 24,
                          width: 1,
                          decoration: BoxDecoration(color: Colors.grey.withOpacity(0.5)),
                        ).paddingOnly(left: 8),
                        Expanded(
                          child: TextFormFieldWidget(
                            controller: controller.phone,
                            hintText: AppString.phoneNumber,
                            maxLength: 15,
                            required: true,
                            textInputType: TextInputType.phone,
                          ),
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 10),

                  //User ID
                  TextFormFieldWidget(
                    controller: controller.userId,
                    hintText: AppString.userId,
                    required: true,
                    textInputType: TextInputType.number,
                  ).paddingOnly(bottom: 10),

                  //Password
                  TextFormFieldWidget(
                    controller: controller.password,
                    hintText: AppString.password,
                    required: true,
                    obscure: true,
                    textInputType: TextInputType.visiblePassword,
                  ).paddingOnly(bottom: 10),

                  //Re-enter Password
                  TextFormFieldWidget(
                    controller: controller.confirmPassword,
                    hintText: AppString.reEnterPassword,
                    required: true,
                    obscure: true,
                    textInputType: TextInputType.visiblePassword,
                  ).paddingOnly(bottom: 20),

                  //SignUp Button
                  Obx(
                    () => SolidTextButton(
                        onTap: () => controller.signUp(),
                        isLoading: controller.functionLoading.value,
                        buttonText: AppString.signUp),
                  ).paddingOnly(bottom: 30),

                  //Have an account?
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: AppColors.lightTextColor, fontSize: 14),
                      children: [
                        const TextSpan(text: 'Have an account? '),
                        TextSpan(
                            text: AppString.login,
                            style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouterPaths.login)),
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
