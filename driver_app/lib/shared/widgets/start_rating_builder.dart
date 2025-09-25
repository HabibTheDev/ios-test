import '../../core/constants/app_color.dart';
import 'package:flutter/material.dart';

class StartRatingBuilder extends StatelessWidget {
  const StartRatingBuilder(
      {super.key, required this.rating, this.starSize = 18});
  final double rating;
  final double? starSize;

  @override
  Widget build(BuildContext context) {
    final int fullStars = rating.floor();
    final bool hasHalfStar = (rating - fullStars) >= 0.5;
    final int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < fullStars; i++)
          Icon(Icons.star, size: starSize, color: AppColors.lightStartColor),
        if (hasHalfStar)
          Icon(Icons.star_half,
              size: starSize, color: AppColors.lightStartColor),
        for (var i = 0; i < emptyStars; i++)
          Icon(Icons.star_border,
              size: starSize, color: AppColors.lightTextFieldHintColor),
      ],
    );
  }
}
