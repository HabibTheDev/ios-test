import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/secondary_info_tile.dart';
import '../../../../shared/tiles/status_label_tile.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../widgets/payment_receipt_widget.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.index});
  final int index;

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
                StatusLabelTile(
                  status: index % 2 == 0 ? 'Paid' : 'Failed',
                  statusColor: index % 2 == 0
                      ? AppColors.lightStartColor
                      : AppColors.errorColor,
                ),
              ],
            ),
            const SmallText(
              text: '02 May 2023 - 02 June 2023',
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 8),
            const SecondaryInfoTile(
              leadingIcon: Icons.local_atm,
              title: 'Bank transfer',
              iconSize: 18,
            )
          ],
        ),
      ),
    );
  }
}
