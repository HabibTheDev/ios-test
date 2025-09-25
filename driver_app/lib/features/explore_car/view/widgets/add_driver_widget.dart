import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/checkout_driver_model.dart';
import 'quantity_button.dart';

class AddDriverWidget extends StatefulWidget {
  const AddDriverWidget({super.key, required this.driverModel, required this.onSelectionChanged});
  final CheckoutDriverModel driverModel;
  final ValueChanged<CheckoutDriverModel> onSelectionChanged;

  @override
  State<AddDriverWidget> createState() => _AddDriverWidgetState();
}

class _AddDriverWidgetState extends State<AddDriverWidget> {
  late CheckoutDriverModel _driverModel;

  @override
  void initState() {
    super.initState();
    _driverModel = widget.driverModel;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration:
          const BoxDecoration(color: AppColors.lightBgColor, borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          const BodyText(
            text: 'Add drivers',
            fontWeight: FontWeight.w600,
          ).paddingOnly(bottom: 3),

          // Description
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              style:
                  const TextStyle(color: AppColors.lightSecondaryTextColor, fontSize: 12, fontWeight: FontWeight.w400),
              children: [
                const TextSpan(text: 'Want to share the driving? add up to '),
                TextSpan(
                    text: '${_driverModel.maxDriver}',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.lightTextColor)),
                const TextSpan(text: ' additional drivers.'),
              ],
            ),
          ).paddingOnly(bottom: 10),

          // Rate and Buttons
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                        color: AppColors.lightSecondaryTextColor, fontSize: 12, fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: '${_driverModel.driverPrice ?? 0.0}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18, color: AppColors.lightTextColor)),
                      const TextSpan(text: '\$', style: TextStyle(color: AppColors.lightTextColor)),
                      const TextSpan(text: ' /m & unit'),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      QuantityButton(
                          onTap: () {
                            if (_driverModel.quantity > 0) {
                              setState(() => _driverModel.quantity--);
                              widget.onSelectionChanged(_driverModel.copyWith(quantity: _driverModel.quantity));
                            }
                          },
                          iconData: Icons.remove),
                      TitleText(
                        text: '${_driverModel.quantity}',
                        textSize: 16,
                      ),
                      QuantityButton(
                          onTap: () {
                            if (_driverModel.quantity < _driverModel.maxDriver!) {
                              setState(() => _driverModel.quantity++);
                              widget.onSelectionChanged(_driverModel.copyWith(quantity: _driverModel.quantity));
                            }
                          },
                          iconData: Icons.add),
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
