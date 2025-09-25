import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/outline_button.dart';
import '../../../../shared/widgets/solid_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../controller/start_driving_controller.dart';
import 'car_fuel_info_widget.dart';

class DrivingControllerWidget extends StatelessWidget {
  const DrivingControllerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final StartDrivingController controller = Get.find();
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const HeightBox(height: 12),
              Stack(
                alignment: Alignment.center,
                children: [
                  // Car Image
                  SvgPicture.asset(
                    Assets.assetsSvgDrivingCar,
                    height: 330,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                  ),

                  // Locked / Unlocked Status
                  // Obx(
                  //   () => Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Icon(
                  //         controller.isCarLocked.value ? Icons.lock : Icons.lock_open,
                  //         color: controller.lockedUnlockedColor(),
                  //         size: 24,
                  //       ),
                  //       SmallText(
                  //         text: controller.isCarLocked.value ? 'Locked' : 'Unlocked',
                  //         textColor: controller.lockedUnlockedColor(),
                  //       )
                  //     ],
                  //   ),
                  // ).paddingOnly(top: 36),

                  // Top tire psi
                  Positioned(
                    top: 60,
                    right: 0,
                    child: _frontTirePsiTile(psi: '31.44').paddingOnly(right: 20),
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    child: _frontTirePsiTile(psi: '31.44', crossAxisAlignment: CrossAxisAlignment.end)
                        .paddingOnly(left: 20),
                  ),

                  // Bottom tire psi
                  Positioned(
                    bottom: 60,
                    right: 0,
                    child: _backTirePsiTile(psi: '31.44').paddingOnly(right: 20),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 0,
                    child: _backTirePsiTile(psi: '31.44', crossAxisAlignment: CrossAxisAlignment.end)
                        .paddingOnly(left: 20),
                  ),
                ],
              ).paddingOnly(bottom: 32),

              // Fuel info
              const CarFuelInfoWidget(
                leadingIcon: Icons.local_gas_station,
                title: 'Fuel tank level',
                trailingSubtitle: '60% (20 G) - 158.5 M',
                progressValue: 0.6,
              ).paddingOnly(bottom: 8),

              const CarFuelInfoWidget(
                leadingIcon: Icons.opacity,
                title: 'Engine oil life',
                trailingSubtitle: '30%',
                progressValue: 0.3,
              ),

              // Battery info
              // const FuelBatteryInfoWidget(
              //   leadingIcon: Icons.battery_5_bar,
              //   title: 'Battery level',
              //   trailingSubtitle: '30% - 120.2 M',
              //   progressValue: 0.3,
              // ).paddingOnly(bottom: 8),
              // const FuelBatteryInfoWidget(
              //   leadingIcon: Icons.battery_charging_full,
              //   title: 'Battery level',
              //   trailingSubtitle: '30% - 120.2 M',
              //   progressValue: 0.3,
              //   subtitle: 'Plugged in (Charging)',
              // ).paddingOnly(bottom: 8),
              // const FuelBatteryInfoWidget(
              //   leadingIcon: Icons.battery_std_rounded,
              //   title: 'Battery capacity',
              //   subtitle: '48 kWh',
              // ),
            ],
          ),
        ),
        Obx(
          () => Row(
            children: [
              Expanded(
                child: OutlineButton(
                  primaryColor: AppColors.errorColor,
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  minimumSize: const Size(double.infinity, 50),
                  onTap: () {
                    controller.lockedUnlockedToggle();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock,
                        color: AppColors.errorColor,
                        size: 20,
                      ),
                      ButtonText(
                        text: ' Unlock',
                        textColor: AppColors.errorColor,
                      )
                    ],
                  ),
                ),
              ),
              const WidthBox(width: 12),
              Expanded(
                child: SolidButton(
                  backgroundColor: controller.lockedUnlockedColor(),
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  height: 50,
                  onTap: () {
                    controller.lockedUnlockedToggle();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock,
                        color: AppColors.buttonTextColor,
                        size: 20,
                      ),
                      ButtonText(text: ' Lock')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 16)
      ],
    );
  }

  Widget _frontTirePsiTile({required String psi, CrossAxisAlignment? crossAxisAlignment}) => Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SmallText(text: '$psi psi').paddingOnly(bottom: 6),
          const SizedBox(
            width: 36,
            child: AppDivider(thickness: 2),
          )
        ],
      );

  Widget _backTirePsiTile({required String psi, CrossAxisAlignment? crossAxisAlignment}) => Column(
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 36,
            child: AppDivider(thickness: 2),
          ).paddingOnly(bottom: 6),
          SmallText(text: '$psi psi'),
        ],
      );
}
