import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class ImagePlaceholderWidget extends StatelessWidget {
  const ImagePlaceholderWidget({
    super.key,
    this.width,
    this.iconSize,
    this.height,
    this.iconData,
  });
  final double? height;
  final double? width;
  final double? iconSize;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData ?? Icons.image,
      color: AppColors.lightTextFieldHintColor.withOpacity(0.4),
      size: iconSize ?? 50,
    );
  }
}
