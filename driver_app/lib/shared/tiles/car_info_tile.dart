import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';

class CarInfoTile extends StatelessWidget {
  const CarInfoTile({
    super.key,
    this.leading,
    required this.titleKey,
    required this.titleValue,
    this.textAlign,
  });
  final Widget? leading;
  final String titleKey;
  final String titleValue;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leading?.paddingOnly(right: 4) ?? const SizedBox.shrink(),
        Expanded(
          child: RichText(
            textAlign: textAlign ?? TextAlign.start,
            text: TextSpan(
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightTextColor),
              children: [
                TextSpan(
                    text: '$titleKey: ',
                    style: const TextStyle(
                      color: AppColors.lightTextFieldHintColor,
                    )),
                TextSpan(
                    text: titleValue,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
