import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../model/bar_chart_data_model.dart';
import 'car_fuel_info_widget.dart';
import 'vertical_bar_chart_widget.dart';

class DrivingContractWidget extends StatelessWidget {
  const DrivingContractWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBgColor,
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Car details
                CardWidget(
                  contentPadding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      // Car name & Brand
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.directions_car,
                              color: AppColors.primaryColor,
                              size: 24,
                            ),
                          ),
                          Expanded(
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BodyText(
                                  text: 'Luxury fleet',
                                  fontWeight: FontWeight.w700,
                                ),
                                SmallText(
                                  text: '#D345635',
                                  textColor: AppColors.lightSecondaryTextColor,
                                  textSize: 10,
                                ),
                              ],
                            ).paddingOnly(left: 8),
                          )
                        ],
                      ).paddingOnly(bottom: 10),

                      const CarInfoTile(
                              titleKey: 'Started at', titleValue: '11 Mar 2024')
                          .paddingOnly(bottom: 20),

                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.5,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4),
                        children: [
                          _gridTile(title: '\$1,100', subTitle: 'Next billing'),
                          _gridTile(title: '\$21,100', subTitle: 'Total paid'),
                          _gridTile(title: '03', subTitle: 'Total exchanges'),
                          _gridTile(title: '10', subTitle: 'Total maintenance'),
                          _gridTile(title: '01', subTitle: 'Total collisions'),
                          _gridTile(title: '02', subTitle: 'Failed payments'),
                        ],
                      ),

                      CarFuelInfoWidget(
                        title: 'Total Drivers',
                        trailingSubtitle: '3/5',
                        progressValue: 0.6,
                        contentPadding: EdgeInsets.zero,
                        progressColor: AppColors.primaryColor.withOpacity(0.5),
                        backgroundColor: AppColors.lightCardColor,
                        trackColor: AppColors.lightCardProgressTrackColor,
                      ).paddingOnly(bottom: 20),

                      const CarFuelInfoWidget(
                        title: 'Total Driven',
                        trailingSubtitle: '30% (58.1 M) / 200 M',
                        progressValue: 0.3,
                        contentPadding: EdgeInsets.zero,
                        progressColor: AppColors.primaryColor,
                        backgroundColor: AppColors.lightCardColor,
                        trackColor: AppColors.lightCardProgressTrackColor,
                      ).paddingOnly(bottom: 16),

                      const CarInfoTile(
                              titleKey: 'Extra mileage', titleValue: '0 miles')
                          .paddingOnly(bottom: 8),

                      TextButton(
                          onPressed: () =>
                              Get.toNamed(RouterPaths.contractDetails),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ButtonText(
                                text: 'View details ',
                                textColor: AppColors.primaryColor,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                size: 16,
                                color: AppColors.primaryColor,
                              )
                            ],
                          )),
                    ],
                  ),
                ).paddingOnly(bottom: 20),

                VerticalBarChartWidget(
                  data: [
                    BarChartDataModel(month: 'January', value: 50),
                    BarChartDataModel(month: 'February', value: 167),
                    BarChartDataModel(month: 'March', value: 200),
                    BarChartDataModel(month: 'April', value: 123),
                    BarChartDataModel(month: 'May', value: 45),
                    BarChartDataModel(month: 'June', value: 150),
                    BarChartDataModel(month: 'July', value: 56),
                    BarChartDataModel(month: 'August', value: 47),
                    BarChartDataModel(month: 'September', value: 200),
                    BarChartDataModel(month: 'October', value: 0),
                    BarChartDataModel(month: 'November', value: 0),
                    BarChartDataModel(month: 'December', value: 0),
                  ],
                  mileage: '1032',
                  subtitle: 'Total driven',
                  year: '2024',
                ).paddingOnly(bottom: 20),

                VerticalBarChartWidget(
                  data: [
                    BarChartDataModel(month: 'January', value: 50),
                    BarChartDataModel(month: 'February', value: 167),
                    BarChartDataModel(month: 'March', value: 200),
                    BarChartDataModel(month: 'April', value: 123),
                    BarChartDataModel(month: 'May', value: 45),
                    BarChartDataModel(month: 'June', value: 150),
                    BarChartDataModel(month: 'July', value: 56),
                    BarChartDataModel(month: 'August', value: 47),
                    BarChartDataModel(month: 'September', value: 200),
                    BarChartDataModel(month: 'October', value: 0),
                    BarChartDataModel(month: 'November', value: 0),
                    BarChartDataModel(month: 'December', value: 0),
                  ],
                  mileage: '132',
                  subtitle: 'Total extra mileage',
                  year: '2024',
                ).paddingOnly(bottom: 20),
              ],
            ),
          ),

          // Buttons
          Row(
            children: [
              Expanded(
                  child: OutlineTextButton(
                onTap: () => Get.toNamed(
                  RouterPaths.requestMaintenanceExchange,
                  arguments: {
                    ArgumentsKey.returnScreen: RouterPaths.startDriving
                  },
                ),
                buttonText: 'Requests',
                primaryColor: AppColors.primaryColor,
              )),
              const WidthBox(width: 10),
              Expanded(
                child: SolidButton(
                    onTap: () =>
                        Get.toNamed(RouterPaths.upgradePlan, arguments: {
                          ArgumentsKey.returnScreen: RouterPaths.startDriving
                        }),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonText(text: 'Upgrade plan '),
                        Icon(
                          Icons.stars,
                          color: AppColors.buttonTextColor,
                          size: 18,
                        ),
                      ],
                    )),
              )
            ],
          ).paddingSymmetric(horizontal: 16)
        ],
      ),
    );
  }

  Widget _gridTile({
    required String title,
    required String subTitle,
  }) =>
      BorderCardWidget(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: title,
                maxLine: 1,
                fontWeight: FontWeight.w700,
              ),
              ExtraSmallText(
                text: subTitle,
                maxLines: 1,
                fontWeight: FontWeight.w500,
                textColor: AppColors.lightSecondaryTextColor,
              ),
            ],
          ));
}
