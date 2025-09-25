import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class InfoWithIconTile extends StatelessWidget {
  const InfoWithIconTile(
      {super.key, required this.leadingIcon, required this.title});
  final IconData leadingIcon;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          leadingIcon,
          color: AppColors.primaryColor,
          size: 16,
        ).paddingOnly(right: 4),
        Expanded(
            child: SmallText(
          text: title ?? 'N/A',
          textColor: AppColors.lightSecondaryTextColor,
        ))
      ],
    );
  }
}
