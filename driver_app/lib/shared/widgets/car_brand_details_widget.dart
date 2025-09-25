import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/app_color.dart';
import 'text_widget.dart';

class CarBrandDetailsWidget extends StatelessWidget {
  const CarBrandDetailsWidget({super.key, required this.title, required this.subTitle, this.leading});
  final String title;
  final String subTitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        leading ??
            CircleAvatar(
              radius: 20,
              child: Icon(
                Icons.fire_truck_rounded,
                color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
                size: 30,
              ),
            ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: title,
                fontWeight: FontWeight.w700,
              ),
              SmallText(
                text: subTitle,
                textColor: AppColors.lightSecondaryTextColor,
                textSize: 10,
              ),
            ],
          ).paddingOnly(left: 8),
        )
      ],
    );
  }
}
