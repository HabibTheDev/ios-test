import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/tiles/status_label_tile.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/empty_content_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../more/view/tiles/border_table.dart';
import '../tiles/vehicle_tile.dart';
import 'employee_info.dart';

class MaintenanceRequestWidget extends StatelessWidget {
  const MaintenanceRequestWidget({super.key});
  final bool showSchedule = true;

  @override
  Widget build(BuildContext context) {
    return 1 != 1
        ? _noDataWidget()
        : ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Details
              CardWidget(
                contentPadding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TitleText(
                                text: 'Regular servicing',
                                textSize: 16,
                              ),
                              SmallText(
                                text: 'Regular servicing',
                                fontWeight: FontWeight.w500,
                                textColor: AppColors.lightSecondaryTextColor,
                              ),
                            ],
                          ),
                        ),
                        StatusLabelTile(
                            status: 'Awaiting',
                            statusColor: AppColors.awaitingColor)
                      ],
                    ).paddingOnly(bottom: 16),
                    const CarInfoTile(
                            titleKey: 'Requested date',
                            titleValue: '12 Sep 2023')
                        .paddingOnly(bottom: 4),
                    const CarInfoTile(
                            titleKey: 'Requested time', titleValue: '12:04 PM')
                        .paddingOnly(bottom: 16),

                    // Warning note
                    if (showSchedule)
                      WarningNoteWidget(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextColor),
                            children: [
                              TextSpan(text: 'Admin '),
                              TextSpan(
                                  text: 'requested',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextSpan(text: ' for maintenance.'),
                            ],
                          ),
                        ),
                      ).paddingOnly(bottom: 16),

                    // Time & Address
                    BorderedTable(
                      rows: [
                        [
                          'Retrieve time',
                          showSchedule ? '-' : '12 Sep 2023  12:03 PM'
                        ],
                        [
                          'Retrieve address',
                          showSchedule ? '-' : '23/6 Dire Streets, Ontario, CA'
                        ],
                        [
                          'Delivery address',
                          showSchedule ? '-' : '23/6 Dire Streets, Ontario, CA'
                        ],
                      ],
                    ).paddingOnly(bottom: 16),
                    showSchedule
                        ? SolidTextButton(
                            onTap: () =>
                                Get.toNamed(RouterPaths.scheduleMaintenance),
                            buttonText: 'Schedule')
                        : Row(
                            children: [
                              Expanded(
                                child: OutlineTextButton(
                                  onTap: () {},
                                  buttonText: 'Cancel',
                                  primaryColor: AppColors.errorColor,
                                ),
                              ),
                              const WidthBox(width: 10),
                              Expanded(
                                child: OutlineTextButton(
                                  onTap: () {},
                                  buttonText: 'Edit',
                                  primaryColor: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ).paddingOnly(bottom: 16),

              // Vehicle
              const CardWidget(
                contentPadding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText(
                      text: 'Vehicle',
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.lightSecondaryTextColor,
                    ),
                    VehicleTile()
                  ],
                ),
              ).paddingOnly(bottom: 16),

              // Maintenance coordinator
              CardWidget(
                contentPadding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BodyText(
                      text: 'Maintenance coordinator',
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 20),
                    showSchedule
                        ? const EmployeeInfo()
                        : const EmptyContentWidget(
                            title: 'Not selected yet',
                            svgAsset: Assets.assetsSvgSearch)
                  ],
                ),
              )
            ],
          );
  }

  Widget _noDataWidget() => Stack(
        children: [
          const Align(
            child: EmptyContentWidget(
                title: 'Nothing to show!',
                subTitle:
                    'We don\'t have any information to display at the moment. You\'ll be notified if there are any developments',
                svgAsset: Assets.assetsSvgSearch),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: SolidTextButton(onTap: () {}, buttonText: 'Request'),
          ),
        ],
      );
}
