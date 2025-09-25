import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    this.leading,
    required this.titleKey,
    required this.titleValue,
  });
  final Widget? leading;
  final String titleKey;
  final String titleValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        leading ?? const SizedBox.shrink(),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightTextColor),
              children: [
                TextSpan(
                    text: '  $titleKey ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                TextSpan(
                    text: titleValue,
                    style: const TextStyle(
                        color: AppColors.lightTextFieldHintColor)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
