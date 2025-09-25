import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class BorderCardWidget extends StatelessWidget {
  const BorderCardWidget(
      {super.key,
      required this.child,
      this.contentPadding,
      this.height,
      this.width,
      this.borderRadius = 6,
      this.backgroundColor,
      this.borderColor,
      this.borderWidth});
  final Widget child;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? width;

  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: contentPadding,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.lightCardColor,
        border: Border.all(
            color: borderColor ?? AppColors.lightBorderColor,
            width: borderWidth ?? 1),
        borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
      ),
      child: child,
    );
  }
}
