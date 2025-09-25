import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/inspection_capture_controller.dart';
import '../../model/car_side_model.dart';
import '../../model/inspection_arguments_model.dart';

import 'capture_button.dart';
import 'capture_close_button.dart';
import 'capture_complete_widget.dart';
import 'exterior_capture_instruction.dart';
import 'next_button.dart';
import 'restart_button.dart';

class CaptureControlWidget extends StatelessWidget {
  const CaptureControlWidget({
    super.key,
    required this.controller,
    required this.inspectionArgumentsModel,
  });
  final InspectionCaptureController controller;
  final InspectionArgumentsModel? inspectionArgumentsModel;

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
                    text: inspectionArgumentsModel?.inspectionCaptureTypeEnum == InspectionCaptureTypeEnum.carExterior
                        ? '${controller.carExteriorImageFiles.length} / ${CarSideModel.carSides.length}'
                        : '${controller.getCapturedCount(type: inspectionArgumentsModel?.inspectionCaptureTypeEnum)} / 1',
                    textColor: Colors.white,
                  ),
                  BodyText(
                    text: inspectionArgumentsModel?.inspectionCaptureTypeEnum == InspectionCaptureTypeEnum.carExterior
                        ? CarSideModel
                            .carSides[controller.carExteriorImageFiles.length == 4
                                ? 3
                                : controller.carExteriorImageFiles.length]
                            .side
                        : inspectionArgumentsModel?.inspectionCaptureTypeEnum?.value ??
                            '${AppLocalizations.of(context)?.notAvailable}',
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
                  controller.resetCapturedFile(type: inspectionArgumentsModel?.inspectionCaptureTypeEnum);
                  if (inspectionArgumentsModel?.returnScreen == RouterPaths.entryInspection) {
                    Get.until((route) => route.settings.name == RouterPaths.inspectionCaptureType);
                  } else {
                    Get.back();
                  }
                },
              ),
            ),

            // Capture & Next button
            Positioned(
              right: 16,
              child: controller.showInstruction.value
                  ? NextButton(
                      onTap: () => controller.nextButtonOnTap(inspectionArgumentsModel: inspectionArgumentsModel),
                    )
                  : CaptureButton(
                      onTap: () =>
                          controller.captureButtonOnTap(type: inspectionArgumentsModel?.inspectionCaptureTypeEnum),
                    ),
            ),

            // Reset Button
            Positioned(
              right: 8,
              bottom: 8,
              child: RestartButton(
                onTap: () => controller.resetCapturedFile(type: inspectionArgumentsModel?.inspectionCaptureTypeEnum),
              ),
            ),

            // Car side change instruction
            if (inspectionArgumentsModel?.inspectionCaptureTypeEnum == InspectionCaptureTypeEnum.carExterior)
              Positioned(
                bottom: 0,
                child: controller.showExteriorSideChangeInstruction()
                    ? ExteriorCaptureInstruction(controller: controller)
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
            if (controller.showCompleteButton(type: inspectionArgumentsModel?.inspectionCaptureTypeEnum))
              const CaptureCompleteWidget()
          ],
        ),
      ),
    );
  }
}
