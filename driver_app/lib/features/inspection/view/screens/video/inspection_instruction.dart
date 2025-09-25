// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import '../../../../../core/constants/app_assets.dart';
// import '../../../../../core/constants/app_color.dart';
// import '../../../../../core/constants/app_list.dart';
// import '../../../../../core/constants/params_key.dart';
// import '../../../../../core/router/router_paths.dart';
// import '../../../../../shared/widgets/widget_imports.dart';
// import '../../tiles/ul_tile.dart';

// class InspectionInstruction extends StatelessWidget {
//   const InspectionInstruction({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Retrieve arguments
//     final String title =
//         Get.arguments?[ArgumentsKey.title] ?? 'Inspection Instruction';
//     final String returnScreen =
//         Get.arguments?[ArgumentsKey.returnScreen] ?? RouterPaths.drawer;

//     return Scaffold(
//       backgroundColor: AppColors.lightCardColor,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         leading: CircleAvatar(
//           radius: 12,
//           backgroundColor: Colors.transparent,
//           child: SvgPicture.asset(
//             Assets.assetsSvgCarSearch,
//           ),
//         ),
//         title: ButtonText(text: title),
//         titleSpacing: 0.0,
//         actions: [
//           IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))
//         ],
//       ),
//       body: _bodyUI(title: title, returnScreen: returnScreen),
//     );
//   }

//   Widget _bodyUI({required String title, required String returnScreen}) =>
//       SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //Instruction video
//             Container(
//               height: 200,
//               decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: const BorderRadius.all(Radius.circular(6))),
//             ).paddingOnly(bottom: 20),

//             Center(
//                 child: const TitleText(text: 'Capture 360° video')
//                     .paddingOnly(bottom: 16)),

//             Container(
//               padding: const EdgeInsets.all(12),
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: AppColors.lightBorderColor, width: 1),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(6),
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const BodyText(
//                     text: 'Steps',
//                     textColor: AppColors.lightSecondaryTextColor,
//                     fontWeight: FontWeight.bold,
//                   ).paddingOnly(bottom: 16),

//                   //Instructions
//                   ListView.separated(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: AppList.inspectionInstructionList.length,
//                     separatorBuilder: (context, index) =>
//                         const HeightBox(height: 10),
//                     itemBuilder: (context, index) => UlTile(
//                       title: AppList.inspectionInstructionList[index],
//                     ),
//                   ),
//                 ],
//               ),
//             ).paddingOnly(bottom: 16),
//             SolidTextButton(
//                 onTap: () {
//                   Get.toNamed(RouterPaths.captureVideo, arguments: {
//                     ArgumentsKey.title: title,
//                     ArgumentsKey.returnScreen: returnScreen
//                   });
//                 },
//                 buttonText: 'Start Capturing')
//           ],
//         ),
//       );
// }
