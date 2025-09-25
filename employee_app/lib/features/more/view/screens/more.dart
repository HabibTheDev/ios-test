part of 'widget_imports.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileController(profileRepo: ServiceLocator.get<ProfileRepo>()));
    final locale = AppLocalizations.of(context);
    return GetBuilder<MoreController>(
      init: MoreController(
        authRepo: ServiceLocator.get<AuthRepo>(),
        localStorageRepo: ServiceLocator.get<LocalStorageRepo>(),
      ),
      autoRemove: false,
      builder: (controller) {
        return Column(
          children: [
            Expanded(
              child: ListRefreshIndicator(
                onRefresh: () async => await controller.onInit(),
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    //title
                    HeaderWidget(title: '${locale?.more}').paddingOnly(bottom: 20),

                    //User Card
                    Obx(
                      () => controller.isLoading.value
                          ? const CenterLoadingWidget()
                          : CardWidget(
                              contentPadding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ProfilePhotoWidget(
                                        imageSize: 48,
                                        imageUrl: profileController.employeeModel.value?.photo,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                TitleText(
                                                  text:
                                                      profileController.employeeModel.value?.fullName ??
                                                      '${locale?.notAvailable}',
                                                ),
                                                Icon(
                                                  Icons.verified,
                                                  color: profileController.employeeModel.value?.verified == true
                                                      ? AppColors.lightProgressColor
                                                      : AppColors.lightSecondaryTextColor,
                                                  size: 14,
                                                ).paddingOnly(left: 8),
                                                SmallText(
                                                  text: profileController.employeeModel.value?.verified == true
                                                      ? '${locale?.verified.toLowerCase()}'
                                                      : '${locale?.notVerified.toLowerCase()}',
                                                  textColor: profileController.employeeModel.value?.verified == true
                                                      ? AppColors.lightProgressColor
                                                      : AppColors.lightSecondaryTextColor,
                                                ).paddingOnly(left: 4),
                                              ],
                                            ),
                                            SmallText(
                                              text:
                                                  profileController.employeeModel.value?.email ??
                                                  '${locale?.notAvailable}',
                                              textColor: AppColors.lightSecondaryTextColor,
                                            ),
                                          ],
                                        ).paddingOnly(left: 8),
                                      ),
                                    ],
                                  ).paddingOnly(bottom: 20),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(RouterPaths.myProfile);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        BodyText(
                                          text: '${locale?.viewProfile}',
                                          textColor: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ).paddingOnly(right: 4),
                                        const Icon(Icons.arrow_forward, color: AppColors.primaryColor, size: 16),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ).paddingOnly(bottom: 10),

                    // Menu Widget
                    CardWidget(
                      contentPadding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          MenuTile(
                            leadingSvgAsset: Assets.assetsSvgKey,
                            title: '${locale?.changePassword}',
                            onTap: () {
                              Get.toNamed(RouterPaths.changePassword);
                            },
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: AppColors.lightSecondaryTextColor,
                              size: 12,
                            ),
                          ),
                          const AppDivider(),
                          Obx(
                            () => MenuTile(
                              leadingSvgAsset: Assets.assetsSvgScanFaceId,
                              title: '${locale?.biometric}',
                              onTap: () {},
                              trailing: controller.biometricLoading.value
                                  ? const LoadingWidget()
                                  : Transform.scale(
                                      scale: .7,
                                      child: Obx(
                                        () => Switch(
                                          value: controller.biometricSwitchValue.value,
                                          onChanged: (value) => controller.changeBiometric(value),
                                          inactiveTrackColor: AppColors.lightTextFieldFillColor,
                                          inactiveThumbColor: AppColors.lightTextFieldHintColor,
                                          trackOutlineColor: WidgetStateProperty.all<Color>(
                                            AppColors.lightTextFieldHintColor,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ).paddingOnly(bottom: 20),
                          const AppDivider(),
                          // MenuTile(
                          //   leadingSvgAsset: Assets.assetsSvgHalfMoon,
                          //   title: Get.locale == const Locale('bn') ? 'English' : 'Bengali',
                          //   onTap: () {},
                          //   trailing: Transform.scale(
                          //     scale: .7,
                          //     child: Obx(
                          //       () => Switch(
                          //         value: Get.locale == Locale(LocaleEnum.bengali.value) ? true : false,
                          //         onChanged: (value) async {
                          //           if (Get.locale == Locale(LocaleEnum.bengali.value)) {
                          //             Get.updateLocale(Locale(LocaleEnum.english.value));
                          //             ServiceLocator.get<LocalStorageRepo>().setLocale(LocaleEnum.english.value);
                          //           } else {
                          //             Get.updateLocale(Locale(LocaleEnum.bengali.value));
                          //             ServiceLocator.get<LocalStorageRepo>().setLocale(LocaleEnum.bengali.value);
                          //           }
                          //         },
                          //         inactiveTrackColor: AppColors.lightTextFieldFillColor,
                          //         inactiveThumbColor: AppColors.lightTextFieldHintColor,
                          //         trackOutlineColor:
                          //             WidgetStateProperty.all<Color>(AppColors.lightTextFieldHintColor),
                          //       ),
                          //     ),
                          //   ),
                          // ).paddingOnly(bottom: 20),
                          OutlineButton(
                            onTap: () => controller.logoutOnTap(locale),
                            splashColor: AppColors.errorColor.withAlpha(51),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.logout, color: AppColors.errorColor, size: 18),
                                ButtonText(text: ' ${locale?.logOut}', textColor: AppColors.errorColor),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ).paddingAll(16),
              ),
            ),
            Obx(
              () => SmallText(
                text: '${locale?.version} ${controller.packageInfo.value?.version ?? ''}',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.w600,
              ),
            ).paddingOnly(bottom: 20, left: 16, right: 16),
          ],
        );
      },
    );
  }
}
