import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/secondary_info_tile.dart';
import '../../model/protection_plan_model.dart';

class ProtectionPackageWidget extends StatefulWidget {
  final List<ProtectionPackageModel> protectionPackageList;
  final ValueChanged<ProtectionPackageModel> onChanged;

  const ProtectionPackageWidget({
    super.key,
    required this.protectionPackageList,
    required this.onChanged,
  });

  @override
  State<ProtectionPackageWidget> createState() => _ProtectionPackageWidgetState();
}

class _ProtectionPackageWidgetState extends State<ProtectionPackageWidget> {
  List<ProtectionPackageModel> _protectionPackages = [];
  late int groupValue;

  @override
  void initState() {
    super.initState();
    _protectionPackages = List.from(widget.protectionPackageList);
    if (_protectionPackages.isNotEmpty) {
      groupValue = _protectionPackages.first.id ?? 0;
      widget.onChanged(_protectionPackages.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.protectionPackageList.map((protectionModel) {
        return Stack(
          children: [
            BorderCardWidget(
              height: 104,
              contentPadding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
              backgroundColor:
                  groupValue == protectionModel.id ? AppColors.primaryColor.withOpacity(0.1) : AppColors.lightCardColor,
              borderColor: groupValue == protectionModel.id ? AppColors.primaryColor.withOpacity(0.1) : null,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<int>(
                    visualDensity: VisualDensity.compact,
                    value: protectionModel.id!,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() => groupValue = value!);
                      for (var item in _protectionPackages) {
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BodyText(
                          text: '${protectionModel.title}',
                          textColor: groupValue == protectionModel.id
                              ? AppColors.lightTextColor
                              : AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ).paddingOnly(bottom: 5),
                        Column(
                          children: protectionModel.coverages!
                              .map((item) => SecondaryInfoTile(
                                    leadingIcon: Icons.check, //Icons.close
                                    title: ' $item',
                                    titleColor: AppColors.lightSecondaryTextColor,
                                  ))
                              .toList(),
                        )
                      ],
                    ).paddingOnly(right: 20),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                          color: AppColors.lightSecondaryTextColor, fontSize: 12, fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                            text: '${protectionModel.packagePrice ?? 'N/A'}',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.lightTextColor)),
                        const TextSpan(text: '\$', style: TextStyle(color: AppColors.lightTextColor)),
                        const TextSpan(text: ' /m'),
                      ],
                    ),
                  )
                ],
              ),
            ).paddingOnly(bottom: 10),
            if (protectionModel.subscriptionDiscount != null)
              Positioned(
                top: 8,
                right: -28,
                child: Transform.rotate(
                  angle: math.pi / 4,
                  child: Container(
                    alignment: Alignment.center,
                    height: 24,
                    width: 100,
                    color: AppColors.lightProgressColor,
                    child: ButtonText(
                      text: '-${protectionModel.subscriptionDiscount}%',
                      textSize: 12,
                    ),
                  ),
                ),
              )
          ],
        );
      }).toList(),
    );
  }
}
