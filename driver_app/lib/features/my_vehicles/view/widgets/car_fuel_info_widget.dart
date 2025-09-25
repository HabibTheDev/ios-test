import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/progress_bar_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class CarFuelInfoWidget extends StatelessWidget {
  const CarFuelInfoWidget({
    super.key,
    required this.title,
    this.leadingIcon,
    this.subtitle,
    this.trailingSubtitle,
    this.progressValue,
    this.contentPadding,
    this.backgroundColor,
    this.trackColor,
    this.progressColor,
  });

  final String title;
  final IconData? leadingIcon;
  final String? subtitle;
  final String? trailingSubtitle;
  final double? progressValue;
  final Color? progressColor;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final Color? trackColor;

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      contentPadding: contentPadding ??
          const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 16),
      backgroundColor: backgroundColor ?? AppColors.lightBgColor,
      showShadow: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (leadingIcon != null)
            Icon(
              leadingIcon,
              color: AppColors.primaryColor,
              size: 24,
            ),
          Row(
            children: [
              Expanded(
                child: SmallText(
                  text: title,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Expanded(
                child: trailingSubtitle != null
                    ? SmallText(
                        text: trailingSubtitle!,
                        textAlign: TextAlign.end,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.lightSecondaryTextColor,
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),

          // Progress Bar
          if (progressValue != null)
            ProgressBarWidget(
              progressValue: progressValue!,
              color: progressColor ?? AppColors.inProgressColor,
              height: 6,
              trackColor: trackColor ?? AppColors.lightCardColor,
            ).paddingSymmetric(vertical: 6),
          if (subtitle != null)
            SmallText(
              text: subtitle!,
              fontWeight: FontWeight.w500,
              textColor: AppColors.lightSecondaryTextColor,
            )
        ],
      ),
    );
  }
}
