import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/outline_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/payment_controller.dart';
import '../tiles/border_table.dart';
import '../widgets/add_payment_method.dart';

class CardInfo extends StatelessWidget {
  const CardInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final PaymentController controller = Get.find();
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'Card info',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //Card name and date
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                ).paddingOnly(right: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BodyText(
                        text: 'Visa Card',
                        textSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      SmallText(
                        text:
                            'Added in ${DateFormat('MMM yyyy').format(DateTime.now())}',
                        textColor: AppColors.lightTextFieldHintColor,
                      ),
                    ],
                  ),
                ),
              ],
            ).paddingOnly(bottom: 32),

            //Card details
            const BorderedTable(
              rows: [
                ['Card number:', '4000 4567 6789 9010'],
                ['Expiration date:', 'Jan 2025'],
                ['CVC / CVV:', '324'],
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlineButton(
                onTap: () {
                  controller.removeCardOnTap();
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      CupertinoIcons.trash,
                      color: AppColors.errorColor,
                      size: 16,
                    ),
                    ButtonText(
                      text: ' Remove',
                      textColor: AppColors.errorColor,
                    )
                  ],
                ),
              ),
            ),
            const WidthBox(width: 8),
            Expanded(
              child: SolidTextButton(
                buttonText: 'Customize',
                onTap: () {
                  modalBottomSheet(
                      context: context,
                      title: 'Edit payment method',
                      child: AddPaymentMethod(
                        controller: controller,
                        cardActionType: CardActionEnum.edit,
                      ));
                },
              ),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
