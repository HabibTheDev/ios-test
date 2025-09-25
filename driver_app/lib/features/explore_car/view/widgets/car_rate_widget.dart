import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class CarRateWidget extends StatelessWidget {
  const CarRateWidget({super.key, required this.carRate});
  final String carRate;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'from ',
        style: const TextStyle(
            color: AppColors.lightSecondaryTextColor,
            fontSize: 12,
            fontWeight: FontWeight.w500),
        children: [
          TextSpan(
              text: carRate,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: AppColors.lightTextColor)),
          const TextSpan(
              text: '\$', style: TextStyle(color: AppColors.lightTextColor)),
          const TextSpan(text: ' /m'),
        ],
      ),
    );
  }
}
