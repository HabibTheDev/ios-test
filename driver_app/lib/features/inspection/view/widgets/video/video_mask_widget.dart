// part of 'widget_imports.dart';

// class VideoMaskWidget extends StatelessWidget {
//   const VideoMaskWidget(
//       {super.key,
//       required this.controller,
//       required this.title,
//       required this.returnScreen});
//   final CaptureVideoController controller;
//   final String title;
//   final String returnScreen;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => Container(
//           height: double.infinity,
//           width: double.infinity,
//           color:
//               controller.videoState.value == VideoRecordingStateEnum.recording
//                   ? null
//                   : Colors.black54,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               // Car Side
//               Positioned(
//                 left: 16,
//                 top: 16,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     BodyText(
//                       text:
//                           '${controller.carSideIndex.value + 1} / ${CarSideModel.carSides.length}',
//                       textColor: Colors.white,
//                     ),
//                     BodyText(
//                       text: CarSideModel
//                           .carSides[controller.carSideIndex.value].side,
//                       textColor: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ],
//                 ),
//               ),

//               // Close Button
//               Positioned(
//                   right: 16,
//                   top: 16,
//                   child: InkWell(
//                       onTap: () {
//                         controller.disposeAll();
//                         Get.until(
//                             (route) => route.settings.name == returnScreen);
//                       },
//                       child: const CircleAvatar(
//                         backgroundColor: Colors.white24,
//                         child: Icon(
//                           Icons.close,
//                           color: Colors.white,
//                         ),
//                       ))),

//               // Startup Instruction
//               if (controller.videoState.value ==
//                   VideoRecordingStateEnum.awaiting)
//                 const TitleText(
//                   text: 'Start at Driver side',
//                   textColor: Colors.white,
//                 ),

//               // Capture Complete
//               if (controller.videoState.value ==
//                   VideoRecordingStateEnum.complete)
//                 const CaptureCompleteWidget(),

//               // Side Changing Instruction
//               if (controller.videoState.value ==
//                       VideoRecordingStateEnum.recording &&
//                   controller.showInstruction.value)
//                 RecordingInstructionWidget(controller: controller),

//               // Start Button
//               if (controller.videoState.value ==
//                   VideoRecordingStateEnum.awaiting)
//                 VideoRecordButton(
//                   onTap: () {
//                     controller.startButtonOnTap();
//                   },
//                 ),

//               // Complete Button
//               if (controller.videoState.value ==
//                   VideoRecordingStateEnum.complete)
//                 VideoCompleteButton(
//                   onTap: () {
//                     Get.toNamed(RouterPaths.videoProcessing, arguments: {
//                       ArgumentsKey.title: title,
//                       ArgumentsKey.returnScreen: returnScreen,
//                       ArgumentsKey.videoFile: controller.recordedVideoFile.value
//                     });
//                   },
//                 ),

//               // Car-Side Image
//               Positioned(
//                 bottom: 0,
//                 child: SvgPicture.asset(CarSideModel
//                     .carSides[controller.carSideIndex.value].svgAsset),
//               ),

//               // Timer section
//               if (controller.videoState.value ==
//                       VideoRecordingStateEnum.recording ||
//                   controller.videoState.value ==
//                       VideoRecordingStateEnum.complete)
//                 Positioned(
//                   left: 16,
//                   bottom: 16,
//                   child: ButtonText(
//                     text: '${controller.recordingDurationInSec.value}s',
//                     textColor: Colors.white,
//                   ),
//                 ),

//               // Restart Button
//               if (controller.videoState.value ==
//                   VideoRecordingStateEnum.complete)
//                 Positioned(
//                   right: 8,
//                   bottom: 8,
//                   child: IconButton(
//                     onPressed: () {
//                       controller.restartButtonOnTap();
//                     },
//                     icon: const Icon(
//                       Icons.restart_alt,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ));
//   }
// }
