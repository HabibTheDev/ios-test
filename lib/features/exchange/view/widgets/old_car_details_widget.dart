import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';

class OldCarDetailsWidget extends StatelessWidget {
  const OldCarDetailsWidget(
      {super.key, required this.imageUrl, required this.carBrandImageUrl, required this.model, required this.make});

  final String? imageUrl;
  final String? carBrandImageUrl;
  final String? model;
  final String? make;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Brand & Logo
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleImageWidget(imageUrl: imageUrl, imageSize: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(text: make ?? '${locale?.notAvailable}', fontWeight: FontWeight.bold),
                SmallText(text: model ?? '${locale?.notAvailable}', textColor: AppColors.lightSecondaryTextColor),
              ],
            ).paddingOnly(left: 10)
          ],
        ).paddingOnly(bottom: 10),

        //Car Image
        NetworkImageWidget(imageUrl: imageUrl, height: 40, fit: BoxFit.cover).paddingOnly(bottom: 10),
      ],
    );
  }
}
