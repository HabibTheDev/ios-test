import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/mileage_plan_model.dart';

class MileagePackageWidget extends StatefulWidget {
  final List<MileagePackageModel> mileagePackageList;
  final ValueChanged<MileagePackageModel> onChanged;

  const MileagePackageWidget({
    super.key,
    required this.mileagePackageList,
    required this.onChanged,
  });

  @override
  State<MileagePackageWidget> createState() => _MileagePackageWidgetState();
}

class _MileagePackageWidgetState extends State<MileagePackageWidget> {
  List<MileagePackageModel> _mileagePackages = [];
  late int groupValue;

  @override
  void initState() {
    super.initState();
    _mileagePackages = List.from(widget.mileagePackageList);
    if (_mileagePackages.isNotEmpty) {
      groupValue = _mileagePackages.first.id ?? 0;
      widget.onChanged(_mileagePackages.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.mileagePackageList.map((mileagePackageModel) {
        return BorderCardWidget(
          contentPadding: const EdgeInsets.only(left: 4, right: 12, top: 12, bottom: 12),
          backgroundColor: groupValue == mileagePackageModel.id ? AppColors.primaryColor.withOpacity(0.1) : null,
          borderColor: groupValue == mileagePackageModel.id ? AppColors.primaryColor.withOpacity(0.1) : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Radio<int>(
                visualDensity: VisualDensity.compact,
                value: mileagePackageModel.id!,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() => groupValue = value!);
                  for (var item in _mileagePackages) {
                    if (item.id == groupValue) {
                      widget.onChanged(item);
                      break;
                    }
                  }
                },
              ).paddingOnly(right: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText(
                      text: '${mileagePackageModel.includedMileage ?? 0} miles',
                      textColor: groupValue == mileagePackageModel.id
                          ? AppColors.lightTextColor
                          : AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    SmallText(
                      text: '\$${mileagePackageModel.extraMileageCharge ?? 0.0} per additional mile',
                      textColor: AppColors.lightTextFieldHintColor,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      color: AppColors.lightSecondaryTextColor, fontSize: 12, fontWeight: FontWeight.w500),
                  children: [
                    TextSpan(
                        text: '${mileagePackageModel.packagePrice ?? 0.0}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.lightTextColor)),
                    const TextSpan(text: '\$', style: TextStyle(color: AppColors.lightTextColor)),
                    const TextSpan(text: ' /m'),
                  ],
                ),
              )
            ],
          ),
        ).paddingOnly(bottom: 10);
      }).toList(),
    );
  }
}
