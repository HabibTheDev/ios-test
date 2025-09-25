import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/tiles/plan_pricing_tile.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../../explore_car/view/widgets/overview_summery_widget.dart';

class UpgradePlanSummary extends StatelessWidget {
  const UpgradePlanSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final returnScreen = Get.arguments?[ArgumentsKey.returnScreen];
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Upgrade plan',
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.local_police,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: SafeArea(child: _bodyUI(context, returnScreen)),
      closeOnTap: () {
        if (returnScreen != null) {
          Get.until((route) => route.settings.name == returnScreen);
        } else {
          Get.until((route) => route.settings.name == RouterPaths.contractDetails);
        }
      },
    );
  }

  Widget _bodyUI(BuildContext context, String? returnScreen) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Contract overview
          const HeaderWidget(title: 'Subscription summary').paddingOnly(bottom: 16),

          const PlanPricingTile(
              leadingIcon: Icons.directions_car, title: 'Subscription fee', subTitle: 'monthly', trailingText: '250'),
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
          ),
          const AppDivider(height: 30).paddingOnly(bottom: 10),

          // Checkout summery
          const OverviewSummeryWidget(),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlineTextButton(
                  buttonText: 'Previous',
                  onTap: () => Get.back(),
                ),
              ),
              const WidthBox(width: 8),
              Expanded(
                child: SolidTextButton(
                  buttonText: 'Upgrade',
                  onTap: () {
                    if (returnScreen != null) {
                      Get.until((route) => route.settings.name == returnScreen);
                    } else {
                      Get.until((route) => route.settings.name == RouterPaths.contractDetails);
                    }
                  },
                ),
              ),
            ],
          )
        ],
      );
}
