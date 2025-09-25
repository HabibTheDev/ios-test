import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/car_checkout_controller.dart';
import '../../controller/car_details_controller.dart';
import '../widgets/checkout_app_scaffold.dart';
import '../widgets/custom_protection_plan_widget.dart';
import '../widgets/mileage_package_widget.dart';
import '../widgets/protection_package_widget.dart';

class MileageAndProtection extends StatelessWidget {
  const MileageAndProtection({super.key});

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
        child: Obx(
          () => controller.isLoading.value
              ? const CenterLoadingWidget()
              : _bodyUI(
                  context,
                  controller,
                  carDetailsController,
                ),
        ),
      ),
      progressValue: 0.0,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.carDetails),
    );
  }

  Widget _bodyUI(BuildContext context, CarCheckoutController controller, CarDetailsController carDetailsController) =>
      ListView(
        addAutomaticKeepAlives: false,
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

          // Mileage & protection
          const TitleText(text: 'Mileage & protection', textSize: 18).paddingOnly(bottom: 20),
          const BodyText(
            text: 'Mileage plan',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),
          SmallText(
            text: controller.mileagePlan.value?.mileagePolicy ?? 'N/A',
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),

          // Choose mileage package
          const BodyText(
            text: 'Choose mileage package',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          MileagePackageWidget(
            onChanged: controller.changeMileagePlan,
            mileagePackageList: controller.mileagePlan.value?.mileagePackageList ?? [],
          ),
          const AppDivider().paddingOnly(top: 10, bottom: 20),

          // Protection plan
          const BodyText(
            text: 'Protection plan',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),
          SmallText(
            text: controller.protectionPlan.value?.protectionPolicy ?? 'N/A',
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),

          // Choose protection package
          const BodyText(
            text: 'Choose protection package',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          ProtectionPackageWidget(
            onChanged: controller.changeProtectionPackage,
            protectionPackageList: controller.protectionPlan.value?.protectionPackageList ?? [],
          ),

          OutlineTextButton(
                  primaryColor: AppColors.primaryColor,
                  onTap: () {
                    modalBottomSheet(
                        context: context,
                        title: 'Custom protection plan',
                        child: CustomProtectionPlanWidget(
                          customProtectionList: controller.selectedCustomProtectionList.isNotEmpty
                              ? controller.selectedCustomProtectionList
                              : controller.protectionPlan.value?.noProtectionPlans?.customProtectionList ?? [],
                          onSelectionChanged: controller.changeCustomProtection,
                        ));
                  },
                  buttonText: 'Custom package')
              .paddingOnly(bottom: 32),
          SolidTextButton(
              onTap: () {
                Get.toNamed(RouterPaths.driverAndExtra);
              },
              buttonText: 'Next'),
        ],
      );
}
