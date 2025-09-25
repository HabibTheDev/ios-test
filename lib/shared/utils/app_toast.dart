import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../core/constants/app_color.dart';
import '../repository/local/orientation_repo.dart';
import '../services/service_locator.dart';
import '../widgets/widget_imports.dart';

void showToast(String message, {ToastGravity? position, Toast toastLength = Toast.LENGTH_LONG}) =>
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: position ?? ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

void showStartStepDialog({required Function() onProceed}) {
  showDialog(
    barrierDismissible: false,
    context: Get.key.currentState!.context,
    builder: (_) => AppAlertDialog(
      iconData: Icons.pending_actions,
      title: 'Ready to start?',
      message: 'If you proceed, the task process will begin',
      primaryButtonText: 'Proceed',
      buttonAction: onProceed,
    ),
  );
}

void showAlertDialog(
  String message, {
  String? description,
  IconData alertIcon = Icons.error,
  Color themeColor = AppColors.warningColor,
}) => showDialog(
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
          backgroundColor: themeColor.withAlpha(38),
          child: Icon(alertIcon, size: 36, color: themeColor),
        ).paddingOnly(bottom: 8),
        //Title
        TitleText(text: message, textAlign: TextAlign.center).paddingOnly(bottom: 4),
        if (description != null) SmallText(text: description, textAlign: TextAlign.center),
        const HeightBox(height: 20),
        //Button
        SolidTextButton(buttonText: 'OK', backgroundColor: themeColor, onTap: () => Get.back()),
      ],
    ),
  ),
);

// Snackbar Notification
void showSnackbar(
  String message, {
  bool isError = false,
  String? title,
  IconData? icon,
  Color? backgroundColor,
  Color textColor = Colors.white,
  Duration duration = const Duration(seconds: 3),
  SnackPosition position = SnackPosition.BOTTOM,
  EdgeInsets? margin,
}) {
  Get.snackbar(
    title ?? (isError ? 'Error' : 'Success'),
    message,
    icon: Icon(icon ?? (isError ? Icons.error : Icons.check_circle), color: textColor, size: 28),
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

void screenTerminationWarning(AppLocalizations? locale, String? message, String? returnScreen) {
  showDialog(
    barrierDismissible: false,
    context: Get.key.currentState!.context,
    builder: (_) => AppAlertDialog(
      iconData: Icons.info,
      title: locale?.areYouSure ?? '',
      message: message ?? '',
      primaryButtonText: locale?.ok ?? '',
      themeColor: AppColors.warningColor,
      buttonAction: () {
        ServiceLocator.get<OrientationRepo>().portraitOrientation();
        ServiceLocator.get<OrientationRepo>().showStatusBar();
        Get.until((route) => route.settings.name == returnScreen);
      },
    ),
  );
}
