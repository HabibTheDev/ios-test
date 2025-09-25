import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/tiles/status_label_tile.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/outline_button.dart';
import '../../../../shared/widgets/profile_photo_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/tiles/fees_and_deposit_tile.dart';
import '../../../explore_car/view/tiles/plan_pricing_tile.dart';
import '../../../more/view/tiles/info_with_icon_tile.dart';
import '../../model/contract_details_overview_model.dart';
import '../tiles/contract_overview_grid_tile.dart';

class OverviewContractDetails extends StatelessWidget {
  const OverviewContractDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Contract overview
        const HeaderWidget(title: 'Contract overview').paddingOnly(bottom: 16),

        // Car overview
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Warning note
              if (1 == 1)
                const WarningNoteWidget(
                  warningMessage: 'Cancelation request sent. Awaiting for admin\'s  approval',
                ).paddingOnly(bottom: 20),

              // Car details
              const Row(
                children: [
                  Expanded(
                    child: CarBrandDetailsWidget(
                      title: 'Luxury fleet',
                      subTitle: r'$650/m',
                      leading: CircleAvatar(
                        radius: 20,
                        child: Icon(
                          Icons.directions_car,
                          size: 24,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  StatusLabelTile(
                    status: 'Active',
                    statusColor: AppColors.lightStartColor,
                  )
                ],
              ).paddingOnly(bottom: 10),

              const CarInfoTile(titleKey: 'Contract period', titleValue: '11 Mar, 2023 -').paddingOnly(bottom: 20),

              GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(bottom: 16),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 2.7),
                itemCount: ContractDetailsOverviewModel.list.length,
                itemBuilder: (context, index) => ContractOverviewGridTile(
                  title: ContractDetailsOverviewModel.list[index].value,
                  subTitle: ContractDetailsOverviewModel.list[index].title,
                ),
              ),
              RichText(
                text: const TextSpan(
                  text: 'Exchange allowance: ',
                  style: TextStyle(color: AppColors.lightSecondaryTextColor, fontWeight: FontWeight.w400, fontSize: 12),
                  children: [
                    TextSpan(
                        text: '02',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.lightTextColor,
                        )),
                    TextSpan(text: ' /month'),
                  ],
                ),
              ).paddingOnly(bottom: 8),

              if (1 == 1)
                OutlineButton(
                  onTap: () {},
                  child: const ButtonText(
                    text: 'Withdraw cancelation',
                    textColor: AppColors.errorColor,
                  ),
                ).paddingOnly(top: 16),

              TextButton(
                onPressed: () => Get.toNamed(RouterPaths.contractAgreement),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonText(
                      text: 'View agreement ',
                      textColor: AppColors.primaryColor,
                    ),
                    Icon(Icons.arrow_forward_outlined, size: 18),
                  ],
                ),
              )
            ],
          ),
        ).paddingOnly(bottom: 10),

        // Subscription plan
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'Subscription plan',
                fontWeight: FontWeight.w700,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 20),
              const SmallText(
                text: 'Plans & pricing',
                fontWeight: FontWeight.w700,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 10),
              const PlanPricingTile(
                  leadingIcon: Icons.directions_car,
                  title: 'Subscription fee',
                  subTitle: 'monthly',
                  trailingText: '250'),
              const PlanPricingTile(
                  leadingIcon: Icons.speed,
                  title: 'Mileage package',
                  subTitle: '1200 miles (\$0.30 per additional mile)',
                  trailingText: '145'),
              const PlanPricingTile(
                leadingIcon: Icons.local_police,
                title: 'Protection plan',
                subTitle: 'Premium protection',
                trailingText: '150',
                features: [
                  'Loss damage waiver - \$60',
                  'Extended Roadside Protection - \$40',
                  'Supplemental Liability Insurance - \$50',
                ],
              ),
              const PlanPricingTile(
                  leadingIcon: Icons.person, title: 'Additional drivers', subTitle: '03', trailingText: '30'),
              const PlanPricingTile(
                leadingIcon: Icons.inventory,
                title: 'Extras',
                subTitle: '03',
                trailingText: '120',
                features: [
                  'Infant seat - 02 unit',
                  'Toddler seat - 01 unit',
                  'Boaster seat - 03 unit',
                ],
              ).paddingOnly(bottom: 10),
              const SmallText(
                text: 'Fees & Deposit',
                fontWeight: FontWeight.w700,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 10),
              const FeesAndDepositTile(
                leadingIcon: Icons.paid,
                leadingSize: 18,
                subTitleSize: 10,
                titleText: 'Deposit fees',
                subTitleText: 'Security deposit - \$500',
                trailingText: '500',
              ),
              const HeightBox(height: 5),
              const FeesAndDepositTile(
                leadingIcon: Icons.how_to_reg,
                leadingSize: 18,
                subTitleSize: 10,
                titleText: 'Enrollment fee',
                trailingText: '150',
              ),
              const HeightBox(height: 5),
              const FeesAndDepositTile(
                leadingIcon: Icons.article,
                leadingSize: 18,
                subTitleSize: 10,
                titleText: 'Cancellation fee',
                subTitleText: 'If cancel before 60 days',
                trailingText: '200',
              ),
            ],
          ),
        ).paddingOnly(bottom: 10),

        // Subscription plan
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BodyText(
                text: 'Handover & Return',
                fontWeight: FontWeight.w700,
                textColor: AppColors.lightSecondaryTextColor,
              ).paddingOnly(bottom: 20),
              BorderCardWidget(
                contentPadding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: AppColors.primaryColor,
                          size: 24,
                        ),
                        WidthBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SmallText(
                              text: 'Handover',
                              fontWeight: FontWeight.w700,
                              maxLine: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            ExtraSmallText(
                              text: 'Delivery',
                              maxLines: 1,
                              textSize: 10,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ],
                    ).paddingOnly(bottom: 10),
                    const CarInfoTile(titleKey: 'Address', titleValue: 'Location name one').paddingOnly(bottom: 6),
                    const ThreeItemInfoTile(leadingText: 'Time', titleText: '03 May 2023', trailingText: '12:04 PM'),
                  ],
                ),
              )
            ],
          ),
        ).paddingOnly(bottom: 10),

        // Valet
        CardWidget(
            contentPadding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BodyText(
                  text: 'Valet',
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(bottom: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const ProfilePhotoWidget(imageUrl: '', imageSize: 50),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleText(text: 'Nasir Shah Ali'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SmallText(
                                text: 'Office No:',
                                textColor: AppColors.primaryColor,
                              ).paddingOnly(left: 4),
                              const SmallText(
                                text: '56445675 | 324',
                                textColor: AppColors.lightSecondaryTextColor,
                              ).paddingOnly(left: 4)
                            ],
                          ),
                        ],
                      ).paddingOnly(left: 8),
                    )
                  ],
                ).paddingOnly(bottom: 10),
                const InfoWithIconTile(leadingIcon: Icons.call, title: '(218)232390').paddingOnly(bottom: 8),
                const InfoWithIconTile(leadingIcon: Icons.email, title: 'mukesh@gmail.com')
              ],
            ))
      ],
    );
  }
}
