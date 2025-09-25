// part of 'widget_imports.dart';

// class RegularCarDetailsWidget extends StatelessWidget {
//   const RegularCarDetailsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CardWidget(
//         contentPadding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CarDetailsWidget(
//               imageUrl:
//                   'https://e7.pngegg.com/pngimages/291/917/png-clipart-car-car-white-thumbnail.png',
//               carBrandImageUrl: null,
//               model: 'LaND 2',
//               make: 'LaND 2',
//               vin: 'OSCLR000284A7CD23',
//               location: 'California',
//               license: 'Dummy data',
//               carColor: 'Dummy data',
//             ),
//             const AppDivider().paddingSymmetric(vertical: 12),
//             const BorderCardTile(
//               leading: Icon(
//                 Icons.handyman,
//                 color: AppColors.primaryColor,
//                 size: 20,
//               ),
//               title: 'Damage repairing',
//               subTitle: 'Maintenance type',
//             ).paddingOnly(bottom: 10),
//             const BorderCardTile(
//               leading: Icon(
//                 Icons.watch_later,
//                 color: AppColors.primaryColor,
//                 size: 20,
//               ),
//               title: '03 May 2023',
//               secondaryTitle: '12:04 PM',
//               subTitle: 'Maintenance time',
//             ).paddingOnly(bottom: 20),
//             const BodyText(
//                     text:
//                         'Make sure to check the vehicle first before starting your main task.')
//                 .paddingOnly(bottom: 20),
//             OutlineButton(
//                 onTap: () {
//                   Get.toNamed(RouterPaths.carDirection);
//                 },
//                 child: const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.location_on_rounded,
//                       color: AppColors.primaryColor,
//                       size: 18,
//                     ),
//                     ButtonText(
//                       text: ' Car Direction',
//                       textColor: AppColors.primaryColor,
//                     )
//                   ],
//                 ))
//           ],
//         )).paddingOnly(bottom: 10);
//   }
// }
