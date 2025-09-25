import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class VehicleTile extends StatelessWidget {
  const VehicleTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.fire_truck_rounded,
                          color: AppColors.lightSecondaryTextColor
                              .withOpacity(0.5),
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: 'Lamborghini',
                              fontWeight: FontWeight.bold,
                            ),
                            SmallText(
                              text: 'Galliard 2022',
                              textColor: AppColors.lightSecondaryTextColor,
                              textSize: 10,
                            ),
                          ],
                        ).paddingOnly(left: 8),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: -65,
                    top: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      Assets.assetsSvgDriverSide,
                      height: 72,
                    ),
                  ),
                  const SizedBox(height: 80)
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
