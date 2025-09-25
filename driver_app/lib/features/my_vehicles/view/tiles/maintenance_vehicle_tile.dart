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

class MaintenanceVehicleTile extends StatelessWidget {
  const MaintenanceVehicleTile({super.key, required this.myVehicleModel});
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
              MyVehicleCarDetailsWidget(
                height: 110.h,
                titleTrailing: myVehicleModel.status == MyVehicleState.awaiting.value ? Icons.construction : null,
              ).paddingOnly(bottom: 20.h, top: myVehicleModel.status == MyVehicleState.inProgress.value ? 80.h : 0),

              // Spacer
              if (myVehicleModel.status == MyVehicleState.awaiting.value) const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const BodyText(
                            text: '#ID20034',
                            fontWeight: FontWeight.w700,
                          ).paddingOnly(right: 10),
                          CircleAvatar(
                            backgroundColor: myVehicleModel.status == MyVehicleState.awaiting.value
                                ? AppColors.awaitingColor
                                : AppColors.inProgressColor,
                            radius: 3,
                          ).paddingOnly(right: 4),
                          SmallText(
                            text: myVehicleModel.status == MyVehicleState.awaiting.value ? 'Awaiting' : 'In progress',
                            fontWeight: FontWeight.w600,
                            textColor: myVehicleModel.status == MyVehicleState.awaiting.value
                                ? AppColors.awaitingColor
                                : AppColors.inProgressColor,
                          )
                        ],
                      ),
                      const ExtraSmallText(
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
                            imageUrls: AppList.dummyImageList,
                          ).paddingOnly(right: 20)
                        : const SizedBox.shrink(),
                  ),
                ],
              ).paddingOnly(bottom: 20.h, left: 20),

              // Total Divers
              if (myVehicleModel.status == MyVehicleState.awaiting.value)
                Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ExtraSmallText(text: 'Total Divers', fontWeight: FontWeight.w600),
                        ExtraSmallText(
                            text: '3/5', fontWeight: FontWeight.w500, textColor: AppColors.lightSecondaryTextColor),
                      ],
                    ).paddingOnly(right: 20, bottom: 4),
                    ProgressBarWidget(
                      progressValue: 0.7,
                      color: AppColors.primaryColor.withOpacity(0.4),
                    ).paddingOnly(right: 20, bottom: 16.h),

                    // Total driven
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ExtraSmallText(text: 'Total driven', fontWeight: FontWeight.w600),
                        ExtraSmallText(
                            text: '30% (58.1 M) / 200 M',
                            fontWeight: FontWeight.w500,
                            textColor: AppColors.lightSecondaryTextColor),
                      ],
                    ).paddingOnly(right: 20, bottom: 4),
                    const ProgressBarWidget(progressValue: 0.3).paddingOnly(right: 20, bottom: 16.h),

                    const CarInfoTile(titleKey: 'Extra mileage', titleValue: '0 miles').paddingOnly(bottom: 16.h),
                  ],
                ).paddingOnly(left: 20),

              // Button
              if (myVehicleModel.status == MyVehicleState.awaiting.value)
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

          // Maintenance
          if (myVehicleModel.status == MyVehicleState.inProgress.value)
            Positioned(
              left: -3,
              top: 26,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: const BoxDecoration(
                    color: AppColors.inProgressColor, borderRadius: BorderRadius.all(Radius.circular(2))),
                child: const BodyText(
                  text: 'Maintenance',
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
