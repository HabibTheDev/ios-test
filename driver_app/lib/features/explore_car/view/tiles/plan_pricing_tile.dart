import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../inspection/view/tiles/ul_tile.dart';
import '../../../../core/constants/app_color.dart';

class PlanPricingTile extends StatelessWidget {
  const PlanPricingTile(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.subTitle,
      required this.trailingText,
      this.features});
  final IconData leadingIcon;
  final String title;
  final String subTitle;
  final String trailingText;
  final List<String>? features;

  @override
  Widget build(BuildContext context) {
    return BorderCardWidget(
        contentPadding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    leadingIcon,
                    color: AppColors.primaryColor,
                    size: 18,
                  ).paddingOnly(right: 4),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: title,
                          fontWeight: FontWeight.w600,
                        ),
                        ExtraSmallText(
                          text: subTitle,
                          fontWeight: FontWeight.w500,
                        ),
                        if (features != null)
                          Column(
                                  children: features!
                                      .map((item) => UlTile(
                                            title: item,
                                            titleSize: 10,
                                            pointerRadius: 2.5,
                                          ))
                                      .toList())
                              .paddingOnly(top: 4)
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Trailing
            RichText(
              text: TextSpan(
                style: const TextStyle(color: AppColors.lightTextColor, fontSize: 10, fontWeight: FontWeight.w500),
                children: [
                  TextSpan(
                      text: trailingText,
                      style:
                          const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: AppColors.lightTextColor)),
                  const TextSpan(text: '\$')
                ],
              ),
            ),
          ],
        )).paddingOnly(bottom: 10);
  }
}
