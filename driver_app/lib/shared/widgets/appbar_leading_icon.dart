import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';

class AppBarLeadingIcon extends StatelessWidget {
  const AppBarLeadingIcon({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => Get.back(),
      icon: const Icon(
        Icons.arrow_back_ios,
        size: 20,
        color: AppColors.lightAppBarIconColor,
      ),
    );
  }
}
