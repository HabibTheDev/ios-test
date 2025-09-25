import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/catalogue_car_model.dart';
import '../widgets/car_rate_widget.dart';

class CarCatalogueTile extends StatelessWidget {
  const CarCatalogueTile({super.key, required this.model, required this.onTap});
  final CatalogueCarModel model;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CardWidget(
          contentPadding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '${model.catalogueName ?? 'N/A'} (${model.totalCarCount ?? 0} cars)',
                textSize: 16,
              ),
              SmallText(
                text: '${model.vehicleExample?.make ?? 'N/A'} ${model.vehicleExample?.model ?? 'N/A'} | Or similar',
                fontWeight: FontWeight.w500,
                textColor: AppColors.lightSecondaryTextColor,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: CarRateWidget(carRate: '${model.startingSubscriptionCharge ?? '0'}')),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: -68.w,
                          top: 0,
                          bottom: 0,
                          child: NetworkImageWidget(
                            imageUrl: model.vehicleExample?.images,
                            height: 80,
                            width: 216.w,
                          ),
                        ),
                        const SizedBox(height: 90)
                      ],
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
