import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../explore_car/model/protection_plan_model.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../../explore_car/view/widgets/custom_protection_plan_widget.dart';
import '../../../explore_car/view/widgets/extra_widget.dart';
import '../../../explore_car/view/widgets/mileage_package_widget.dart';
import '../../../explore_car/view/widgets/protection_package_widget.dart';

class UpgradePlan extends StatelessWidget {
  const UpgradePlan({super.key});

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
          // Car details
          const CarBrandDetailsWidget(
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
          ).paddingOnly(bottom: 32),

          // Choose mileage package
          const BodyText(
            text: 'Choose mileage package',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          MileagePackageWidget(
            onChanged: (value) {
              debugPrint(value.title);
            },
            mileagePackageList: [],
          ),
          const AppDivider().paddingOnly(top: 10, bottom: 20),

          // Choose protection package
          const BodyText(
            text: 'Choose protection package',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          ProtectionPackageWidget(
            onChanged: (value) {
              debugPrint(value.title);
            },
            protectionPackageList: [],
          ),

          OutlineTextButton(
              primaryColor: AppColors.primaryColor,
              onTap: () {
                modalBottomSheet(
                    context: context,
                    title: 'Custom protection plan',
                    child: CustomProtectionPlanWidget(
                      customProtectionList: [],
                      onSelectionChanged: (List<CustomProtectionModel> value) {
                        for (var e in value) {
                          debugPrint('${e..coverageTitle}: ${e.checkValue}');
                        }
                      },
                    ));
              },
              buttonText: 'Custom package'),
          const AppDivider().paddingOnly(top: 10, bottom: 20),

          // Additional drivers
          const BodyText(
            text: 'Additional drivers',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          // TODO: implement onInit
          // AddDriverWidget(
          //   driverList: DriverModel.driverList,
          //   onSelectionChanged: (value) {
          //     debugPrint('::::::::::::');
          //     for (var e in value) {
          //       debugPrint('${e.title}: ${e.quantity}');
          //     }
          //     debugPrint('::::::::::::');
          //   },
          // ),
          const AppDivider().paddingOnly(top: 10, bottom: 20),

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
              extraList: [],
              onSelectionChanged: (seatList) {
                debugPrint('::::::::::::');
                for (var e in seatList) {
                  debugPrint('${e.title}: ${e.quantity}');
                }
                debugPrint('::::::::::::');
              }).paddingOnly(bottom: 32),

          // Buttons
          SolidTextButton(
            buttonText: 'Next',
            onTap: () =>
                Get.toNamed(RouterPaths.upgradePlanSummary, arguments: {ArgumentsKey.returnScreen: returnScreen}),
          )
        ],
      );
}
