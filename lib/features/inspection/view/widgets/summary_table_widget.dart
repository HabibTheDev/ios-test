import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';

class SummaryTableWidget extends StatelessWidget {
  final String? headerTitle;
  final String? headerSubTitle;
  final String? headerLeading;
  final Map<String, List<Widget>> tableRow;
  final double borderRadius;
  final bool applyBg;

  const SummaryTableWidget(
      {super.key,
      this.headerTitle,
      this.headerSubTitle,
      this.headerLeading,
      required this.tableRow,
      this.borderRadius = 0,
      this.applyBg = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header Section
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.lightCardProgressTrackColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Leading widget
              if (headerLeading != null)
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all(color: AppColors.lightSecondaryTextColor, width: 1.5)),
                  child: BodyText(
                    text: headerLeading!,
                    textColor: AppColors.lightSecondaryTextColor,
                    fontWeight: FontWeight.w700,
                  ),
                ).paddingOnly(right: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  if (headerTitle != null) BodyText(text: headerTitle!, fontWeight: FontWeight.w700),
                  // Sub-title
                  if (headerSubTitle != null)
                    SmallText(
                      text: headerSubTitle!,
                      textColor: AppColors.lightSecondaryTextColor,
                    ),
                ],
              ).paddingOnly(bottom: 4),
            ],
          ),
        ),

        Container(
          decoration: applyBg
              ? BoxDecoration(
                  color: AppColors.lightCardProgressTrackColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius),
                  ),
                )
              : null,
          padding: applyBg ? const EdgeInsets.only(left: 8, right: 8, bottom: 8) : null,
          child: Table(
            border: TableBorder.all(color: AppColors.lightCardProgressTrackColor, width: 1),
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(3),
            },
            children: tableRow.entries
                .map((entry) => TableRow(decoration: const BoxDecoration(color: AppColors.lightCardColor), children: [
                      BodyText(text: entry.key).paddingAll(8),
                      Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: entry.value.map((item) => item).toList())
                          .paddingAll(8)
                    ]))
                .toList(),
          ),
        ),
      ],
    );
  }
}
