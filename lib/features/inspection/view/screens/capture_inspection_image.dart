import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/repository/local/media_repo.dart';
import '../../../../shared/repository/local/orientation_repo.dart';
import '../../../../shared/repository/remote/inspection_repo.dart';
import '../../../../shared/services/service_locator.dart';
import '../../controller/inspection_capture_controller.dart';
import '../../model/inspection_arguments_model.dart';
import '../widgets/capture_control_widget.dart';

class CaptureInspectionImage extends StatefulWidget {
  const CaptureInspectionImage({super.key});

  @override
  State<CaptureInspectionImage> createState() => _CaptureInspectionImageState();
}

class _CaptureInspectionImageState extends State<CaptureInspectionImage> {
  late InspectionCaptureController controller;
  late InspectionArgumentsModel? inspectionArgumentsModel;
  late OrientationRepo _orientationRepo;

  @override
  void initState() {
    super.initState();

    if (Get.isRegistered<InspectionCaptureController>()) {
      controller = Get.find();
    } else {
      controller = Get.put(
        InspectionCaptureController(
          inspectionRepo: ServiceLocator.get<InspectionRepo>(),
          mediaRepo: ServiceLocator.get<MediaRepo>(),
        ),
      );
    }
    _orientationRepo = ServiceLocator.get<OrientationRepo>();
    _orientationRepo.hideStatusBar();
    _orientationRepo.landscapeOrientation();

    // Retrieve arguments
    inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];

    WidgetsBinding.instance.addPostFrameCallback(
      (value) => controller.init(inspectionArgumentsModel: inspectionArgumentsModel),
    );
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
    return GetBuilder<InspectionCaptureController>(
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
              CaptureControlWidget(controller: controller, inspectionArgumentsModel: inspectionArgumentsModel),
            ],
          ),
        );
      },
    );
  }
}
