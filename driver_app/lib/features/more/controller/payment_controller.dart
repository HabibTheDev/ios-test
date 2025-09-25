import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_color.dart';
import '../../../shared/widgets/app_alert_dialog.dart';

class PaymentController extends GetxController {
  final TextEditingController cardNumber = TextEditingController();
  final TextEditingController expirationDate = TextEditingController();
  final TextEditingController cvc = TextEditingController();

  Future<void> removeCardOnTap() async {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        title: 'Are you sure?',
        message: 'If you proceed, this card will be removed permanently.',
        primaryButtonText: 'OK',
        themeColor: AppColors.errorColor,
        buttonAction: () {},
      ),
    );
  }
}
