import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/vehicle_model.dart';
import '../widgets/my_vehicle_car_details_widget.dart';

class RevokedVehicleTile extends StatelessWidget {
  const RevokedVehicleTile({super.key, required this.myVehicleModel});
  final VehicleModel myVehicleModel;

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
              MyVehicleCarDetailsWidget(height: 110.h).paddingOnly(bottom: 20.h, top: 80.h),

              // ID & status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BodyText(
                    text: '#ID20034',
                    fontWeight: FontWeight.w700,
                  ).paddingOnly(right: 10),
                  const ExtraSmallText(
                    text: 'Contract ID',
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.lightSecondaryTextColor,
                  )
                ],
              ).paddingOnly(left: 20, top: 20.h, bottom: 20.h),

              OutlineTextButton(onTap: () => Get.toNamed(RouterPaths.contractDetails), buttonText: 'View contract')
                  .paddingSymmetric(horizontal: 20),
            ],
          ),

          // Label
          Positioned(
            left: -3,
            top: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: const BoxDecoration(
                  color: AppColors.warningColor, borderRadius: BorderRadius.all(Radius.circular(2))),
              child: const BodyText(
                text: 'Access revoked',
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
