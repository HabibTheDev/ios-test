import 'package:flutter/material.dart';
import '../../core/constants/app_color.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget(
      {super.key, required this.progressValue, this.color, this.trackColor, this.width, this.height});
  final double progressValue;
  final Color? color;
  final Color? trackColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        child: LinearProgressIndicator(
          value: progressValue,
          color: color ?? AppColors.primaryColor,
          minHeight: height ?? 5,
          backgroundColor: trackColor ?? AppColors.lightCardProgressTrackColor,
        ),
      ),
    );
  }
}
