import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/expandable_widget.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inbox/model/message_model.dart';
import '../../../inspection/model/inspection_report_model.dart';

class CarConditionTable extends StatelessWidget {
  final CarSectionReport carSectionReport;
  final InspectionTypeEnum? inspectionTypeEnum;
  final int? carId;
  final String? reportOverviewId;

  const CarConditionTable({
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
                  columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(3)},
                  children: [
                    // Table header
                    TableRow(
                      decoration: BoxDecoration(color: AppColors.primaryColor.withAlpha(18)),
                      children: [
                        SmallText(
                          text: 'Components',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ).paddingAll(10),
                        SmallText(
                          text: 'Condition status',
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
                                            final area = damage.partAreaList![index];
                                            return Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons.check_circle,
                                                      color: AppColors.primaryColor,
                                                      size: 18,
                                                    ),
                                                    WidthBox(width: 4),
                                                    Expanded(child: SmallText(text: 'Good')),
                                                  ],
                                                ),
                                                if (area.image != null)
                                                  InkWell(
                                                    onTap: () {
                                                      if (area.images != null && area.images!.isNotEmpty) {
                                                        final List<Attachment> attachments = area.images!
                                                            .map((imageUrl) => Attachment(url: imageUrl))
                                                            .toList();
                                                        Get.toNamed(
                                                          RouterPaths.filePreview,
                                                          arguments: {ArgumentsKey.attachments: attachments},
                                                        );
                                                      }
                                                    },
                                                    child: NetworkImageWidget(
                                                      imageUrl: area.image,
                                                      width: 20,
                                                      height: 20,
                                                      borderRadius: 4,
                                                    ),
                                                  ).paddingOnly(top: 4),
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
