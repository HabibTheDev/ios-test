import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/progress_bar_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/damage_model.dart';

class DamageReportTable extends StatelessWidget {
  final List<DamageModel> damageList;
  final String carPartImageUrl;
  final String carPartName;
  final String carPartCount;
  final double percentOfDamage;

  const DamageReportTable(
      {super.key,
      required this.damageList,
      required this.carPartImageUrl,
      required this.carPartName,
      required this.carPartCount,
      required this.percentOfDamage});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.07),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              topRight: Radius.circular(4),
            ),
            border: const Border(
              left: BorderSide(color: AppColors.lightCurrentUserChatColor, width: 1),
              top: BorderSide(color: AppColors.lightCurrentUserChatColor, width: 1),
              right: BorderSide(color: AppColors.lightCurrentUserChatColor, width: 1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkImageWidget(
                imageUrl: carPartImageUrl,
                width: 20,
                height: 20,
                borderRadius: 4,
              ).paddingOnly(bottom: 6),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        BodyText(
                          text: carPartName,
                          fontWeight: FontWeight.w700,
                        ),
                        BodyText(
                          text: ' ($carPartCount parts)',
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SmallText(
                    text: '${percentOfDamage * 100}%',
                    textAlign: TextAlign.end,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.lightSecondaryTextColor,
                  ))
                ],
              ).paddingOnly(bottom: 4),
              // Progress Bar
              ProgressBarWidget(
                progressValue: percentOfDamage,
                color: AppColors.primaryColor,
                height: 7,
                trackColor: AppColors.lightCardColor,
              ),
            ],
          ),
        ),
        Table(
          border: TableBorder.all(color: AppColors.lightCurrentUserChatColor, width: 1),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            // Header Row
            TableRow(
              decoration: BoxDecoration(color: AppColors.primaryColor.withOpacity(0.07)),
              children: [
                const SmallText(
                  text: 'Vehicle Parts',
                  textColor: AppColors.lightSecondaryTextColor,
                  fontWeight: FontWeight.w600,
                ).paddingAll(8),
                const SmallText(
                  text: 'Damages',
                  textColor: AppColors.lightSecondaryTextColor,
                  fontWeight: FontWeight.w600,
                ).paddingAll(8),
              ],
            ),
            // Data Rows
            ...damageList.map((damage) {
              return TableRow(
                children: [
                  // Area of Damage column
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BodyText(text: damage.areaOfDamage),
                  ),
                  // Details column with dividers between each subDetail
                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: damage.damageDetails!.length,
                      separatorBuilder: (context, index) => const AppDivider(thickness: 1, height: 0),
                      itemBuilder: (context, index) {
                        final damageDetail = damage.damageDetails![index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (damageDetail.title != null)
                              SmallText(
                                text: damageDetail.title!,
                                textColor: AppColors.lightSecondaryTextColor,
                                fontWeight: FontWeight.w600,
                              ).paddingOnly(bottom: 8),

                            // Adding dividers between each subDetail
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: damageDetail.damageSubDetails!.length,
                              separatorBuilder: (context, index) => const HeightBox(height: 8),
                              itemBuilder: (context, index) {
                                final subDetail = damageDetail.damageSubDetails![index];
                                return Row(
                                  children: [
                                    if (subDetail.imageUrl != null)
                                      NetworkImageWidget(
                                        imageUrl: subDetail.imageUrl!,
                                        width: 20,
                                        height: 20,
                                        borderRadius: 4,
                                      ).paddingOnly(right: 8),
                                    Expanded(
                                        child: Row(
                                      children: [
                                        SmallText(text: subDetail.details ?? ""),
                                        if (subDetail.status != null)
                                          SmallText(
                                            text: "\u2191 ${subDetail.status}",
                                            textColor: Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ).paddingOnly(left: 8),
                                      ],
                                    )),
                                  ],
                                );
                              },
                            ),
                          ],
                        ).paddingAll(8);
                      }),
                ],
              );
            }),
          ],
        ),
      ],
    );
  }
}
