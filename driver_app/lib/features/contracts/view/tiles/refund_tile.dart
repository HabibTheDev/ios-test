import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/secondary_info_tile.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../widgets/payment_receipt_widget.dart';

class RefundTile extends StatelessWidget {
  const RefundTile({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        modalBottomSheet(
          context: context,
          child: const PaymentReceiptWidget(),
        );
      },
      child: BorderCardWidget(
        contentPadding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: const TextSpan(
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightTextColor),
                      children: [
                        TextSpan(text: '2,155'),
                        TextSpan(
                            text: r'$',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            )),
                      ],
                    ),
                  ),
                ),
                const SmallText(
                  text: '12 Jan 2023',
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.lightSecondaryTextColor,
                )
              ],
            ).paddingOnly(bottom: 8),
            const SecondaryInfoTile(
              leadingIcon: Icons.local_atm,
              title: 'Bank transfer',
              iconSize: 18,
            ).paddingOnly(bottom: 4),
            const SecondaryInfoTile(
              leadingIcon: Icons.currency_exchange,
              title: 'Extra charge taken',
              iconSize: 18,
            ),
          ],
        ),
      ),
    );
  }
}
