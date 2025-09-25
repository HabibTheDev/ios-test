import 'package:flutter/material.dart';

import '../../core/constants/app_color.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.child,
      this.contentPadding,
      this.height,
      this.width,
      this.borderRadius = 6,
      this.backgroundColor,
      this.showShadow = true});
  final Widget child;
  final EdgeInsetsGeometry? contentPadding;
  final double? height;
  final double? width;
  final double borderRadius;
  final Color? backgroundColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: contentPadding,
      decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.lightCardColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                      color: AppColors.lightShadowColor,
                      blurRadius: 8,
                      offset: const Offset(1, 4))
                ]
              : null),
      child: child,
    );
  }
}
