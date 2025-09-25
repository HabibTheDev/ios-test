import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/car_checkout_controller.dart';
import '../../controller/car_details_controller.dart';
import '../../model/overview_payment_method_model.dart';
import '../tiles/fees_and_deposit_tile.dart';
import '../tiles/plan_pricing_tile.dart';
import '../widgets/checkout_app_scaffold.dart';
import '../widgets/handover_method_widget.dart';
import '../widgets/overview_payment_method_widget.dart';
import '../widgets/overview_summery_widget.dart';

class CheckoutOverview extends StatelessWidget {
  const CheckoutOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final CarCheckoutController controller = Get.find();
    final CarDetailsController carDetailsController = Get.find();
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Checkout',
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.no_crash,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: SafeArea(
        child: _bodyUI(context, controller, carDetailsController),
      ),
      progressValue: 1.0,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.carDetails),
    );
  }

  Widget _bodyUI(BuildContext context, CarCheckoutController controller, CarDetailsController carDetailsController) =>
      ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Car details
          BasicCarDetailsWidget(
            brandLogo: carDetailsController.carDetailsModel.value?.brandLogo,
            make: carDetailsController.carDetailsModel.value?.make,
            model: carDetailsController.carDetailsModel.value?.model,
            year: carDetailsController.carDetailsModel.value?.year,
            carImage: carDetailsController.carDetailsModel.value?.images,
            carWidth: 264,
          ).paddingOnly(bottom: 32),

          // Overview
          const TitleText(text: 'Overview', textSize: 18).paddingOnly(bottom: 20),

          // Subscription plan
          const BodyText(
            text: 'Subscription plan',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),
          const SmallText(
            text: 'Plans & pricings',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          const PlanPricingTile(
              leadingIcon: Icons.directions_car, title: 'Subscription fee', subTitle: 'monthly', trailingText: '250'),
          PlanPricingTile(
              leadingIcon: Icons.speed,
              title: 'Mileage package',
              subTitle:
                  '${controller.selectedMileagePackage?.includedMileage} miles (\$${controller.selectedMileagePackage?.extraMileageCharge} per additional mile)',
              trailingText: '${controller.selectedMileagePackage?.totalPrice ?? 0.0}'),
          PlanPricingTile(
            leadingIcon: Icons.local_police,
            title: 'Protection plan',
            subTitle: '${controller.selectedProtectionPackage?.title}',
            trailingText: '${controller.selectedProtectionPackage?.packagePrice}',
            features: controller.selectedProtectionPackage?.coverages?.map((e) => e.toString()).toList(),
          ),
          if (controller.selectedDriverPlan?.quantity != 0)
            PlanPricingTile(
                leadingIcon: Icons.person,
                title: 'Additional drivers',
                subTitle: '${controller.selectedDriverPlan?.quantity}',
                trailingText:
                    '${(controller.selectedDriverPlan?.quantity ?? 1) * (controller.selectedDriverPlan?.driverPrice ?? 1)}'),
          PlanPricingTile(
            leadingIcon: Icons.inventory,
            title: 'Extras',
            subTitle: '${controller.selectedExtraList.where((e) => e.quantity != 0).toList().length}',
            trailingText:
                '${controller.selectedExtraList.where((e) => e.quantity != 0).fold(0, (sum, item) => sum + (item.quantity * (item.packagePrice ?? 0)))}', // Total sum of quantity * packagePrice
            features: controller.selectedExtraList
                .where((e) => e.quantity != 0)
                .map((item) => '${item.title} - ${item.quantity} unit')
                .toList(),
          ).paddingOnly(bottom: 10),

          // Fees & Deposit

          if (carDetailsController.carDetailsModel.value?.catalogue?.feesAndDeposit != null)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TitleText(text: 'Fees & Deposit', textSize: 18).paddingOnly(bottom: 16),
                FeesAndDepositTile(
                  leadingIcon: Icons.paid,
                  titleText: 'Deposit fees',
                  subTitleText:
                      'Security deposit - \$${carDetailsController.carDetailsModel.value?.catalogue?.feesAndDeposit?.securityDeposit ?? 0.0}',
                  trailingText:
                      '${carDetailsController.carDetailsModel.value?.catalogue?.feesAndDeposit?.securityDeposit ?? 0.0}',
                ).paddingOnly(bottom: 5),
                if (carDetailsController.carDetailsModel.value?.catalogue?.feesAndDeposit?.isEnrollmentFee == true)
                  FeesAndDepositTile(
                    leadingIcon: Icons.how_to_reg,
                    titleText: 'Enrollment fee',
                    trailingText:
                        '${carDetailsController.carDetailsModel.value?.catalogue?.feesAndDeposit?.totalFee ?? 0.0}',
                  ).paddingOnly(bottom: 5),
                if (carDetailsController.carDetailsModel.value?.catalogue?.feesAndDeposit?.isCanceletaionFee == true)
                  FeesAndDepositTile(
                    leadingIcon: Icons.article,
                    titleText: 'Cancelation fee',
                    subTitleText: 'If cancel before 60 days',
                    trailingText:
                        '${carDetailsController.carDetailsModel.value?.catalogue?.feesAndDeposit?.totalCancelFee ?? 0.0}',
                  ).paddingOnly(bottom: 10),
                const AppDivider().paddingSymmetric(vertical: 20),
              ],
            ),

          // Handover method
          HandoverMethodWidget(controller: controller),
          const AppDivider().paddingSymmetric(vertical: 20),

          // Check out
          const BodyText(
            text: 'Check out',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),
          const SmallText(
            text: 'Choose payment method',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),
          OverviewPaymentMethodWidget(
            paymentMethodList: OverviewPaymentMethodModel.paymentMethodList,
            onChanged: (value) {
              debugPrint('Title: ${value.title}');
              debugPrint('Card No: ${value.cardNumber}');
              debugPrint('MM/YY: ${value.mmYY}');
              debugPrint('CVC: ${value.cvc}');
            },
          ),
          const AppDivider().paddingSymmetric(vertical: 20),

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
                  buttonText: 'Finish Checkout',
                  onTap: () {
                    Get.until((route) => route.settings.name == RouterPaths.carDetails);
                  },
                ),
              ),
            ],
          )
        ],
      );
}
