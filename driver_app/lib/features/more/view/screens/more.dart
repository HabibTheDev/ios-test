import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/services/remote/profile_service.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_dropdown.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/list_refresh_ndicator.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../../../shared/widgets/outline_button.dart';
import '../../../../shared/widgets/profile_photo_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/more_controller.dart';
import '../../controller/profile_controller.dart';
import '../tiles/menu_tile.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController(ProfileService()));
    return GetBuilder<MoreController>(
        init: MoreController(),
        autoRemove: false,
        builder: (controller) {
          return ListRefreshIndicator(
            onRefresh: () async => await controller.onInit(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                // title
                const HeaderWidget(title: 'More').paddingOnly(bottom: 20),
                // User Card
                CardWidget(
                    contentPadding: const EdgeInsets.all(16),
                    child: Obx(
                      () => controller.isLoading.value
                          ? const CenterLoadingWidget()
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ProfilePhotoWidget(
                                        imageSize: 48, imageUrl: profileController.customerModel.value?.photo),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              TitleText(text: profileController.customerModel.value?.fullName ?? 'N/A'),
                                              Icon(
                                                Icons.verified,
                                                color: profileController.customerModel.value?.verified == true
                                                    ? AppColors.lightProgressColor
                                                    : AppColors.lightSecondaryTextColor,
                                                size: 14,
                                              ).paddingOnly(left: 8),
                                              SmallText(
                                                text: profileController.customerModel.value?.verified == true
                                                    ? 'verified'
                                                    : 'not verified',
                                                textColor: profileController.customerModel.value?.verified == true
                                                    ? AppColors.lightProgressColor
                                                    : AppColors.lightSecondaryTextColor,
                                              ).paddingOnly(left: 4)
                                            ],
                                          ),
                                          SmallText(
                                            text: profileController.customerModel.value?.email ?? 'N/A',
                                            textColor: AppColors.lightSecondaryTextColor,
                                          ),
                                        ],
                                      ).paddingOnly(left: 8),
                                    )
                                  ],
                                ).paddingOnly(bottom: 20),
                                InkWell(
                                  onTap: () => Get.toNamed(RouterPaths.myProfile),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const BodyText(
                                        text: 'View profile',
                                        textColor: AppColors.primaryColor,
                                        fontWeight: FontWeight.w600,
                                      ).paddingOnly(right: 4),
                                      const Icon(
                                        Icons.arrow_forward,
                                        color: AppColors.primaryColor,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                    )).paddingOnly(bottom: 10),

                //My feedbacks
                CardWidget(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: MenuTile(
                    leadingSvgAsset: Assets.assetsSvgFeedback,
                    title: 'My feedbacks',
                    onTap: () => Get.toNamed(RouterPaths.myFeedbacks),
                  ),
                ).paddingOnly(bottom: 10),

                // Menu Widget
                CardWidget(
                    contentPadding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Change password
                        MenuTile(
                          leadingSvgAsset: Assets.assetsSvgKey,
                          title: 'Change password',
                          onTap: () {
                            Get.toNamed(RouterPaths.changePassword);
                          },
                        ),
                        const AppDivider(),

                        // Biometric
                        Obx(
                          () => MenuTile(
                            leadingSvgAsset: Assets.assetsSvgScanFaceId,
                            title: 'Biometric',
                            onTap: () {},
                            trailing: controller.biometricLoading.value
                                ? const LoadingWidget()
                                : Transform.scale(
                                    scale: .7,
                                    child: Obx(
                                      () => Switch(
                                        value: controller.biometricSwitchValue.value,
                                        onChanged: (value) {
                                          controller.changeBiometric(value);
                                        },
                                        inactiveTrackColor: AppColors.lightTextFieldFillColor,
                                        inactiveThumbColor: AppColors.lightTextFieldHintColor,
                                        trackOutlineColor:
                                            WidgetStateProperty.all<Color>(AppColors.lightTextFieldHintColor),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        const AppDivider(),

                        // Dark mode
                        MenuTile(
                          leadingSvgAsset: Assets.assetsSvgHalfMoon,
                          title: 'Dark mode',
                          onTap: () {},
                          trailing: FittedBox(
                            fit: BoxFit.fill,
                            child: Transform.scale(
                              scale: .7,
                              child: Obx(
                                () => Switch(
                                  value: controller.darkModeSwitchValue.value,
                                  onChanged: (value) {
                                    controller.changeDarkMode(value);
                                  },
                                  inactiveTrackColor: AppColors.lightTextFieldFillColor,
                                  inactiveThumbColor: AppColors.lightTextFieldHintColor,
                                  trackOutlineColor: WidgetStateProperty.all<Color>(AppColors.lightTextFieldHintColor),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const AppDivider(),

                        // Dark mode
                        MenuTile(
                          leadingSvgAsset: Assets.assetsSvgDistance,
                          title: 'Distance unit',
                          onTap: () {},
                          trailing: Obx(
                            () => BasicDropdown(
                                width: 110,
                                dropdownWidth: 110,
                                bgColor: Colors.transparent,
                                items: AppList.distanceUnitList,
                                selectedValue: controller.selectedDistanceUnit.value,
                                hintText: 'Select',
                                onChanged: (value) {
                                  controller.changeDistanceUnit(value);
                                }),
                          ),
                        ).paddingOnly(bottom: 20),

                        //Logout button
                        OutlineButton(
                          onTap: () => controller.logoutOnTap(),
                          splashColor: AppColors.errorColor.withOpacity(0.2),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                color: AppColors.errorColor,
                                size: 18,
                              ),
                              ButtonText(
                                text: ' Log out',
                                textColor: AppColors.errorColor,
                              )
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            ),
          );
        });
  }
}
