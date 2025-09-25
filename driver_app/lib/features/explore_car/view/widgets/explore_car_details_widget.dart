import 'package:driver_app/shared/widgets/heightbox.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/border_card_tile.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/tiles/secondary_info_tile.dart';
import '../../../../shared/widgets/start_rating_builder.dart';
import '../../model/explore_car_details_model.dart';
import 'car_rate_widget.dart';

class ExploreCarDetailsWidget extends StatelessWidget {
  const ExploreCarDetailsWidget({super.key, required this.carDetailsModel});
  final ExploreCarDetailsModel carDetailsModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BasicCarDetailsWidget(
          brandLogo: carDetailsModel.brandLogo,
          make: carDetailsModel.make,
          model: carDetailsModel.model,
          year: carDetailsModel.year,
          carImage: carDetailsModel.images,
          carWidth: 264,
        ).paddingOnly(bottom: 40),

        Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BodyText(
                  text: '${carDetailsModel.catalogue?.catalogueName ?? 'N/A'} | ${carDetailsModel.style ?? 'N/A'}',
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(bottom: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StartRatingBuilder(
                      rating: double.parse('${carDetailsModel.avgRating ?? 0.0}'),
                      starSize: 14,
                    ),
                    SmallText(
                      text: '(${carDetailsModel.tripCount ?? '0'} trips)',
                      textColor: AppColors.lightSecondaryTextColor,
                    )
                  ],
                )
              ],
            )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CarRateWidget(carRate: '${carDetailsModel.catalogue?.subscriptionCharge ?? '00'}')
                    .paddingOnly(bottom: 2),
                if (carDetailsModel.catalogue?.isTextInclude == true) const SmallText(text: '(incl. tax)')
              ],
            ))
          ],
        ).paddingOnly(bottom: 10),

        CarInfoTile(titleKey: 'Location', titleValue: carDetailsModel.location?.locationCity?.city ?? 'N/A'),
        GridView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          children: [
            BorderCardTile(
              hideBorder: true,
              bgColor: AppColors.lightBgColor,
              leading: const Icon(
                Icons.door_front_door,
                color: AppColors.primaryColor,
                size: 20,
              ),
              title: '${carDetailsModel.noOfDoors ?? '0'}',
              subTitle: 'Total doors',
            ),
            BorderCardTile(
              hideBorder: true,
              bgColor: AppColors.lightBgColor,
              leading: const Icon(
                Icons.airline_seat_recline_extra,
                color: AppColors.primaryColor,
                size: 20,
              ),
              title: '${carDetailsModel.noOfSeats ?? '0'}',
              subTitle: 'Total seats',
            ),
            BorderCardTile(
              hideBorder: true,
              bgColor: AppColors.lightBgColor,
              leading: const Icon(
                Icons.local_gas_station,
                color: AppColors.primaryColor,
                size: 20,
              ),
              title: carDetailsModel.fuelType ?? 'N/A',
              subTitle: 'Fuel type',
            ),
            BorderCardTile(
              hideBorder: true,
              bgColor: AppColors.lightBgColor,
              leading: const Icon(
                Icons.move_down,
                color: AppColors.primaryColor,
                size: 20,
              ),
              title: carDetailsModel.transmission ?? 'N/A',
              subTitle: 'Transmission',
            ),
          ],
        ),
        CarInfoTile(
                leading: const Icon(Icons.speed, color: AppColors.primaryColor, size: 16),
                titleKey: 'Mileage',
                titleValue: '${carDetailsModel.odometer ?? 0.0} M')
            .paddingOnly(bottom: 4),
        CarInfoTile(
            leading: const Icon(Icons.palette, color: AppColors.primaryColor, size: 16),
            titleKey: 'Body color',
            titleValue: carDetailsModel.exteriorColor ?? 'N/A'),
        const AppDivider().paddingSymmetric(vertical: 20),

        // Features
        if (carDetailsModel.features != null && carDetailsModel.features!.isNotEmpty) ...{
          const BodyText(
            text: 'Features',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.w700,
          ).paddingOnly(bottom: 16),
          ListView.separated(
            shrinkWrap: true,
            itemCount: carDetailsModel.features!.length,
            itemBuilder: (context, index) => SecondaryInfoTile(
              leadingIcon: Icons.check,
              title: ' ${carDetailsModel.features![index]}',
              titleColor: AppColors.lightTextColor,
            ),
            separatorBuilder: (context, index) => const HeightBox(height: 10),
          ),
          const AppDivider().paddingSymmetric(vertical: 20),
        },
      ],
    );
  }
}
