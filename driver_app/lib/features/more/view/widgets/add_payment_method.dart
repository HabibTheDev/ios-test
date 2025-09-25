import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/payment_controller.dart';

class AddPaymentMethod extends StatelessWidget {
  const AddPaymentMethod(
      {super.key, required this.controller, required this.cardActionType});
  final PaymentController controller;
  final CardActionEnum cardActionType;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormFieldWithLabel(
            controller: controller.cardNumber,
            required: true,
            hintText: 'Enter number',
            labelText: 'Card number',
            suffixIcon: Icons.wallet_rounded,
          ).paddingOnly(left: 16, right: 16, bottom: 16, top: 16),
          TextFormFieldWithLabel(
            controller: controller.expirationDate,
            required: true,
            hintText: 'Enter date',
            labelText: 'Expiration date',
          ).paddingOnly(left: 16, right: 16, bottom: 16),
          TextFormFieldWithLabel(
            controller: controller.cvc,
            required: true,
            hintText: 'Enter',
            labelText: 'CVC/CVV',
          ).paddingOnly(left: 16, right: 16, bottom: 16),
          const Spacer(),
          const AppDivider(height: 10.0),
          //Button
          Row(
            children: [
              Expanded(
                child: OutlineTextButton(
                  buttonText: 'Cancel',
                  onTap: () => Get.back(),
                ),
              ),
              const WidthBox(width: 8),
              Expanded(
                child: SolidTextButton(
                  buttonText:
                      cardActionType == CardActionEnum.add ? 'Add' : 'Finish',
                  onTap: () {},
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 16)
        ],
      ),
    );
  }
}
