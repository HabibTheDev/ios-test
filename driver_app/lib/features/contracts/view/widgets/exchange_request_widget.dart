import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/tiles/status_label_tile.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/empty_content_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/normal_card.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../more/view/tiles/border_table.dart';
import '../../controller/request_maintenance_exchange_controller.dart';
import '../tiles/vehicle_tile.dart';
import 'employee_info.dart';

class ExchangeRequestWidget extends StatefulWidget {
  const ExchangeRequestWidget({super.key});

  @override
  State<ExchangeRequestWidget> createState() => _ExchangeRequestWidgetState();
}

class _ExchangeRequestWidgetState extends State<ExchangeRequestWidget> {
  final bool carOffered = true;
  bool carSelected = false;

  @override
  Widget build(BuildContext context) {
    final RequestMaintenanceExchangeController controller = Get.find();
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
                                text: 'Customer exchange',
                                textSize: 16,
                              ),
                              SmallText(
                                text: 'Delivery',
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
                    if (carOffered)
                      WarningNoteWidget(
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.lightTextColor),
                            children: [
                              TextSpan(text: 'Admin has '),
                              TextSpan(
                                  text: 'offered',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  )),
                              TextSpan(
                                  text:
                                      ' some other cars. Choose your preferred car to start exchange process.'),
                            ],
                          ),
                        ),
                      ).paddingOnly(bottom: 16),

                    // Time & Address
                    const BorderedTable(
                      rows: [
                        ['Delivery time', '12 Sep 2023  12:03 PM'],
                        ['Delivery address', '23/6 Dire Streets, Ontario, CA'],
                        ['Delivery address', '23/6 Dire Streets, Ontario, CA'],
                      ],
                    ).paddingOnly(bottom: 16),
                    carOffered
                        ? carSelected
                            ? SolidTextButton(
                                onTap: () =>
                                    Get.toNamed(RouterPaths.scheduleExchange),
                                buttonText: 'Schedule')
                            : OutlineTextButton(
                                onTap: () =>
                                    controller.cancelExchangeRequestOnTap(),
                                buttonText: 'Cancel',
                                primaryColor: AppColors.errorColor,
                              )
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

              // Offered Car
              if (carOffered)
                CardWidget(
                  contentPadding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BodyText(
                        text: 'Offered Car (02)',
                        fontWeight: FontWeight.w700,
                        textColor: AppColors.lightSecondaryTextColor,
                      ),
                      const SmallText(
                        text:
                            'We cannot proceed with your requested car. Instead take a look on these cars that we selected for you',
                        textColor: AppColors.lightSecondaryTextColor,
                      ).paddingOnly(bottom: 16),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) => NormalCard(
                          contentPadding: const EdgeInsets.all(12),
                          backgroundColor: AppColors.lightBgColor,
                          child: Column(
                            children: [
                              const VehicleTile(),
                              if (!carSelected)
                                OutlineTextButton(
                                  onTap: () {
                                    setState(() {
                                      carSelected = !carSelected;
                                    });
                                  },
                                  buttonText: 'Select car',
                                  primaryColor: AppColors.primaryColor,
                                )
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const HeightBox(height: 10),
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 16),

              // Car details
              CardWidget(
                contentPadding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BodyText(
                      text: 'Car details',
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 16),
                    const NormalCard(
                      contentPadding: EdgeInsets.all(12),
                      backgroundColor: AppColors.lightBgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyText(
                            text: 'Current',
                            fontWeight: FontWeight.w700,
                            textColor: AppColors.lightSecondaryTextColor,
                          ),
                          VehicleTile(),
                        ],
                      ),
                    ).paddingOnly(bottom: 10),
                    const NormalCard(
                      contentPadding: EdgeInsets.all(12),
                      backgroundColor: AppColors.lightBgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyText(
                            text: 'Requested',
                            fontWeight: FontWeight.w700,
                            textColor: AppColors.lightSecondaryTextColor,
                          ),
                          VehicleTile(),
                        ],
                      ),
                    )
                  ],
                ),
              ).paddingOnly(bottom: 16),

              // Valet
              CardWidget(
                contentPadding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BodyText(
                      text: 'Valet',
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 20),
                    carOffered
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
