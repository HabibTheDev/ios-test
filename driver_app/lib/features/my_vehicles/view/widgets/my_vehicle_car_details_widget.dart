import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/text_widget.dart';

class MyVehicleCarDetailsWidget extends StatelessWidget {
  const MyVehicleCarDetailsWidget(
      {super.key,
      this.height,
      this.titleTrailing,
      this.imageUrl,
      this.carBrandImageUrl,
      this.model,
      this.make,
      this.year});
  final double? height;
  final IconData? titleTrailing;
  final String? imageUrl;
  final String? carBrandImageUrl;
  final String? model;
  final String? make;
  final int? year;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Brand & Logo
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NetworkImageWidget(
              imageUrl: carBrandImageUrl,
              height: 40,
              width: 40,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TitleText(text: make ?? 'N/A'),
                    if (titleTrailing != null)
                      Icon(
                        titleTrailing,
                        color: AppColors.primaryColor,
                        size: 24,
                      ).paddingOnly(left: 10)
                  ],
                ),
                SmallText(
                  text: '${model ?? 'N/A'} ${year ?? 'N/A'}',
                  textColor: AppColors.lightSecondaryTextColor,
                ),
              ],
            ).paddingOnly(left: 10)
          ],
        ).paddingOnly(bottom: 32),

        // Car Image
        Stack(
          children: [
            SizedBox(height: height ?? 120.h, width: double.infinity),
            Positioned(
                right: -10.w,
                child: NetworkImageWidget(
                  imageUrl: imageUrl,
                  height: height ?? 124.h,
                  width: 280.w,
                )),
          ],
        )
      ],
    );
  }
}
