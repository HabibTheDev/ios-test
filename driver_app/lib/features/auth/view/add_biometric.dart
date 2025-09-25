import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/widgets/heightbox.dart';
import '../../../shared/widgets/logo_primary.dart';
import '../../../shared/widgets/outline_text_button.dart';
import '../../../shared/widgets/solid_text_button.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/biometric_controller.dart';

class AddBiometric extends StatelessWidget {
  const AddBiometric({super.key});

  @override
  Widget build(BuildContext context) {
    final BiometricController controller = Get.find();
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

                //Add Biometric
                const TitleText(text: 'Add Biometric'),
                const HeightBox(height: 4),
                const SmallText(
                  text:
                      'Turn on biometric unlock as an additional security. You can also do this later.',
                  textAlign: TextAlign.center,
                  textColor: AppColors.lightSecondaryTextColor,
                ),
                const HeightBox(height: 20),

                //Face ID Logo
                SvgPicture.asset(Assets.assetsSvgFaceId),
                const HeightBox(height: 20),

                //Add
                Obx(
                  () => SolidTextButton(
                      isLoading: controller.biometricLoading.value,
                      onTap: () => controller.addBiometricOnTap(),
                      buttonText: 'Add'),
                ),

                OutlineTextButton(
                    onTap: () => Get.back(), buttonText: 'Cancel'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
