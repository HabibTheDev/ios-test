import 'package:employee_app/shared/widgets/widget_imports.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class CarHealthOverviewWidget extends StatelessWidget {
  const CarHealthOverviewWidget({
    super.key,
    required this.engineOilLabel,
    required this.fuelLabel,
    required this.batteryLabel,
    required this.tireLabel,
  });
  final double engineOilLabel;
  final double fuelLabel;
  final double batteryLabel;
  final double tireLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _overviewWidget(engineOilLabel, 'Engine oil'),
        _overviewWidget(fuelLabel, 'Fuel level'),
        _overviewWidget(batteryLabel, 'Battery level'),
        _overviewWidget(tireLabel, 'Tire pressure'),
      ],
    );
  }

  Widget _overviewWidget(double value, String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 48,
                width: 48,
                child: CircularProgressIndicator(
                  color: _getCircularProgressColor(value),
                  value: value,
                  strokeWidth: 5,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.black12,
                ),
              ),
              BodyText(text: '${(value * 100).round()}%'),
            ],
          ),
          const HeightBox(height: 4),
          SmallText(
            text: title,
            textColor: AppColors.lightSecondaryTextColor,
            maxLine: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Color _getCircularProgressColor(double value) {
    if (value >= 0.5) {
      return AppColors.primaryColor;
    } else if (value < 0.5 && value >= 0.4) {
      return AppColors.emojiColor;
    } else {
      return AppColors.errorColor;
    }
  }
}
