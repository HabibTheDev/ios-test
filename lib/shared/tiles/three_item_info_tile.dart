import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class ThreeItemInfoTile extends StatelessWidget {
  const ThreeItemInfoTile({super.key, this.leadingText, this.titleText, this.trailingText});
  final String? leadingText;
  final String? titleText;
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: '$leadingText: ',
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightTextFieldHintColor),
        children: [
          TextSpan(
            text: titleText ?? '',
            style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.lightTextColor),
          ),
          TextSpan(text: ' ${trailingText ?? ''}'),
        ],
      ),
    );
  }
}
