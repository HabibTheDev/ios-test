import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constants/app_assets.dart';
import '../../core/constants/app_color.dart';

import 'network_image_widget.dart';
import 'text_widget.dart';

class BasicCarDetailsWidget extends StatelessWidget {
  const BasicCarDetailsWidget(
      {super.key, this.make, this.model, this.year, this.brandLogo, this.carImage, this.carWidth});
  final String? make;
  final String? model;
  final int? year;
  final String? brandLogo;
  final String? carImage;
  final double? carWidth;

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
            brandLogo != null
                ? NetworkImageWidget(
                    imageUrl: brandLogo!,
                    borderRadius: 20,
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                  )
                : const CircleAvatar(radius: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(text: make ?? 'N/A'),
                SmallText(
                  text: '${model ?? 'N/A'} ${year ?? 'N/A'}',
                  textColor: AppColors.lightSecondaryTextColor,
                ),
              ],
            ).paddingOnly(left: 10)
          ],
        ).paddingOnly(bottom: 32),

        // Car Image
        carImage != null
            ? NetworkImageWidget(
                imageUrl: carImage!,
                height: 80,
                width: carWidth ?? 132,
                fit: BoxFit.fitHeight,
              )
            : SvgPicture.asset(
                Assets.assetsSvgDriverSide,
                height: 80,
                width: carWidth ?? 132,
              ),
      ],
    );
  }
}
