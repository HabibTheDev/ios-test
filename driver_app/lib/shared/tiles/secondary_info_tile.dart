import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';
import '../widgets/text_widget.dart';

class SecondaryInfoTile extends StatelessWidget {
  const SecondaryInfoTile({
    super.key,
    required this.leadingIcon,
    required this.title,
    this.titleColor,
    this.iconSize,
  });
  final IconData leadingIcon;
  final String title;
  final Color? titleColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          leadingIcon,
          color: AppColors.primaryColor,
          size: iconSize ?? 14,
        ),
        Expanded(
          child: SmallText(
            text: ' $title',
            textColor: titleColor ?? AppColors.lightSecondaryTextColor,
          ),
        ),
      ],
    );
  }
}
