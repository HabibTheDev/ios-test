import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/vehicle_performance_model.dart';

class VehiclePerformanceTile extends StatelessWidget {
  const VehiclePerformanceTile({super.key, required this.model});

  final VehiclePerformanceModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (model.status != StepStatus.awaiting) {
          return;
        }
        if (model.type == VehiclePerformanceType.stationary) {
          Get.toNamed(RouterPaths.carStationarySteps);
        } else if (model.type == VehiclePerformanceType.running) {
          Get.toNamed(RouterPaths.carRunningSteps);
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(model.svgAsset, width: 52, fit: BoxFit.fitWidth).paddingOnly(right: 20),
          Expanded(
            child: BodyText(
              text: model.type.value,
              fontWeight: FontWeight.w500,
              textColor:
                  model.status == StepStatus.awaiting ? AppColors.lightTextColor : AppColors.lightTextFieldHintColor,
            ),
          ),
          model.status == StepStatus.complete
              ? const Icon(Icons.check_circle, color: AppColors.lightSecondaryTextColor, size: 20)
              : model.status == StepStatus.awaiting
                  ? const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.lightSecondaryTextColor, size: 14)
                  : const SizedBox.shrink()
        ],
      ).paddingSymmetric(vertical: 22),
    );
  }
}
