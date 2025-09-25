import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';

class HorizontalListWidget extends StatelessWidget {
  const HorizontalListWidget(
      {super.key, required this.headerText, required this.listViewWidget});
  final String headerText;
  final Widget listViewWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmallText(
          text: headerText,
          textColor: AppColors.lightSecondaryTextColor,
          fontWeight: FontWeight.w700,
        ).paddingOnly(bottom: 10),
        SizedBox(
          height: 100,
          child: listViewWidget,
        )
      ],
    ).paddingOnly(left: 16);
  }
}
