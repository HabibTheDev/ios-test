// part of 'widget_imports.dart';

// class RecordingInstructionWidget extends StatelessWidget {
//   const RecordingInstructionWidget({super.key, required this.controller});
//   final CaptureVideoController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Lottie.asset(
//           Assets.assetsLottieLeftArrowLottie,
//           height: 180,
//           fit: BoxFit.cover,
//         ),
//         Obx(() => TitleText(
//               text:
//                   'Go to ${CarSideModel.carSides[controller.carSideIndex.value].side}',
//               textAlign: TextAlign.center,
//               textColor: Colors.white,
//             ))
//       ],
//     );
//   }
// }
