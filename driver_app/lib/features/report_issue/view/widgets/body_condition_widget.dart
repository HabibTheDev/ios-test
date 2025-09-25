import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/text_widget.dart';

class BodyConditionWidget extends StatelessWidget {
  const BodyConditionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: BodyText(
                text: 'Current body condition',
                fontWeight: FontWeight.w700,
                textColor: AppColors.lightSecondaryTextColor,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.errorColor.withOpacity(0.2),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const SmallText(
                text: 'Severe',
                textColor: AppColors.errorColor,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ).paddingOnly(bottom: 16),

        //Damage count
        const SmallText(
          text: '06 body damage',
          fontWeight: FontWeight.w600,
        ).paddingOnly(bottom: 16),

        _tableRow('Location', 'Type', 'Severity',
            isHeader: true, showDivider: false),
        _tableRow('Front bumper', 'Dent', 'Low'),
        _tableRow('Front bumper', 'Dent', 'Low'),
        _tableRow('Front bumper', 'Dent', 'Low'),
        _tableRow('Front bumper', 'Dent', 'Low'),
        _tableRow('Front bumper', 'Dent', 'Low'),
        _tableRow('Front bumper', 'Dent', 'Low', showDivider: false),
        const AppDivider().paddingSymmetric(vertical: 22)
      ],
    );
  }

  Widget _tableRow(String title1, String title2, String title3,
          {bool isHeader = false, bool showDivider = true}) =>
      Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            decoration: isHeader
                ? BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.05),
                    borderRadius: const BorderRadius.all(Radius.circular(6)))
                : null,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SmallText(
                    text: title1,
                    textAlign: TextAlign.start,
                    textColor: !isHeader ? AppColors.primaryColor : null,
                  ),
                ),
                Expanded(
                  child: SmallText(
                    text: title2,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: SmallText(
                    text: title3,
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
          if (showDivider) const AppDivider()
        ],
      );
}
