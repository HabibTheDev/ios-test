import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_color.dart';
import 'text_widget.dart';

class EmptyContentWidget extends StatelessWidget {
  const EmptyContentWidget(
      {super.key, required this.title, this.subTitle, required this.svgAsset});
  final String svgAsset;
  final String title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(svgAsset).paddingOnly(bottom: 10),
          TitleText(
            text: title,
            textAlign: TextAlign.center,
            textSize: 16,
          ),
          if (subTitle != null)
            SmallText(
              text: subTitle!,
              textColor: AppColors.lightSecondaryTextColor,
              textAlign: TextAlign.center,
            )
        ],
      ).paddingAll(16),
    );
  }
}
