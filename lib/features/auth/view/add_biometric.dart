import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../controller/biometric_controller.dart';

class AddBiometric extends StatelessWidget {
  const AddBiometric({super.key});

  @override
  Widget build(BuildContext context) {
    final BiometricController controller = Get.find();
    final locale = AppLocalizations.of(context);
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

                // Logo
                const LogoPrimary(height: 24, width: 136).paddingOnly(bottom: 60),

                // Add Biometric
                TitleText(text: '${locale?.addBiometric}').paddingOnly(bottom: 4),

                // Add Biometric Mgs
                SmallText(
                  text: '${locale?.biometricMgs}',
                  textAlign: TextAlign.center,
                  textColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(bottom: 20),

                // Face ID Logo
                SvgPicture.asset(Assets.assetsSvgFaceId).paddingOnly(bottom: 20),

                // Add
                Obx(() => SolidTextButton(
                    isLoading: controller.biometricLoading.value,
                    onTap: () => controller.addBiometricOnTap(locale),
                    buttonText: '${locale?.add}')),

                OutlineTextButton(onTap: () => Get.back(), buttonText: '${locale?.cancel}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
