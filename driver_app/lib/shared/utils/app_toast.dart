import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../core/constants/app_color.dart';
import '../widgets/heightbox.dart';
import '../widgets/solid_text_button.dart';
import '../widgets/text_widget.dart';

void showToast(String message, {ToastGravity? position}) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: position ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0);

void showAlertDialog(
  String message, {
  String? description,
  IconData alertIcon = Icons.error,
  Color themeColor = AppColors.warningColor,
}) =>
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        scrollable: true,
        contentPadding: const EdgeInsets.all(12),
        backgroundColor: AppColors.lightCardColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Icon
            CircleAvatar(
              radius: 30,
              backgroundColor: themeColor.withOpacity(0.15),
              child: Icon(
                alertIcon,
                size: 36,
                color: themeColor,
              ),
            ).paddingOnly(bottom: 8),
            //Title
            TitleText(
              text: message,
              textAlign: TextAlign.center,
            ).paddingOnly(bottom: 4),
            if (description != null)
              SmallText(
                text: description,
                textAlign: TextAlign.center,
              ),
            const HeightBox(height: 20),
            //Button
            SolidTextButton(
              buttonText: 'OK',
              backgroundColor: themeColor,
              onTap: () => Get.back(),
            )
          ],
        ),
      ),
    );

// Snackbar Notification
void showSnackbar(String message,
    {bool isError = false,
    String? title,
    IconData? icon,
    Color? backgroundColor,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 3),
    SnackPosition position = SnackPosition.BOTTOM,
    EdgeInsets? margin}) {
  Get.snackbar(
    title ?? (isError ? 'Error' : 'Success'),
    message,
    icon: Icon(
      icon ?? (isError ? Icons.error : Icons.check_circle),
      color: textColor,
      size: 28,
    ),
    snackPosition: position,
    backgroundColor: backgroundColor ?? (isError ? AppColors.errorColor : AppColors.primaryColor),
    colorText: textColor,
    duration: duration,
    margin: margin ?? const EdgeInsets.all(20),
    padding: const EdgeInsets.all(10),
    borderRadius: 8,
    isDismissible: true,
    forwardAnimationCurve: Curves.easeInOut,
  );
}
