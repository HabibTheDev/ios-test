import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/inspection_arguments_model.dart';
import '../../model/inspection_type_model.dart';

class InspectionTypeTile extends StatelessWidget {
  const InspectionTypeTile({super.key, required this.model, required this.inspectionArgumentsModel});

  final InspectionTypeModel model;
  final InspectionArgumentsModel? inspectionArgumentsModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (model.status != StepStatus.awaiting) {
          return;
        }
        if (model.type == InspectionCaptureTypeEnum.carExterior) {
          Get.toNamed(
            RouterPaths.carExteriorInstruction,
            arguments: {
              ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel?.copyWith(
                inspectionCaptureTypeEnum: model.type,
              ),
            },
          );
        } else {
          Get.toNamed(
            RouterPaths.captureInspectionImage,
            arguments: {
              ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel?.copyWith(
                inspectionCaptureTypeEnum: model.type,
              ),
            },
          );
        }
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(model.svgAsset, width: 70, fit: BoxFit.fitWidth).paddingOnly(right: 20),
          Expanded(
            child: BodyText(
              text: model.type.value,
              fontWeight: FontWeight.w500,
              textColor: model.status == StepStatus.awaiting
                  ? AppColors.lightTextColor
                  : AppColors.lightTextFieldHintColor,
            ),
          ),
          model.status == StepStatus.complete
              ? const Icon(Icons.check_circle, color: AppColors.lightSecondaryTextColor, size: 20)
              : model.status == StepStatus.awaiting
              ? const Icon(Icons.arrow_forward_ios_rounded, color: AppColors.lightSecondaryTextColor, size: 14)
              : const SizedBox.shrink(),
        ],
      ).paddingSymmetric(vertical: 22),
    );
  }
}
