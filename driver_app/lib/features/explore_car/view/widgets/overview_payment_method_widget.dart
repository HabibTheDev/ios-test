import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/overview_payment_method_model.dart';

class OverviewPaymentMethodWidget extends StatefulWidget {
  final List<OverviewPaymentMethodModel> paymentMethodList;
  final ValueChanged<OverviewPaymentMethodModel> onChanged;

  const OverviewPaymentMethodWidget({
    super.key,
    required this.paymentMethodList,
    required this.onChanged,
  });

  @override
  State<OverviewPaymentMethodWidget> createState() =>
      _OverviewPaymentMethodWidgetState();
}

class _OverviewPaymentMethodWidgetState
    extends State<OverviewPaymentMethodWidget> {
  List<OverviewPaymentMethodModel> _paymentMethods = [];
  int groupValue = 0;
  final cardNo = TextEditingController();
  final mmYY = TextEditingController();
  final cvc = TextEditingController();

  @override
  void initState() {
    super.initState();
    _paymentMethods = List.from(widget.paymentMethodList);
    widget.onChanged(_paymentMethods.first);

    cardNo.addListener(changeCardInfo);
    mmYY.addListener(changeCardInfo);
    cvc.addListener(changeCardInfo);
  }

  void changeCardInfo() {
    for (var item in _paymentMethods) {
      if (item.radioValue == groupValue) {
        final model = item.copyWith(
          cardNumber: cardNo.text,
          mmYY: mmYY.text,
          cvc: cvc.text,
        );
        widget.onChanged(model);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.paymentMethodList.map((paymentMethod) {
        return BorderCardWidget(
          contentPadding:
              const EdgeInsets.only(left: 12, right: 16, top: 12, bottom: 12),
          backgroundColor: groupValue == paymentMethod.radioValue
              ? AppColors.primaryColor.withOpacity(0.1)
              : AppColors.lightCardColor,
          borderColor: groupValue == paymentMethod.radioValue
              ? AppColors.primaryColor.withOpacity(0.1)
              : null,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<int>(
                    visualDensity: VisualDensity.compact,
                    value: paymentMethod.radioValue!,
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallText(
                          text: '${paymentMethod.title}',
                          textColor: groupValue == paymentMethod.radioValue
                              ? AppColors.lightTextColor
                              : AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w700,
                        ).paddingOnly(bottom: 2),
                        ExtraSmallText(
                          text: '${paymentMethod.description}',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ).paddingOnly(bottom: 10),
                      ],
                    ),
                  ),
                ],
              ),
              if (paymentMethod.title == 'New card' &&
                  groupValue == paymentMethod.radioValue)
                Column(
                  children: [
                    TextFormFieldWidget(
                      controller: cardNo,
                      required: true,
                      hintText: 'Card number',
                      textInputType: TextInputType.number,
                      fillColor: AppColors.lightCardColor,
                      suffixIcon: Icons.wallet_rounded,
                    ).paddingOnly(bottom: 5),
                    TextFormFieldWidget(
                      controller: mmYY,
                      required: true,
                      hintText: 'MM/YY',
                      fillColor: AppColors.lightCardColor,
                    ).paddingOnly(bottom: 5),
                    TextFormFieldWidget(
                      controller: cvc,
                      required: true,
                      hintText: 'CVC',
                      fillColor: AppColors.lightCardColor,
                    ),
                  ],
                ).paddingOnly(top: 16)
            ],
          ),
        ).paddingOnly(bottom: 10);
      }).toList(),
    );
  }
}
