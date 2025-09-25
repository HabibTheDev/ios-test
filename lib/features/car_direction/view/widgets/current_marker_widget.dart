import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class CurrentMarkerWidget extends StatelessWidget {
  const CurrentMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(color: AppColors.errorColor.withAlpha(51), shape: BoxShape.circle),
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 6),
            color: AppColors.errorColor,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
