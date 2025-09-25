import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/enums.dart';

class ExploreHeaderWidget extends StatelessWidget {
  const ExploreHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 205,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [BoxShadow(color: AppColors.lightShadowColor, blurRadius: 5, offset: const Offset(0, 1))]),
          child: const ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: NetworkImageWidget(
              imageUrl: AppString.carImageUrl,
              width: double.infinity,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            height: 205,
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            color: Colors.white70,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const TitleText(
                  text: 'Explore more cars?',
                  textAlign: TextAlign.center,
                  textSize: 24,
                  fontWeight: FontWeight.w700,
                ),
                const BodyText(
                  text: 'Discover, subscribe, and add your dream ride to your collection.',
                  textAlign: TextAlign.center,
                ).paddingOnly(bottom: 20),

                // Search
                InkWell(
                  onTap: () => Get.toNamed(
                    RouterPaths.filterCar,
                    arguments: {ArgumentsKey.carFilterType: CarFilterType.search},
                  ),
                  child: Container(
                    height: 46,
                    padding: const EdgeInsets.only(left: 20, right: 8, top: 8, bottom: 8),
                    decoration:
                        const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(text: 'Search here', textColor: AppColors.lightSecondaryTextColor),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(Icons.search, color: Colors.white, size: 17),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
