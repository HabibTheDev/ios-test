import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/secondary_info_tile.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/start_rating_builder.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/filter_car_model.dart';
import '../widgets/car_rate_widget.dart';

class ExploreCarTile extends StatelessWidget {
  const ExploreCarTile({super.key, required this.carFilterType, required this.model});
  final CarFilterType carFilterType;
  final ExploreCar model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          RouterPaths.carDetails,
          arguments: {ArgumentsKey.id: model.id},
        );
      },
      child: CardWidget(
        contentPadding: const EdgeInsets.only(left: 12, top: 12, bottom: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Car Info
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Car name & Brand
                  CarBrandDetailsWidget(
                    leading: NetworkImageWidget(
                      imageUrl: model.brandLogo,
                      borderRadius: 20,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                    title: model.make ?? 'N/A',
                    subTitle: '${model.model ?? 'N/A'} ${model.year ?? 'N/A'}',
                  ).paddingOnly(bottom: 10),

                  // Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StartRatingBuilder(rating: double.parse('${model.catalogueRating ?? '0'}')),
                      SmallText(
                        text: '(${model.tripCount ?? '0'} trips)',
                        textColor: AppColors.lightSecondaryTextColor,
                      )
                    ],
                  ).paddingOnly(bottom: 10),

                  // Location
                  if (carFilterType == CarFilterType.search || carFilterType == CarFilterType.brand)
                    SecondaryInfoTile(
                            leadingIcon: Icons.location_on_rounded,
                            title: ' ${model.location?.locationCity?.city ?? 'N/A'}')
                        .paddingOnly(bottom: 4),
                  if (carFilterType != CarFilterType.catalogue)
                    SecondaryInfoTile(leadingIcon: Icons.directions_car, title: ' ${model.catalogueName ?? 'N/A'}')
                        .paddingOnly(bottom: 10),

                  // Price
                  carFilterType == CarFilterType.catalogue
                      ? SecondaryInfoTile(
                          leadingIcon: Icons.location_on_rounded,
                          title: ' ${model.location?.locationCity?.city ?? 'N/A'}')
                      : CarRateWidget(carRate: '${model.subscriptionCharge}')
                ],
              ),
            ),

            // Car Image
            Expanded(
              flex: 2,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: -80.w,
                    top: 0,
                    bottom: 0,
                    child: NetworkImageWidget(
                      imageUrl: model.images,
                      height: 80,
                      width: 210.w,
                    ),
                  ),
                  const SizedBox(height: 90)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
