import 'package:employee_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/repository/local/orientation_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../../inspection/view/widgets/capture_button.dart';
import '../../../inspection/view/widgets/capture_close_button.dart';
import '../../../inspection/view/widgets/capture_complete_widget.dart';
import '../../../inspection/view/widgets/next_button.dart';
import '../../../inspection/view/widgets/restart_button.dart';
import '../../controller/verify_vin_controller.dart';
import '../../../../features/inspection/model/inspection_arguments_model.dart';
import '../../../../shared/widgets/widget_imports.dart';

class CaptureVin extends StatefulWidget {
  const CaptureVin({super.key});

  @override
  State<CaptureVin> createState() => _CaptureVinState();
}

class _CaptureVinState extends State<CaptureVin> {
  late VerifyVinController controller;
  late InspectionArgumentsModel? inspectionArgumentsModel;
  late OrientationRepo _orientationRepo;

  @override
  void initState() {
    super.initState();
    controller = Get.find();

    _orientationRepo = ServiceLocator.get<OrientationRepo>();
    _orientationRepo.hideStatusBar();
    _orientationRepo.landscapeOrientation();

    // Retrieve arguments
    inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];

    WidgetsBinding.instance.addPostFrameCallback((value) => controller.initializeCamera());
  }

  @override
  void dispose() {
    _orientationRepo.showStatusBar();
    _orientationRepo.portraitOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final AppLocalizations? locale = AppLocalizations.of(context);
    return GetBuilder<VerifyVinController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            alignment: Alignment.center,
            children: [
              // Camera preview widget
              if (controller.cameraController.value != null)
                SizedBox(
                  height: size.height,
                  width: size.height * (16 / 9),
                  child: Obx(() => CameraPreview(controller.cameraController.value!)),
                ),
              _buildCaptureControls(locale),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCaptureControls(AppLocalizations? locale) {
    return Obx(
      () => SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Title
            Positioned(
              left: 16,
              top: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BodyText(text: '${controller.getCapturedCount()} / 1', textColor: Colors.white),
                  BodyText(text: 'VIN Sticker', textColor: Colors.white, fontWeight: FontWeight.bold),
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
                        inspectionArgumentsModel: inspectionArgumentsModel,
                        locale: locale,
                      ),
                    )
                  : CaptureButton(onTap: () => controller.captureButtonOnTap()),
            ),

            // Reset Button
            Positioned(right: 8, bottom: 8, child: RestartButton(onTap: () => controller.resetCapturedFile())),

            // Capture complete widget
            if (controller.showCompleteButton()) const CaptureCompleteWidget(),
          ],
        ),
      ),
    );
  }
}
