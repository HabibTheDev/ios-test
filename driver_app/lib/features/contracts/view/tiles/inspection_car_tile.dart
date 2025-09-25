import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';

class InspectionCarTile extends StatelessWidget {
  const InspectionCarTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(RouterPaths.inspectionReport, arguments: {
          ArgumentsKey.title: 'Inspection report',
          ArgumentsKey.returnScreen: RouterPaths.allInspection,
        });
      },
      child: CardWidget(
        contentPadding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Car Info
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car name & Brand
                  const CarBrandDetailsWidget(
                    title: 'Lamborghini',
                    subTitle: 'Gallardo 2022',
                  ).paddingOnly(bottom: 10),

                  const CarInfoTile(titleKey: 'Date', titleValue: '25 Jan 2024')
                      .paddingOnly(bottom: 4),
                  const CarInfoTile(
                      titleKey: 'Inspected by', titleValue: 'Danish Ali'),
                ],
              ),
            ),

            // Car Image
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: -80,
                    top: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      Assets.assetsSvgDriverSide,
                      height: 80,
                    ),
                  ),
                  const SizedBox(height: 90)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
