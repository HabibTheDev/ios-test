import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class OverviewSummeryTile extends StatelessWidget {
  const OverviewSummeryTile(
      {super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 2,
            child: SmallText(
              text: title,
              textColor: AppColors.lightSecondaryTextColor,
              fontWeight: FontWeight.w500,
            )),
        Expanded(
            flex: 1,
            child: SmallText(
              text: value,
              textAlign: TextAlign.end,
              fontWeight: FontWeight.w600,
            )),
      ],
    ).paddingOnly(bottom: 10);
  }
}
