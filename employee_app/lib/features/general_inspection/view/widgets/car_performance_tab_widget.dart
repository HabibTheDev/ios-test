import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inspection/model/inspection_report_model.dart';
import 'car_performance_table.dart';

class CarPerformanceTabWidget extends StatelessWidget {
  const CarPerformanceTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Performance progress bars
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            children: [
              // While parked section
              _buildPerformanceProgressBar(
                title: 'While parked',
                percentage: 92,
                percentageColor: AppColors.inProgressColor,
                iconPath: Assets.assetsSvgGeneralCarStationary,
                context: context,
              ),
              const HeightBox(height: 16),
              // While driving section
              _buildPerformanceProgressBar(
                title: 'While driving',
                percentage: 68,
                percentageColor: Colors.orange,
                iconPath: Assets.assetsSvgGeneralCarRunning,
                context: context,
              ),
            ],
          ),
        ),

        ButtonText(
          text: 'While car is stationary',
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 10),

        // Car stationary table
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => const HeightBox(height: 10),
          itemBuilder: (context, index) => CarPerformanceTable(
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

  Widget _buildPerformanceProgressBar({
    required String title,
    required double percentage,
    required Color percentageColor,
    required String iconPath,
    required BuildContext context,
  }) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.primaryColor, width: 0.4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage / 100,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [AppColors.primaryColor, AppColors.disablePrimaryColor],
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Positioned(
                left: 10,
                child: BodyText(text: title, textColor: AppColors.buttonTextColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const WidthBox(width: 8),
        TitleText(text: '${percentage.toInt()}%', textColor: percentageColor, fontWeight: FontWeight.w600),
        const WidthBox(width: 8),
        SizedBox(
          width: 40,
          child: SvgPicture.asset(iconPath, width: 40, fit: BoxFit.fitWidth, clipBehavior: Clip.none),
        ),
      ],
    );
  }
}
