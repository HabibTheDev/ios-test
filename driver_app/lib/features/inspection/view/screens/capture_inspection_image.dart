import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/services/local/orientation_service.dart';
import '../../controller/inspection_capture_controller.dart';
import '../widgets/capture_control_widget.dart';

class CaptureInspectionImage extends StatefulWidget {
  const CaptureInspectionImage({super.key});

  @override
  State<CaptureInspectionImage> createState() => _CaptureInspectionImageState();
}

class _CaptureInspectionImageState extends State<CaptureInspectionImage> {
  late InspectionCaptureController controller;
  late OrientationService _orientationService;

  @override
  void initState() {
    super.initState();
    try {
      controller = Get.find();
    } catch (e) {
      controller = Get.put(InspectionCaptureController());
    }
    _orientationService = OrientationService();
    _orientationService.hideStatusBar();
    _orientationService.landscapeOrientation();
    WidgetsBinding.instance.addPostFrameCallback((value) {
      controller.initializeCamera();
    });
  }

  @override
  void dispose() {
    _orientationService.showStatusBar();
    _orientationService.portraitOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    // Retrieve arguments
    final String screenTitle = Get.arguments?[ArgumentsKey.title] ?? 'Report an issue';
    final issueTitle = Get.arguments?[ArgumentsKey.issueTitle];
    final String returnScreen = Get.arguments?[ArgumentsKey.returnScreen] ?? RouterPaths.drawer;

    return GetBuilder<InspectionCaptureController>(builder: (controller) {
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
                child: RotatedBox(
                  quarterTurns: 1,
                  child: Obx(
                    () => CameraPreview(controller.cameraController.value!),
                  ),
                ),
              ),
            CaptureControlWidget(
              controller: controller,
              screenTitle: screenTitle,
              issueTitle: issueTitle,
              returnScreen: returnScreen,
            )
          ],
        ),
      );
    });
  }
}
