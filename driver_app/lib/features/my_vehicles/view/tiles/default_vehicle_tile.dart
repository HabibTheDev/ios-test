import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/progress_bar_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/vehicle_model.dart';
import '../widgets/image_stack_widget.dart';
import '../widgets/my_vehicle_car_details_widget.dart';

class DefaultVehicleTile extends StatelessWidget {
  const DefaultVehicleTile({super.key, required this.myVehicleModel});
  final VehicleModel myVehicleModel;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              // Car image & brand
              MyVehicleCarDetailsWidget(height: 110.h)
                  .paddingOnly(bottom: 20.h, left: myVehicleModel.status == MyVehicleState.inProgress.value ? 20 : 0),
              const Spacer(),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //Driver & Contract ID
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyText(
                            text: '#ID20034',
                            fontWeight: FontWeight.w700,
                          ),
                          ExtraSmallText(
                            text: 'Contract ID',
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.lightSecondaryTextColor,
                          )
                        ],
                      )),
                      Expanded(
                        child: myVehicleModel.status == MyVehicleState.awaiting.value
                            ? ImageStack(
                                onTap: () => Get.toNamed(RouterPaths.additionalDrivers),
                                imageUrls: AppList.dummyImageList)
                            : InkWell(
                                onTap: () => Get.toNamed(RouterPaths.additionalDrivers),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ButtonText(
                                      text: 'Add driver ',
                                      textColor: AppColors.primaryColor,
                                    ),
                                    Icon(
                                      Icons.add,
                                      color: AppColors.primaryColor,
                                      size: 18,
                                    )
                                  ],
                                ),
                              ),
                      ),
                    ],
                  ).paddingOnly(bottom: 20.h),

                  // Total Divers
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ExtraSmallText(text: 'Total Divers', fontWeight: FontWeight.w600),
                      ExtraSmallText(
                          text: '3/5', fontWeight: FontWeight.w500, textColor: AppColors.lightSecondaryTextColor),
                    ],
                  ).paddingOnly(bottom: 4),
                  ProgressBarWidget(
                    progressValue: 0.7,
                    color: AppColors.primaryColor.withOpacity(0.4),
                  ).paddingOnly(bottom: 16.h),

                  // Total driven
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ExtraSmallText(text: 'Total Driven', fontWeight: FontWeight.w600),
                      ExtraSmallText(
                          text: '30% (58.1 M) / 200 M',
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.lightSecondaryTextColor),
                    ],
                  ).paddingOnly(bottom: 4),
                  const ProgressBarWidget(progressValue: 0.3).paddingOnly(bottom: 16.h),

                  // Extra mileage
                  const CarInfoTile(titleKey: 'Extra mileage', titleValue: '0 miles').paddingOnly(bottom: 16.h),
                ],
              ).paddingSymmetric(horizontal: 20),

              // Button
              SolidTextButton(onTap: () => Get.toNamed(RouterPaths.startDriving), buttonText: 'Start driving')
                  .paddingSymmetric(horizontal: 20),

              OutlineTextButton(
                      onTap: () => Get.toNamed(
                            RouterPaths.requestMaintenanceExchange,
                            arguments: {ArgumentsKey.returnScreen: RouterPaths.drawer},
                          ),
                      buttonText: 'Request')
                  .paddingSymmetric(horizontal: 20),
            ],
          ).paddingSymmetric(vertical: 20),

          // Attention
          if (myVehicleModel.status == MyVehicleState.inProgress.value)
            Positioned(
              left: -3,
              top: 26,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: const BoxDecoration(
                    color: AppColors.warningColor, borderRadius: BorderRadius.all(Radius.circular(2))),
                child: const BodyText(
                  text: 'Attention',
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.lightCardColor,
                ),
              ),
            )
        ],
      ),
    ).paddingSymmetric(horizontal: 10);
  }
}
