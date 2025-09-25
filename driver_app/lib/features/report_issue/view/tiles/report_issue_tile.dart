import '../../../../core/router/router_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/secondary_info_tile.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class ReportIssueTile extends StatelessWidget {
  const ReportIssueTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouterPaths.collisionReport),
      child: CardWidget(
        backgroundColor: AppColors.lightCardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //Top section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const BodyText(
                  text: 'Damaged or broken glass',
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                const SmallText(
                  text: '#143563',
                  textColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(bottom: 10),
                const SecondaryInfoTile(leadingIcon: Icons.calendar_month_rounded, title: ' 12 Sept 2024')
                    .paddingOnly(bottom: 4),
                const SecondaryInfoTile(leadingIcon: Icons.check_circle, title: ' 12:30 PM'),
              ],
            ).paddingOnly(left: 12, right: 12, top: 12, bottom: 20),

            // Car Details
            Row(
              children: [
                Expanded(
                    flex: 3,
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
                                color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BodyText(
                                    text: 'Lemborghini',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  SmallText(
                                    text: 'Gallardo 2022',
                                    textColor: AppColors.lightSecondaryTextColor,
                                    textSize: 10,
                                  ),
                                ],
                              ).paddingOnly(left: 8),
                            )
                          ],
                        ).paddingOnly(bottom: 10),
                      ],
                    )),
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
            ).paddingOnly(left: 12, bottom: 12)
          ],
        ),
      ),
    );
  }
}
