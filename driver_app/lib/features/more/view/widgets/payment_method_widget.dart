import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/payment_controller.dart';
import '../../model/payment_method_model.dart';
import 'add_payment_method.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget(
      {super.key,
      this.header,
      required this.paymentMethodList,
      required this.onChanged});
  final String? header;
  final List<PaymentMethodModel> paymentMethodList;
  final ValueChanged<PaymentMethodModel> onChanged;

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  List<PaymentMethodModel> _paymentMethods = [];
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
    _paymentMethods = List.from(widget.paymentMethodList);
    widget.onChanged(_paymentMethods.first);
  }

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.put(PaymentController());
    return CardWidget(
      contentPadding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.header != null)
            ButtonText(
              text: widget.header!,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 20),

          // Radio Items
          Column(
            children: widget.paymentMethodList.map((payment) {
              return InkWell(
                onTap: () => Get.toNamed(RouterPaths.cardInfo),
                child: BorderCardWidget(
                  contentPadding: const EdgeInsets.only(
                      left: 4, right: 12, top: 12, bottom: 12),
                  backgroundColor: groupValue == payment.radioValue!
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : null,
                  borderColor: groupValue == payment.radioValue!
                      ? AppColors.primaryColor.withOpacity(0.1)
                      : AppColors.lightBorderColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio<int>(
                        visualDensity: VisualDensity.compact,
                        value: payment.radioValue!,
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() => groupValue = value!);
                          for (var item in _paymentMethods) {
                            if (item.radioValue == groupValue) {
                              widget.onChanged(item);
                              break;
                            }
                          }
                        },
                      ).paddingOnly(right: 4),
                      CircleAvatar(
                        radius: 17,
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.15),
                      ).paddingOnly(right: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BodyText(
                              text: payment.cardNo!,
                              textColor: groupValue == payment.radioValue!
                                  ? AppColors.lightTextColor
                                  : AppColors.lightSecondaryTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            SmallText(
                              text:
                                  'Expires ${DateFormat('MMM yyyy').format(payment.expireDate!)}',
                              textColor: AppColors.lightTextFieldHintColor,
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: AppColors.lightSecondaryTextColor,
                        size: 12,
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 10),
              );
            }).toList(),
          ),

          // App payment method button
          TextButton(
            onPressed: () {
              modalBottomSheet(
                context: context,
                title: 'App payment method',
                child: AddPaymentMethod(
                  controller: controller,
                  cardActionType: CardActionEnum.add,
                ),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: 20),
                ButtonText(
                  text: ' Add method',
                  textColor: AppColors.primaryColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
