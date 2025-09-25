import 'package:driver_app/shared/utils/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/car_details_controller.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../controller/car_checkout_controller.dart';
import '../widgets/add_driver_widget.dart';
import '../widgets/checkout_app_scaffold.dart';
import '../widgets/extra_widget.dart';

class DriverAndExtra extends StatelessWidget {
  const DriverAndExtra({super.key});

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
      body: SafeArea(child: _bodyUI(context, controller, carDetailsController)),
      progressValue: 0.33,
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

          // Driver\'s & extras
          const TitleText(text: 'Driver\'s & extras', textSize: 18).paddingOnly(bottom: 20),
          const BodyText(
            text: 'Driver',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),
          const SmallText(
            text: 'Driver\'s License verification is required, you\'ll receive instructions before payment.',
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),

          // Minimum age requirement
          const BodyText(
            text: 'Minimum age requirement',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          RichText(
            text: TextSpan(
              style: TextStyle(
                  color: AppColors.lightSecondaryTextColor,
                  fontSize: 12,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w400),
              children: [
                const TextSpan(text: 'Minimum age requirements is '),
                TextSpan(
                    text: '${controller.driverPlan.value?.minimumAge ?? 25}.',
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.lightTextColor)),
                const TextSpan(
                    text:
                        ' Underaged drivers will be charged an additional "Young Renter Fee". The value of the fee may vary by region.'),
              ],
            ),
          ).paddingOnly(bottom: 20),

          // I am 25 years or older'
          Obx(
            () => CheckboxListTile(
              value: controller.isMinimumAge.value,
              onChanged: (value) {
                controller.isMinimumAge(value);
              },
              title: SmallText(
                text: 'I am ${controller.driverPlan.value?.minimumAge ?? 25} years or older',
                fontWeight: FontWeight.w600,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
            ),
          ).paddingOnly(bottom: 20),

          // Add driver
          if (controller.driverPlan.value != null) ...{
            AddDriverWidget(
              driverModel: controller.driverPlan.value!,
              onSelectionChanged: controller.changeDriverPlan,
            ),
            const AppDivider().paddingOnly(top: 10, bottom: 20),
          },

          // Choose extras
          const BodyText(
            text: 'Choose extras',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),
          const SmallText(
            text: 'Stay flexible! Configure your subscription now by choosing extras based on your needs',
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),

          // Extra seat
          ExtraWidget(
            extraList: controller.extraList,
            onSelectionChanged: controller.changeExtraPackages,
          ).paddingOnly(bottom: 32),

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
                  buttonText: 'Next',
                  onTap: () {
                    if (controller.isMinimumAge.value == false) {
                      showToast('Your minimum age must be ${controller.driverPlan.value?.minimumAge} years');
                      return;
                    }
                    Get.toNamed(RouterPaths.checkoutPolicies);
                  },
                ),
              ),
            ],
          )
        ],
      );
}
