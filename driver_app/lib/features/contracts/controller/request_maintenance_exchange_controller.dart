import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/utils/app_toast.dart';
import '../../../shared/widgets/app_alert_dialog.dart';

class RequestMaintenanceExchangeController extends GetxController {
  void cancelExchangeRequestOnTap() {
    if (Get.key.currentState != null) {
      showDialog(
        barrierDismissible: false,
        context: Get.key.currentState!.context,
        builder: (_) => AppAlertDialog(
          iconData: Icons.paid,
          title: r'Pay $50.99',
          message:
              r'Exchange fee: $50.99 /exchange. Payment will be added to next month’s bill.',
          primaryButtonText: 'Continue',
          buttonAction: () => Get.back(),
        ),
      );
    } else {
      showToast('Context not found!');
    }
  }
}
