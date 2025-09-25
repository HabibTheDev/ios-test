import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/damage_parts_svg_model.dart';
import '../../model/inspection_report_model.dart';
import '../tiles/overall_info_tile.dart';
import 'car_damage_diagram.dart';

class ExteriorConditionWidget extends StatelessWidget {
  const ExteriorConditionWidget({
    super.key,
    required this.reportOverview,
    required this.carPartsSvgMap,
  });

  final ReportOverview? reportOverview;
  final Map<String, DamagePartsSvgModel>? carPartsSvgMap;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final newDamage = (reportOverview?.totalDamagesDetected ?? 0) - (reportOverview?.previousTotalDamageDetected ?? 0);
    return Column(
      children: [
        // Overview
        if (reportOverview != null)
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TitleText(
                    text: getConditionEmoji(reportOverview?.fullExteriorCondition),
                    textColor: AppColors.emojiColor,
                    textSize: 40,
                  ),
                  TitleText(
                    text: getCarCondition(reportOverview?.fullExteriorCondition, locale),
                    textColor: AppColors.lightProgressColor,
                  ),
                  SmallText(text: '${locale?.overall}')
                ],
              ).paddingOnly(right: 30),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    OverallInfoTile(
                        title: '${locale?.totalPartsDetected}', value: '${reportOverview?.totalPartsDetected ?? 0}'),
                    const AppDivider(height: 16),
                    OverallInfoTile(
                        title: '${locale?.damagesFound}', value: '${reportOverview?.totalDamagesDetected ?? 0}'),
                    if (newDamage != 0 && !newDamage.isNegative)
                      SmallText(
                        text: "\u2191 $newDamage ${locale?.newStr}",
                        textColor: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    const AppDivider(height: 16),
                    OverallInfoTile(
                        title: '${locale?.missingParts}', value: '${reportOverview?.totalMissingParts ?? 0}'),
                  ],
                ),
              )
            ],
          ).paddingOnly(bottom: 32),

        // Damage diagram
        CarDamageDiagram(carPartsSvgMap: carPartsSvgMap)
      ],
    );
  }

  String getCarCondition(int? score, AppLocalizations? locale) {
    if (score == null) return '${locale?.invalidScore}';
    if (score < 4) {
      return '${locale?.poor}';
    } else if (score >= 4 && score < 7) {
      return '${locale?.fair}';
    } else if (score >= 7 && score < 9) {
      return '${locale?.good}';
    } else if (score >= 9 && score <= 10) {
      return '${locale?.excellent}';
    } else {
      return '${locale?.invalidScore}';
    }
  }

  String getConditionEmoji(int? score) {
    if (score == null) return '\u{1F615}';
    if (score < 4) {
      return '\u{1F61E}';
    } else if (score >= 4 && score < 7) {
      return '\u{1F610}';
    } else if (score >= 7 && score < 9) {
      return '\u{1F642}';
    } else if (score >= 9 && score <= 10) {
      return '\u{1F604}';
    } else {
      return '\u{1F615}';
    }
  }
}
