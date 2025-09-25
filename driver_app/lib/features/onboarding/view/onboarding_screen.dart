import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../shared/widgets/text_widget.dart';
import '../controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find();
    return Scaffold(
      body: Center(
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.visible.value ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: BodyText(
              text: controller.strings[controller.currentIndex.value],
              textSize: 36,
              textColor: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
        ).paddingAll(16),
      ),
    );
  }
}
