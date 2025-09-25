import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/exchange_history_model.dart';
import '../tiles/maintenance_history_tile.dart';
import 'exchange_history_stepper.dart';

class VehicleContractDetails extends StatelessWidget {
  const VehicleContractDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Contract overview
        const HeaderWidget(title: 'Vehicle details').paddingOnly(bottom: 16),
        CardWidget(
          child: Stack(
            children: [
              SizedBox(
                height: 380,
                child: Column(
                  children: [
                    const BasicCarDetailsWidget()
                        .paddingOnly(top: 44, bottom: 16),
                    const CarInfoTile(
                            leading: Icon(
                              Icons.speed,
                              color: AppColors.primaryColor,
                              size: 18,
                            ),
                            titleKey: 'Mileage',
                            titleValue: '532M')
                        .paddingOnly(bottom: 4),
                    const CarInfoTile(
                            leading: Icon(
                              Icons.car_crash,
                              color: AppColors.primaryColor,
                              size: 18,
                            ),
                            titleKey: 'Total ride time',
                            titleValue: '15d')
                        .paddingOnly(bottom: 16),
                    const Row(
                      children: [
                        Expanded(
                            child: CarInfoTile(
                                titleKey: 'License', titleValue: 'XYA 543')),
                        Expanded(
                            child: CarInfoTile(
                                titleKey: 'Color', titleValue: 'Night Blue')),
                      ],
                    ).paddingOnly(bottom: 10),
                    TextButton(
                      onPressed: () => Get.toNamed(RouterPaths.allInspection),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonText(
                            text: 'View inspection ',
                            textColor: AppColors.primaryColor,
                          ),
                          Icon(Icons.arrow_forward_outlined, size: 18),
                        ],
                      ),
                    )
                  ],
                ).paddingAll(16),
              ),
              // Label
              Positioned(
                left: -3,
                top: 20,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: const BoxDecoration(
                      color: AppColors.contractColor,
                      borderRadius: BorderRadius.all(Radius.circular(2))),
                  child: const BodyText(
                    text: 'Current vehicle',
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.lightCardColor,
                  ),
                ),
              )
            ],
          ),
        ).paddingOnly(bottom: 12),

        // Exchange history
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  const Expanded(
                    child: BodyText(
                      text: 'Exchange history',
                      textColor: AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(RouterPaths.requestHistory),
                    child: const BodyText(
                      text: 'View all',
                      textColor: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 20),
              ExchangeHistoryStepper(steps: ExchangeHistoryModel.list)
            ],
          ),
        ).paddingOnly(bottom: 12),

        // Maintenance history
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Header
              Row(
                children: [
                  const Expanded(
                    child: BodyText(
                      text: 'Maintenance history',
                      textColor: AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  InkWell(
                    onTap: () => Get.toNamed(RouterPaths.requestHistory),
                    child: const BodyText(
                      text: 'View all',
                      textColor: AppColors.primaryColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ).paddingOnly(bottom: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) =>
                    const HeightBox(height: 10),
                itemBuilder: (context, index) => const MaintenanceHistoryTile(),
              )
            ],
          ),
        )
      ],
    );
  }
}
