import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/custom_list_tile.dart';
import '../../../../shared/tiles/information_tile.dart';
import '../../../../shared/tiles/status_label_tile.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/normal_card.dart';
import '../../../../shared/widgets/outline_button.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';

class PaymentReceiptWidget extends StatelessWidget {
  const PaymentReceiptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: CarBrandDetailsWidget(
                            leading: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.local_atm,
                                color: AppColors.primaryColor,
                                size: 30,
                              ),
                            ),
                            title: 'Payment receipt',
                            subTitle: '#ID20034'),
                      ),
                      StatusLabelTile(
                          status: 'Paid',
                          statusColor: AppColors.lightStartColor),
                    ],
                  ).paddingOnly(bottom: 20),
                  const ThreeItemInfoTile(
                    leadingText: 'Payment date',
                    titleText: '11 Mar 2023',
                    trailingText: '12:34 PM',
                  ).paddingOnly(bottom: 4),
                  const ThreeItemInfoTile(
                    leadingText: 'Billing period',
                    titleText: '02 May 2023 - 02 June 2023',
                  ).paddingOnly(bottom: 16),

                  // Bill from
                  const BorderCardWidget(
                    contentPadding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: 'Bill from:',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        SmallText(
                          text: 'Cars Canada',
                          fontWeight: FontWeight.w700,
                        ),
                        SmallText(
                          text: 'carscanada@car.io',
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                        SmallText(
                          text: 'Vancouver, Canada',
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 12),

                  // Bill to
                  const BorderCardWidget(
                    contentPadding: EdgeInsets.all(12),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallText(
                          text: 'Bill to:',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ),
                        SmallText(
                          text: 'Danish Ali',
                          fontWeight: FontWeight.w700,
                        ),
                        SmallText(
                          text: 'danish@email.com',
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                        SmallText(
                          text: '23/6 Dire Streets, Ontario, CA',
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 20),

                  NormalCard(
                    contentPadding: const EdgeInsets.all(12),
                    backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                    child: const CustomListTile(
                      contentPadding: EdgeInsets.zero,
                      leadingText: 'S/N',
                      leadingColor: AppColors.lightSecondaryTextColor,
                      title: 'Items',
                      titleColor: AppColors.lightSecondaryTextColor,
                      trailingText: 'Amount',
                      trailingColor: AppColors.lightSecondaryTextColor,
                    ),
                  ).paddingOnly(bottom: 10),
                  const CustomListTile(
                    leadingText: '01',
                    title: 'Subscription fee',
                    subtitle: 'Monthly',
                    trailingText: r'$453',
                  ),
                  const AppDivider(height: 20),
                  const CustomListTile(
                    leadingText: '02',
                    title: 'Mileage package',
                    subtitle: r'1200 miles ($0.40 per additional mile)',
                    trailingText: r'$453',
                  ),
                  const AppDivider(height: 20),
                  const CustomListTile(
                    leadingText: '03',
                    title: 'Protection plan',
                    subtitle: 'Premium protection',
                    trailingText: r'$453',
                  ),
                  const AppDivider(height: 20),
                  const CustomListTile(
                    leadingText: '04',
                    title: 'Additional drivers',
                    subtitle: '03',
                    trailingText: r'$453',
                  ),
                  const AppDivider(height: 20),
                  const CustomListTile(
                    leadingText: '05',
                    title: 'Extras',
                    subtitle: '04',
                    trailingText: r'$453',
                  ),
                  const AppDivider(height: 20),
                  const CustomListTile(
                    leadingText: '06',
                    title: 'Additional mileage',
                    subtitle: '40 miles',
                    trailingText: r'$453',
                  ),
                  const AppDivider(height: 20),
                  const CustomListTile(
                    title: 'Total',
                    titleFontSize: 18,
                    titleFontWeight: FontWeight.w600,
                    trailingText: r'$453',
                    trailingFontSize: 18,
                    trailingFontWeight: FontWeight.w600,
                  ),
                  const AppDivider(height: 20).paddingOnly(bottom: 10),

                  // Financial
                  const HeaderWidget(title: 'Account details')
                      .paddingOnly(bottom: 16),

                  const InformationTile(
                      keyText: 'Payment Method', title: 'Visa transfer'),
                  const AppDivider(height: 20),
                  const InformationTile(
                      keyText: 'Card holder name', title: 'Danish Ali'),
                  const AppDivider(height: 20),
                  const InformationTile(
                      keyText: 'Card number', title: '3434 43434 4326 7777'),
                  const AppDivider(height: 20),
                  const InformationTile(
                      keyText: 'Expiration date', title: 'an 2025'),
                  const AppDivider(height: 20),
                  const InformationTile(keyText: 'CVC / CVV', title: '345'),
                ],
              ),
            ),
          ),

          //Button
          Row(
            children: [
              Expanded(
                child: OutlineTextButton(
                  buttonText: 'Close',
                  onTap: () => Get.back(),
                ),
              ),
              const WidthBox(width: 8),
              Expanded(
                  child: OutlineButton(
                primaryColor: AppColors.primaryColor,
                onTap: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_download_outlined,
                      color: AppColors.primaryColor,
                    ),
                    ButtonText(
                      text: 'Download',
                      textColor: AppColors.primaryColor,
                    )
                  ],
                ),
              )),
            ],
          ).paddingSymmetric(horizontal: 16)
        ],
      ),
    );
  }
}
