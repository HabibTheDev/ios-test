import 'package:driver_app/shared/widgets/widthbox.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class BasicInfoTile extends StatelessWidget {
  const BasicInfoTile({super.key, required this.leadingText, required this.value, this.trailingText});
  final String leadingText;
  final String value;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: SmallText(
            text: leadingText,
            textColor: AppColors.lightSecondaryTextColor,
          ),
        ),
        const WidthBox(width: 8),
        Expanded(
          flex: 2,
          child: RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              text: value,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.lightTextColor),
              children: [
                TextSpan(
                  text: ' ${trailingText ?? ''}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightSecondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
