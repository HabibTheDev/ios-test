import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/text_widget.dart';
import '../../controller/inspection_capture_controller.dart';
import '../../model/car_side_model.dart';
import 'capture_button.dart';
import 'capture_close_button.dart';
import 'capture_complete_widget.dart';
import 'capture_image_instruction.dart';
import 'next_button.dart';
import 'restart_button.dart';

class CaptureControlWidget extends StatelessWidget {
  const CaptureControlWidget({
    super.key,
    required this.controller,
    required this.screenTitle,
    required this.issueTitle,
    required this.returnScreen,
  });
  final InspectionCaptureController controller;
  final String screenTitle;
  final String issueTitle;
  final String returnScreen;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Car-side name & count
            Positioned(
              left: 16,
              top: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BodyText(
                    text: '${controller.carExteriorImageFiles.length} / ${CarSideModel.carSides.length}',
                    textColor: Colors.white,
                  ),
                  BodyText(
                    text: CarSideModel
                        .carSides[
                            controller.carExteriorImageFiles.length == 4 ? 3 : controller.carExteriorImageFiles.length]
                        .side,
                    textColor: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),

            // Close Button
            Positioned(
              right: 16,
              top: 16,
              child: CaptureCloseButton(
                onTap: () {
                  controller.resetCapturedFile();
                  Get.back();
                },
              ),
            ),

            // Capture & Next button
            Positioned(
              right: 16,
              child: controller.showInstruction.value
                  ? NextButton(
                      onTap: () => controller.nextButtonOnTap(
                        screenTitle: screenTitle,
                        issueTitle: issueTitle,
                        returnScreen: returnScreen,
                      ),
                    )
                  : CaptureButton(
                      onTap: () => controller.captureButtonOnTap(),
                    ),
            ),

            // Reset Button
            Positioned(
              right: 8,
              bottom: 8,
              child: RestartButton(
                onTap: () => controller.resetCapturedFile(),
              ),
            ),

            // Car side change instruction

            Positioned(
              bottom: 0,
              child: controller.showExteriorSideChangeInstruction()
                  ? CaptureImageInstruction(controller: controller)
                  : controller.carExteriorImageFiles.length < controller.totalExteriorCarSide
                      ? SvgPicture.asset(
                          CarSideModel
                              .carSides[controller.carExteriorImageFiles.length == 4
                                  ? 3
                                  : controller.carExteriorImageFiles.length]
                              .svgAsset,
                        )
                      : const SizedBox.shrink(),
            ),

            // Capture complete widget
            if (controller.showCompleteButton()) const CaptureCompleteWidget()
          ],
        ),
      ),
    );
  }
}
