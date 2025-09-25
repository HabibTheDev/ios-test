import 'package:flutter/material.dart';
import '../../../../shared/widgets/progress_bar_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';

class CheckoutAppScaffold extends StatelessWidget {
  const CheckoutAppScaffold(
      {super.key,
      required this.title,
      required this.leading,
      required this.body,
      this.progressValue,
      this.backgroundColor,
      required this.closeOnTap,
      this.bottomNavigationBar,
      this.progressColor});

  final String title;
  final Widget leading;
  final Widget body;
  final double? progressValue;
  final Color? backgroundColor;
  final Color? progressColor;
  final Function() closeOnTap;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.lightBgColor,
      appBar: AppBar(
        centerTitle: false,
        leading: leading,
        titleSpacing: -8,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonText(
              text: title,
              textSize: 16,
              textColor: AppColors.lightAppBarIconColor,
              maxLines: 1,
            ),
            if (progressValue != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  BodyText(
                    text: '${(progressValue! * 100).round()}% ',
                    textColor: AppColors.lightAppBarIconColor,
                  ),
                  ProgressBarWidget(
                    progressValue: progressValue!,
                    width: 196,
                    height: 8,
                    color: progressColor ?? AppColors.lightProgressColor,
                    trackColor: AppColors.lightAppBarProgressTrackColor,
                  ),
                ],
              )
          ],
        ),
        actions: [
          IconButton(
            onPressed: closeOnTap,
            icon: const Icon(
              Icons.close,
              size: 20,
              color: AppColors.lightAppBarIconColor,
            ),
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
