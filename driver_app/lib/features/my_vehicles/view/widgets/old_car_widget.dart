import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/text_widget.dart';

class OldCarDetailsWidget extends StatelessWidget {
  const OldCarDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Brand & Logo
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(radius: 15),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(
                  text: 'Lemborghini',
                  fontWeight: FontWeight.bold,
                ),
                SmallText(
                  text: 'Gallardo 2022',
                  textColor: AppColors.lightSecondaryTextColor,
                ),
              ],
            ).paddingOnly(left: 10)
          ],
        ).paddingOnly(bottom: 10),

        //Car Image
        SvgPicture.asset(
          Assets.assetsSvgDriverSide,
          height: 40,
          width: 132,
        ),
      ],
    );
  }
}
