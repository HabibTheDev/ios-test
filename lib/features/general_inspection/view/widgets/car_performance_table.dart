import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/expandable_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inspection/model/inspection_report_model.dart';

class CarPerformanceTable extends StatelessWidget {
  final CarSectionReport carSectionReport;
  final InspectionTypeEnum? inspectionTypeEnum;
  final int? carId;
  final String? reportOverviewId;

  const CarPerformanceTable({
    super.key,
    required this.carSectionReport,
    required this.inspectionTypeEnum,
    required this.carId,
    required this.reportOverviewId,
  });

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return carSectionReport.partsCount != null && carSectionReport.partsCount != 0
        ? BorderCardWidget(
            borderColor: AppColors.lightTextFieldFillColor,
            child: ExpandableWidget(
              leading: SvgPicture.asset(
                carSectionReport.svgImagePath!,
                width: 30,
                clipBehavior: Clip.none,
                fit: BoxFit.fitWidth,
              ).paddingOnly(left: 10),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Part name
                  BodyText(
                    text: carSectionReport.sectionName ?? '${locale?.notAvailable}',
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              trailing: const RotatedBox(
                quarterTurns: -1,
                child: Icon(Icons.subdirectory_arrow_left_rounded, color: AppColors.lightSecondaryTextColor, size: 18),
              ).paddingOnly(right: 10),
              children: [
                Table(
                  border: TableBorder.all(color: AppColors.lightCurrentUserChatColor, width: 1),
                  columnWidths: const {0: FlexColumnWidth(1), 1: FlexColumnWidth(4)},
                  children: [
                    // Table header
                    TableRow(
                      decoration: BoxDecoration(color: AppColors.primaryColor.withAlpha(18)),
                      children: [
                        SmallText(
                          text: 'SL',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ).paddingAll(10),
                        SmallText(
                          text: 'Enquiry-Questions',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ).paddingAll(10),
                      ],
                    ),
                    // Table data rows
                    if (carSectionReport.damageList != null)
                      ...carSectionReport.damageList!.map((damage) {
                        return TableRow(
                          children: [
                            // Area of Damage column
                            BodyText(text: damage.partName ?? '${locale?.notAvailable}').paddingAll(10),

                            // Damages of area list
                            damage.partAreaList!.isEmpty
                                ? const SmallText(text: '-').paddingAll(10)
                                : Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Stack(
                                      alignment: Alignment.topRight,
                                      children: [
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: damage.partAreaList!.length,
                                          separatorBuilder: (context, index) => const HeightBox(height: 8),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SmallText(
                                                  text: 'Did it start normally?',
                                                  textColor: AppColors.lightSecondaryTextColor,
                                                ),
                                                SmallText(text: 'Yes', fontWeight: FontWeight.bold),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                      }),
                  ],
                ),
              ],
            ),
          )
        : const SizedBox.shrink();
  }
}
