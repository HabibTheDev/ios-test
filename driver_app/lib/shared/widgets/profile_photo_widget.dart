import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget({
    super.key,
    required this.imageUrl,
    this.imageSize = 60,
    this.iconSize = 50,
  });
  final String? imageUrl;
  final double imageSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(imageSize / 2)),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        height: imageSize,
        width: imageSize,
        fit: BoxFit.cover,
        placeholder: (context, url) => Icon(
          Icons.account_circle,
          color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
          size: iconSize,
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.account_circle,
          color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
          size: iconSize,
        ),
      ),
    );
  }
}
