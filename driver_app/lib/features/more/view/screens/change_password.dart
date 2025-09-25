import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/change_password_controller.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: const Icon(Icons.key,
            size: 20, color: AppColors.lightAppBarIconColor),
        title: const ButtonText(text: 'Change password'),
        titleSpacing: 0.0,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Form(
              key: controller.changePassFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Current Password
                  TextFormFieldWithLabel(
                    controller: controller.currentPassword,
                    labelText: 'Current password',
                    hintText: 'Enter password',
                    required: true,
                    obscure: true,
                    textInputType: TextInputType.visiblePassword,
                  ).paddingOnly(bottom: 16),

                  //New Password
                  TextFormFieldWithLabel(
                    controller: controller.newPassword,
                    hintText: 'Enter password',
                    labelText: 'New password',
                    required: true,
                    obscure: true,
                    textInputType: TextInputType.visiblePassword,
                  ).paddingOnly(bottom: 16),

                  //Re-enter New Password
                  TextFormFieldWithLabel(
                    controller: controller.reEnterNewPassword,
                    hintText: 'Enter password',
                    labelText: 'Re-enter password',
                    required: true,
                    obscure: true,
                    textInputType: TextInputType.visiblePassword,
                  ).paddingOnly(bottom: 20),

                  //Change Button
                  Obx(
                    () => SolidTextButton(
                        onTap: () => controller.changePassword(),
                        isLoading: controller.changePassLoading.value,
                        buttonText: 'Change'),
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
