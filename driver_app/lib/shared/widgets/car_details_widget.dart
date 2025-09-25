import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../core/constants/app_color.dart';
import '../tiles/car_info_tile.dart';
import 'basic_car_details_widget.dart';

class CarDetailsWidget extends StatelessWidget {
  const CarDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BasicCarDetailsWidget().paddingOnly(bottom: 16),
        const CarInfoTile(
                leading:
                    Icon(Icons.speed, color: AppColors.primaryColor, size: 16),
                titleKey: 'Mileage',
                titleValue: '523 M')
            .paddingOnly(bottom: 4),
        const CarInfoTile(
                leading: Icon(Icons.location_on_rounded,
                    color: AppColors.primaryColor, size: 16),
                titleKey: 'Location',
                titleValue: 'Location name one')
            .paddingOnly(bottom: 16),
        const Row(
          children: [
            Expanded(
              child: CarInfoTile(titleKey: 'License', titleValue: 'XYA 1254'),
            ),
            Expanded(
              child: CarInfoTile(titleKey: 'Color', titleValue: 'Night Blue'),
            ),
          ],
        ),
      ],
    );
  }
}
