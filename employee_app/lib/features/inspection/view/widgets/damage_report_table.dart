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
import '../../model/inspection_report_model.dart';

class DamageReportTable extends StatelessWidget {
  final CarSectionReport carSectionReport;
  final InspectionTypeEnum? inspectionTypeEnum;
  final int? carId;
  final String? reportOverviewId;
  final bool isEdit;
  final Function(dynamic result)? editSuccessCallback;

  const DamageReportTable({
    super.key,
    required this.carSectionReport,
    required this.inspectionTypeEnum,
    required this.carId,
    required this.reportOverviewId,
    this.isEdit = false,
    this.editSuccessCallback,
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
                  // Part condition
                  getPartConditionWidget(carSectionReport.healthPercent, locale),
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
                          text: '${locale?.vehicleParts}',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w600,
                        ).paddingAll(10),
                        SmallText(
                          text: '${locale?.damages}',
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
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SmallText(text: '-').paddingAll(10),
                                      if (isEdit)
                                        EditIconWidget(
                                          onTap: () async {
                                            final result = await Get.toNamed(
                                              RouterPaths.damageCustomization,
                                              arguments: {
                                                ArgumentsKey.part: damage.part,
                                                ArgumentsKey.partName: damage.partName,
                                                ArgumentsKey.carID: carId,
                                                ArgumentsKey.reportOverviewId: reportOverviewId,
                                                ArgumentsKey.partAreaList: <PartAreaList>[],
                                              },
                                            );
                                            if (editSuccessCallback != null) {
                                              editSuccessCallback!(result);
                                            }
                                          },
                                        ).paddingOnly(right: 10),
                                    ],
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(10),
                                    color:
                                        inspectionTypeEnum == InspectionTypeEnum.returnInspection &&
                                            isNew(damage.partAreaList!)
                                        ? AppColors.newDamageBlockColor
                                        : null,
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
                                            return Row(
                                              children: [
                                                if (area.image != null)
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        RouterPaths.filePreview,
                                                        arguments: {
                                                          ArgumentsKey.attachments: [Attachment(url: area.image)],
                                                        },
                                                      );
                                                    },
                                                    child: NetworkImageWidget(
                                                      imageUrl: area.image,
                                                      width: 20,
                                                      height: 20,
                                                      borderRadius: 4,
                                                    ).paddingOnly(right: 8),
                                                  ),
                                                Expanded(
                                                  child: Row(
                                                    children: [
                                                      SmallText(
                                                        text:
                                                            '${area.count ?? ''} ${area.type?.replaceAll('-', ' ').replaceAll('_', ' ')}',
                                                      ),
                                                      if (inspectionTypeEnum == InspectionTypeEnum.returnInspection &&
                                                          area.isNew == true)
                                                        SmallText(
                                                          text: "\u2191 ${locale?.newStr.toLowerCase()}",
                                                          textColor: Colors.red,
                                                          fontWeight: FontWeight.w600,
                                                        ).paddingOnly(left: 10),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        if (isEdit)
                                          EditIconWidget(
                                            onTap: () async {
                                              final result = await Get.toNamed(
                                                RouterPaths.damageCustomization,
                                                arguments: {
                                                  ArgumentsKey.part: damage.part,
                                                  ArgumentsKey.partName: damage.partName,
                                                  ArgumentsKey.carID: carId,
                                                  ArgumentsKey.reportOverviewId: reportOverviewId,
                                                  ArgumentsKey.partAreaList: damage.partAreaList,
                                                },
                                              );
                                              if (editSuccessCallback != null) {
                                                editSuccessCallback!(result);
                                              }
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

  SmallText getPartConditionWidget(int? health, AppLocalizations? locale) {
    if (health == null) {
      return SmallText(text: '${locale?.notAvailable}', fontWeight: FontWeight.w500, textColor: AppColors.emojiColor);
    } else if (health < 40) {
      return SmallText(text: '${locale?.poor}', fontWeight: FontWeight.w500, textColor: AppColors.errorColor);
    } else if (health >= 40 && health < 70) {
      return SmallText(text: '${locale?.fair}', fontWeight: FontWeight.w500, textColor: AppColors.awaitingColor);
    } else if (health >= 70 && health < 90) {
      return SmallText(
        text: '${locale?.good}',
        fontWeight: FontWeight.w500,
        textColor: AppColors.lightDialogGreenColor,
      );
    } else if (health >= 90 && health <= 100) {
      return SmallText(
        text: '${locale?.excellent}',
        fontWeight: FontWeight.w500,
        textColor: AppColors.lightDialogGreenColor,
      );
    } else {
      return SmallText(text: '${locale?.notAvailable}', fontWeight: FontWeight.w500, textColor: AppColors.emojiColor);
    }
  }

  bool isNew(List<PartAreaList> partAreaList) {
    for (var e in partAreaList) {
      if (e.isNew == true) return true;
    }
    return false;
  }
}

class EditIconWidget extends StatelessWidget {
  const EditIconWidget({super.key, required this.onTap});
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: BorderCardWidget(
        borderColor: AppColors.primaryColor,
        contentPadding: EdgeInsets.all(2),
        child: Icon(Icons.edit, size: 16),
      ),
    );
  }
}
