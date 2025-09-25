import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/vehicle_model.dart';
import '../widgets/my_vehicle_car_details_widget.dart';

class NewContractVehicleTile extends StatelessWidget {
  const NewContractVehicleTile({super.key, required this.vehicle});
  final VehicleModel vehicle;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Car image & brand
              MyVehicleCarDetailsWidget(
                height: 110.h,
                carBrandImageUrl: vehicle.activeCarInfo?.brandLogo,
                make: vehicle.activeCarInfo?.make,
                model: vehicle.activeCarInfo?.model,
                year: vehicle.activeCarInfo?.year,
                imageUrl: vehicle.activeCarInfo?.images,
              ).paddingOnly(bottom: 20.h, top: 80.h),

              // ID & status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      BodyText(
                        text: '#${vehicle.contactId ?? 'N/A'}',
                        fontWeight: FontWeight.w700,
                      ).paddingOnly(right: 10),
                      CircleAvatar(
                        backgroundColor: vehicle.status == MyVehicleState.awaiting.value
                            ? AppColors.awaitingColor
                            : AppColors.inProgressColor,
                        radius: 3,
                      ).paddingOnly(right: 4),
                      SmallText(
                        text: vehicle.status == MyVehicleState.awaiting.value ? 'Awaiting' : 'In progress',
                        fontWeight: FontWeight.w600,
                        textColor: vehicle.status == MyVehicleState.awaiting.value
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
              ).paddingOnly(bottom: 20.h, left: 20, right: 20),

              // Button
              if (vehicle.status == MyVehicleState.inProgress.value)
                SolidTextButton(onTap: () => Get.toNamed(RouterPaths.signAgreement), buttonText: 'Sign documents')
                    .paddingSymmetric(horizontal: 20),

              OutlineTextButton(
                      onTap: () => Get.toNamed(RouterPaths.contractDetails,
                          arguments: {ArgumentsKey.contractId: vehicle.contactId}),
                      buttonText: 'View contract')
                  .paddingSymmetric(horizontal: 20),
            ],
          ).paddingSymmetric(vertical: 20),

          // Label
          Positioned(
            left: -3,
            top: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: const BoxDecoration(
                  color: AppColors.contractColor, borderRadius: BorderRadius.all(Radius.circular(2))),
              child: const BodyText(
                text: 'New contract',
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
