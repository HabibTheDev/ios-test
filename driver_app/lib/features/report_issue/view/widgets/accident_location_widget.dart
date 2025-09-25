import '../../../../core/constants/app_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_color.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/normal_card.dart';
import '../../../../shared/widgets/outline_button.dart';
import '../../../../shared/widgets/text_widget.dart';

class AccidentLocationWidget extends StatelessWidget {
  const AccidentLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return NormalCard(
      backgroundColor: AppColors.lightBgColor,
      contentPadding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SmallText(
            text: 'Accident location',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.w600,
          ).paddingOnly(bottom: 16),

          /// Lat Long
          NormalCard(
            contentPadding: const EdgeInsets.all(16),
            backgroundColor: AppColors.lightCardColor,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.lightCardColor,
                  child: SvgPicture.asset(Assets.assetsSvgLatitude),
                ).paddingOnly(right: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BodyText(
                      text: 'Latitude',
                      fontWeight: FontWeight.w600,
                    ),
                    SmallText(
                      text: '23.98',
                      textColor: AppColors.lightSecondaryTextColor,
                    )
                  ],
                )
              ],
            ),
          ).paddingOnly(bottom: 10),

          /// Longitude
          NormalCard(
            contentPadding: const EdgeInsets.all(16),
            backgroundColor: AppColors.lightCardColor,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.lightCardColor,
                  child: SvgPicture.asset(Assets.assetsSvgLongitude),
                ).paddingOnly(right: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    BodyText(
                      text: 'Longitude',
                      fontWeight: FontWeight.w600,
                    ),
                    SmallText(
                      text: '23.98',
                      textColor: AppColors.lightSecondaryTextColor,
                    ),
                  ],
                ),
              ],
            ),
          ).paddingOnly(bottom: 16),

          // Location Button
          OutlineButton(
            onTap: () {},
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.location_on_sharp,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                ButtonText(
                  text: ' Allocate Location',
                  textColor: AppColors.primaryColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
