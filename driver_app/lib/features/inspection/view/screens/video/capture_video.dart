// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../../core/constants/params_key.dart';
// import '../../../../../core/router/router_paths.dart';
// import '../../../../../shared/services/local/orientation_service.dart';
// import '../../../controller/video/capture_video_controller.dart';
// import '../../widgets/video/widget_imports.dart';

// class CaptureVideo extends StatefulWidget {
//   const CaptureVideo({super.key});
//   @override
//   State<CaptureVideo> createState() => _CaptureVideoState();
// }

// class _CaptureVideoState extends State<CaptureVideo> {
//   late CaptureVideoController controller;
//   late OrientationService _orientationService;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.find();
//     _orientationService = OrientationService();
//     _orientationService.hideStatusBar();
//     _orientationService.landscapeOrientation();
//   }

//   @override
//   void dispose() {
//     _orientationService.showStatusBar();
//     _orientationService.portraitOrientation();
//     controller.cameraController.value?.dispose();
//     controller.disposeAll();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Retrieve arguments
//     final String title = Get.arguments?[ArgumentsKey.title] ?? 'Processing video';
//     final String returnScreen =
//         Get.arguments?[ArgumentsKey.returnScreen] ?? RouterPaths.drawer;
//     final Size size = MediaQuery.of(context).size;

//     return GetBuilder<CaptureVideoController>(builder: (controller) {
//       return Scaffold(
//         backgroundColor: Colors.black,
//         body: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Camera preview widget
//             if (controller.cameraController.value != null)
//               SizedBox(
//                 height: size.height,
//                 width: size.height * (16 / 9),
//                 child: RotatedBox(
//                     quarterTurns: 1,
//                     child: Obx(() {
//                       return CameraPreview(controller.cameraController.value!);
//                     })),
//               ),
//             // Initial widget
//             VideoMaskWidget(
//               controller: controller,
//               title: title,
//               returnScreen: returnScreen,
//             )
//           ],
//         ),
//       );
//     });
//   }
// }
