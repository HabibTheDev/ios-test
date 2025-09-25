import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/progress_bar_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/vehicle_model.dart';
import '../widgets/image_stack_widget.dart';
import '../widgets/my_vehicle_car_details_widget.dart';
import '../widgets/old_car_widget.dart';

class ExchangeVehicleTile extends StatelessWidget {
  const ExchangeVehicleTile({super.key, required this.myVehicleModel});

  final VehicleModel myVehicleModel;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                  child:
                      myVehicleModel.status == MyVehicleState.awaiting.value ? _awaitingWidget() : _inProgressWidget()),

              // Button
              SolidTextButton(
                      onTap: () {
                        if (myVehicleModel.status == MyVehicleState.awaiting.value) {
                          Get.toNamed(RouterPaths.startDriving);
                        } else {
                          Get.toNamed(RouterPaths.inspectionReport);
                        }
                      },
                      buttonText:
                          myVehicleModel.status == MyVehicleState.awaiting.value ? 'Start driving' : 'View inspection')
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

          // Exchange Label
          if (myVehicleModel.status == MyVehicleState.inProgress.value)
            Positioned(
              left: -3,
              top: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: const BoxDecoration(
                    color: AppColors.inProgressColor, borderRadius: BorderRadius.all(Radius.circular(2))),
                child: const BodyText(
                  text: 'Exchange',
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.lightCardColor,
                ),
              ),
            )
        ],
      ),
    ).paddingSymmetric(horizontal: 10);
  }

  Widget _awaitingWidget() => Column(
        children: [
          // Car image & brand
          MyVehicleCarDetailsWidget(
            height: 110.h,
            titleTrailing: Icons.swap_horizontal_circle_outlined,
          ).paddingOnly(bottom: 20.h),

          // Spacer
          const Spacer(),
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
                      const CircleAvatar(
                        backgroundColor: AppColors.awaitingColor,
                        radius: 3,
                      ).paddingOnly(right: 4),
                      const SmallText(
                        text: 'Awaiting',
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.awaitingColor,
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
                child: ImageStack(
                  onTap: () => Get.toNamed(RouterPaths.additionalDrivers),
                  imageUrls: AppList.dummyImageList,
                ),
              ),
            ],
          ).paddingOnly(left: 20, right: 20, bottom: 20.h),

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
                  ExtraSmallText(text: 'Total driven', fontWeight: FontWeight.w600),
                  ExtraSmallText(
                      text: '30% (58.1 M) / 200 M',
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.lightSecondaryTextColor),
                ],
              ).paddingOnly(bottom: 4),
              const ProgressBarWidget(progressValue: 0.3).paddingOnly(bottom: 16.h),

              const CarInfoTile(titleKey: 'Extra mileage', titleValue: '0 miles').paddingOnly(bottom: 16.h),
            ],
          ).paddingSymmetric(horizontal: 20),
        ],
      );

  Widget _inProgressWidget() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const OldCarDetailsWidget(),
          const Center(
            child: Icon(
              Icons.arrow_downward,
              color: AppColors.primaryColor,
              size: 28,
            ),
          ).paddingAll(16.h),
          const BasicCarDetailsWidget().paddingOnly(bottom: 20.h),
          Row(
            children: [
              const BodyText(
                text: '#ID20034',
                fontWeight: FontWeight.w700,
              ).paddingOnly(right: 10),
              const CircleAvatar(
                backgroundColor: AppColors.awaitingColor,
                radius: 3,
              ).paddingOnly(right: 4),
              const SmallText(
                text: 'In progress',
                fontWeight: FontWeight.w600,
                textColor: AppColors.inProgressColor,
              )
            ],
          ),
          const ExtraSmallText(
            text: 'Contract ID',
            fontWeight: FontWeight.w500,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 16.h)
        ],
      ).paddingSymmetric(horizontal: 20);
}
