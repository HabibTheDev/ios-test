import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';

class BasicInfoTile extends StatelessWidget {
  const BasicInfoTile({super.key, required this.leadingText, required this.value, this.trailingText, this.fontWeight});
  final String leadingText;
  final String value;
  final String? trailingText;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: SmallText(text: leadingText, textColor: AppColors.lightSecondaryTextColor, fontWeight: fontWeight),
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
                  style: TextStyle(fontWeight: fontWeight ?? FontWeight.w400, color: AppColors.lightSecondaryTextColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
