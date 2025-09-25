import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/tiles/information_tile.dart';
import '../../../../shared/tiles/un_order_list.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/image_placeholder_widget.dart';
import '../../../../shared/widgets/logo_primary.dart';
import '../../../../shared/widgets/text_widget.dart';

class ContractAgreement extends StatelessWidget {
  const ContractAgreement({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'Contract agreement',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CardWidget(
              contentPadding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: const LogoPrimary(height: 24).paddingOnly(bottom: 32, top: 16),
                  ),

                  const BodyText(text: 'This agreement involves the following parties:').paddingOnly(bottom: 16),
                  const InformationTile(
                    keyText: 'The owner',
                    title: 'Cars Canada',
                    subtitle: ['carscanada@car.io', 'Vancouver, Canada'],
                  ).paddingOnly(bottom: 16),
                  const InformationTile(
                    keyText: 'The driver',
                    title: 'Danish Ali',
                    subtitle: ['danish@email.com', '(219)555-0114'],
                  ).paddingOnly(bottom: 32),

                  // Rent info
                  const TitleText(
                    text: 'Rent info',
                    textSize: 18,
                  ).paddingOnly(bottom: 16),
                  const InformationTile(
                    keyText: 'start date',
                    title: '01 Jan 2023',
                    titleFontWeight: FontWeight.w500,
                  ),
                  const AppDivider(height: 20),
                  const InformationTile(
                    keyText: 'Handover method',
                    title: 'Pick-up',
                    titleFontWeight: FontWeight.w500,
                  ),
                  const AppDivider(height: 20),
                  const InformationTile(
                    keyText: 'Handover date',
                    title: '05 Jan 2023',
                    titleFontWeight: FontWeight.w500,
                  ),
                  const AppDivider(height: 20),
                  const InformationTile(
                    keyText: 'Monthly fee',
                    title: r'$423/month',
                    titleFontWeight: FontWeight.w500,
                  ),
                  const AppDivider(height: 20),
                  const InformationTile(
                    keyText: 'Total deposit',
                    title: r'$1,000',
                    titleFontWeight: FontWeight.w500,
                  ),
                  const AppDivider(height: 20),
                  const InformationTile(
                    keyText: 'Enrollment fee:',
                    title: r'$200',
                    titleFontWeight: FontWeight.w500,
                  ).paddingOnly(bottom: 32),

                  // Security deposit
                  const TitleText(
                    text: 'Security deposit',
                    textSize: 18,
                  ).paddingOnly(bottom: 10),
                  const SmallText(
                    text:
                        'To reserve your trip, we\'ll pre-authorize a temporary \$500.00 deposit on your card 24 hours before it begins. This amount will be released when your subscription ends. For subscriptions over 30 days, we\'ll refresh the deposit as needed.',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 32),

                  // Insurance
                  const TitleText(
                    text: 'Insurance',
                    textSize: 18,
                  ).paddingOnly(bottom: 10),
                  const SmallText(
                    text:
                        'The Lessee is required to maintain appropriate insurance coverage for the rental vehicle during the rental period. Proof of insurance must be provided at the time of vehicle pickup.',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 32),

                  // Prohibited uses
                  const TitleText(
                    text: 'Prohibited uses',
                    textSize: 18,
                  ).paddingOnly(bottom: 10),
                  const SmallText(
                    text: 'The lessee agreement not to: ',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 10),
                  const UnOrderList(
                    items: [
                      'Sublet or lend the vehicle to any third party.',
                      'Use the vehicle for illegal activities.',
                      'Operate the vehicle under the influence of alcohol or drugs.',
                      'Use the vehicle for racing or other prohibited activities.',
                    ],
                  ).paddingOnly(bottom: 32),

                  // Maintenance and repairs
                  const TitleText(
                    text: 'Maintenance and repairs',
                    textSize: 18,
                  ).paddingOnly(bottom: 10),
                  const SmallText(
                    text:
                        'The Lessee is responsible for routine maintenance, including oil changes and tire rotations, and shall inform the Lessor promptly of any mechanical issues.',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 32),

                  // Return of the vehicle
                  const TitleText(
                    text: 'Return of the vehicle',
                    textSize: 18,
                  ).paddingOnly(bottom: 10),
                  const SmallText(
                    text:
                        'The Lessee agrees to return the vehicle to the designated location by the specified end date. Any late returns may result in additional charges.',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 32),

                  // Damages and repairs
                  const TitleText(
                    text: 'Damages and repairs',
                    textSize: 18,
                  ).paddingOnly(bottom: 10),
                  const SmallText(
                    text:
                        'The Lessee is responsible for any damage to the vehicle during the rental period. The Lessor will assess and charge the Lessee for necessary repairs.',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 32),

                  // Governing Law
                  const TitleText(
                    text: 'Governing Law',
                    textSize: 18,
                  ).paddingOnly(bottom: 10),
                  const SmallText(
                    text:
                        'This Agreement shall be governed by the laws of [Jurisdiction], and any disputes shall be resolved in accordance with these laws.',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 32),

                  // The driver
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 2,
                        child: SmallText(
                          text: 'The driver ',
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CachedNetworkImage(
                                imageUrl:
                                    'https://onlinepngtools.com/images/examples-onlinepngtools/george-walker-bush-signature.png',
                                height: 70,
                                fit: BoxFit.fitHeight,
                                placeholder: (context, url) => const ImagePlaceholderWidget(height: 70),
                                errorWidget: (context, url, error) => const ImagePlaceholderWidget(height: 70),
                              ),
                              const AppDivider(height: 20),
                              const CarInfoTile(titleKey: 'Date', titleValue: '02 Jan 2024')
                            ],
                          ))
                    ],
                  ).paddingOnly(bottom: 32)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
