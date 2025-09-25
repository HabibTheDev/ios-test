import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/car_checkout_controller.dart';
import '../../controller/car_details_controller.dart';
import '../widgets/checkout_app_scaffold.dart';

class CheckoutPolicies extends StatelessWidget {
  const CheckoutPolicies({super.key});

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
      progressValue: 0.68,
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

          // Policies
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: 20),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.policyList.length,
            separatorBuilder: (context, index) => const AppDivider().paddingSymmetric(vertical: 20),
            itemBuilder: (context, index) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BodyText(
                  text: controller.policyList[index].policyName ?? 'N/A',
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(bottom: 10),
                HtmlWidget(
                  controller.policyList[index].typePolicy ?? 'N/A',
                  onErrorBuilder: (context, element, error) => SmallText(
                    text: '$element error: $error',
                    textColor: AppColors.lightSecondaryTextColor,
                  ),
                  onLoadingBuilder: (context, element, loadingProgress) => const CenterLoadingWidget(),
                  renderMode: RenderMode.column,
                ),
              ],
            ),
          ),

          // Agreed with all the policies
          Obx(() => CheckboxListTile(
                value: controller.agreePolicy.value,
                onChanged: (value) {
                  controller.agreePolicy(value);
                },
                title: const SmallText(
                  text: 'Agreed with all the policies',
                  fontWeight: FontWeight.w600,
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
                visualDensity: VisualDensity.compact,
              )).paddingOnly(bottom: 20),

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
                    if (controller.agreePolicy.value == false) {
                      showToast('Agree with all policies');
                      return;
                    }
                    Get.toNamed(RouterPaths.checkoutOverview);
                  },
                ),
              ),
            ],
          )
        ],
      );
}
