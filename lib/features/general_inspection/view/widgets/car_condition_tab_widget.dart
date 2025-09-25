import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inspection/model/inspection_report_model.dart';
import '../../../inspection/view/tiles/overall_info_tile.dart';
import '../../controller/general_inspection_report_controller.dart';
import 'package:fl_chart/fl_chart.dart';

import 'car_condition_table.dart';

class CarConditionTabWidget extends StatelessWidget {
  const CarConditionTabWidget({super.key, required this.locale, required this.controller});
  final AppLocalizations? locale;
  final GeneralInspectionReportController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 24,
                      sections: [
                        PieChartSectionData(
                          value: 30,
                          color: AppColors.primaryColor,
                          title: '30',
                          radius: 24,
                          titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        PieChartSectionData(
                          value: 18,
                          color: AppColors.warningColor,
                          title: '18',
                          radius: 24,
                          titleStyle: const TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                ),
                HeightBox(height: 6),
                SmallText(text: 'Components'),
              ],
            ),
            const WidthBox(width: 10),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _conditionWidget(title: 'Total components', value: '63'),
                  const AppDivider(height: 16),
                  _conditionWidget(
                    leadingIcon: const Icon(Icons.check_circle, color: AppColors.primaryColor, size: 18),
                    title: 'Good condition',
                    value: '30',
                  ),
                  const AppDivider(height: 16),
                  _conditionWidget(
                    leadingIcon: const Icon(Icons.check_circle, color: AppColors.warningColor, size: 18),
                    title: 'Requires servicing',
                    value: '18',
                  ),
                ],
              ),
            ),
          ],
        ).paddingOnly(bottom: 32),

        // Car condition table
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => const HeightBox(height: 10),
          itemBuilder: (context, index) => CarConditionTable(
            carSectionReport: CarSectionReport(
              sectionName: 'Left Side',
              svgImagePath: Assets.assetsSvgCarBody,
              partsCount: 10,
              healthPercent: 5,
              damageList: [
                DamageList(
                  part: 'Front Bumper',
                  partAreaList: [
                    PartAreaList(
                      part: 'Front Bumper',
                      partName: 'Front Bumper',
                      count: 10,
                      severity: 'Low',
                      recommendation: 'Repair',
                      image: 'https://via.placeholder.com/150',
                      images: [],
                      isCurrent: true,
                      inspectionReportId: '1',
                      requestMaintanainanceId: '2',
                      isNew: true,
                      checkValue: false,
                    ),
                  ],
                ),
              ],
            ),
            inspectionTypeEnum: InspectionTypeEnum.generalInspection,
            carId: 1,
            reportOverviewId: '1',
          ),
        ),
      ],
    );
  }

  Widget _conditionWidget({Widget? leadingIcon, required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (leadingIcon != null) leadingIcon.paddingOnly(right: 4),
        Expanded(
          child: OverallInfoTile(title: title, value: value),
        ),
      ],
    );
  }
}
