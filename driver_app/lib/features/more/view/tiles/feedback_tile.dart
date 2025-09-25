import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/start_rating_builder.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class FeedbackTile extends StatelessWidget {
  const FeedbackTile({super.key});

  @override
  Widget build(BuildContext context) {
    return CardWidget(
      backgroundColor: AppColors.lightCardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //Top Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Row(
                children: [
                  TitleText(text: '3.5 '),
                  StartRatingBuilder(rating: 3.5),
                ],
              ),
              const SmallText(
                text: '12 Jan 2024',
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 20),
              const BodyText(
                      text:
                          '“Elevate Your Lifestyle with Stress-Free Subscriptions and Short-Term Contracts- Recommended”')
                  .paddingOnly(bottom: 10),
              const SmallText(
                text: '- Thank you for your precious feedback.',
                textColor: AppColors.lightSecondaryTextColor,
              ),
            ],
          ).paddingOnly(left: 12, right: 12, top: 12, bottom: 20),

          // Car details
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
                                  text: 'Gallardo 2022',
                                  textColor: AppColors.lightSecondaryTextColor,
                                  textSize: 10,
                                ),
                              ],
                            ).paddingOnly(left: 8),
                          )
                        ],
                      ).paddingOnly(bottom: 10),
                      const CarInfoTile(
                          titleKey: 'Contract ID', titleValue: '#ID20034')
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
    );
  }
}
