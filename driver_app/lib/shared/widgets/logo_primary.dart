import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/constants/app_assets.dart';

class LogoPrimary extends StatelessWidget {
  const LogoPrimary({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.assetsSvgFleetbox,
      height: (height ?? 36).h,
      width: (width ?? 207).w,
    );
  }
}
