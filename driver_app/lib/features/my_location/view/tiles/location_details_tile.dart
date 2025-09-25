import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/extensions/string_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/info_tile.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/service_point_model.dart';

class LocationDetailsTile extends StatelessWidget {
  const LocationDetailsTile({super.key, required this.model});
  final ServicePointModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(RouterPaths.destinationTracking, arguments: {ArgumentsKey.servicePointModel: model}),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            border: Border.all(color: AppColors.lightBorderColor)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: model.locationName ?? 'N/A',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textSize: 16,
            ).paddingOnly(bottom: 4),
            SmallText(
              text: model.description ?? 'N/A',
              maxLine: 2,
              overflow: TextOverflow.ellipsis,
            ).paddingOnly(bottom: 16),
            InfoTile(
                    leading: const Icon(
                      Icons.pin_drop_rounded,
                      color: AppColors.primaryColor,
                      size: 16,
                    ),
                    titleKey: '${model.travelDistanceInKm} km',
                    titleValue: '(${model.travelTime})')
                .paddingOnly(bottom: 5),
            InfoTile(
                leading: const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.primaryColor,
                  size: 16,
                ),
                titleKey: model.address.capitalizeFirstLetter(),
                titleValue: ''),
          ],
        ),
      ),
    );
  }
}
