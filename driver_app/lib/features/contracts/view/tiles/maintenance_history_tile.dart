import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class MaintenanceHistoryTile extends StatelessWidget {
  const MaintenanceHistoryTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderCardWidget(
      contentPadding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const BodyText(
            text: 'Damage repairing',
            fontWeight: FontWeight.w700,
          ),
          const ExtraSmallText(
            text: 'Drop-off',
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          const ThreeItemInfoTile(
                  leadingText: 'Requested',
                  titleText: '12 Jan 2024',
                  trailingText: '12:32 PM')
              .paddingOnly(bottom: 6),
          const ThreeItemInfoTile(
                  leadingText: 'Repaired',
                  titleText: '19 Jan 2024',
                  trailingText: '10:00 AM')
              .paddingOnly(bottom: 16),

          // Car Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Car Info
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car name & Brand
                    const CarBrandDetailsWidget(
                      title: 'Lamborghini',
                      subTitle: 'Gallardo 2022',
                    ).paddingOnly(bottom: 10),
                  ],
                ),
              ),
              // Car Image
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.antiAlias,
                  children: [
                    Positioned(
                      right: -70,
                      top: 0,
                      bottom: 0,
                      child: SvgPicture.asset(
                        Assets.assetsSvgDriverSide,
                        height: 80,
                      ),
                    ),
                    const SizedBox(height: 80)
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
