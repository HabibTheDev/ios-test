import 'package:flutter/material.dart';
import '../../../../core/constants/app_color.dart';

class QuantityButton extends StatelessWidget {
  const QuantityButton(
      {super.key, required this.onTap, required this.iconData});
  final Function() onTap;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Container(
        height: 24,
        width: 24,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(6))),
        child: Icon(
          iconData,
          color: AppColors.lightAppBarIconColor,
          size: 18,
        ),
      ),
    );
  }
}
