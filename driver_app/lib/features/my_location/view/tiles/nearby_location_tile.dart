import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/nearby_location_model.dart';

class NearbyLocationTile extends StatelessWidget {
  const NearbyLocationTile({super.key, required this.model});
  final NearbyLocationModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouterPaths.locationDetails, arguments: {ArgumentsKey.nearbyLocationModel: model}),
      child: BorderCardWidget(
        contentPadding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(model.svgAsset),
            BodyText(
              text: model.title,
              textColor: AppColors.primaryColor,
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }
}
