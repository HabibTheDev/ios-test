import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';

class FeesAndDepositTile extends StatelessWidget {
  const FeesAndDepositTile({
    super.key,
    required this.leadingIcon,
    required this.titleText,
    this.subTitleText,
    required this.trailingText,
    this.leadingSize,
    this.subTitleSize,
  });
  final IconData leadingIcon;
  final String titleText;
  final String? subTitleText;
  final String trailingText;
  final double? leadingSize;
  final double? subTitleSize;

  @override
  Widget build(BuildContext context) {
    return BorderCardWidget(
      contentPadding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: subTitleText != null
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(
            leadingIcon,
            color: AppColors.primaryColor,
            size: leadingSize ?? 24,
          ),
          const WidthBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(
                  text: titleText,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subTitleText != null)
                  SmallText(
                    text: subTitleText!,
                    maxLine: 1,
                    textSize: subTitleSize,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          const WidthBox(width: 8),
          RichText(
            text: TextSpan(
              text: '$trailingText ',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.lightTextColor),
              children: const [
                TextSpan(
                    text: '\$',
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 10)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
