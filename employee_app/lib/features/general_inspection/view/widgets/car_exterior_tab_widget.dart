import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/constants/damage_diagram_map.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inbox/model/message_model.dart';
import '../../../inspection/model/inspection_report_model.dart';
import '../../../inspection/view/widgets/damage_report_table.dart';
import '../../../inspection/view/widgets/exterior_condition_widget.dart';
import '../../controller/general_inspection_report_controller.dart';

class CarExteriorTabWidget extends StatelessWidget {
  const CarExteriorTabWidget({super.key, required this.locale, required this.controller});
  final AppLocalizations? locale;
  final GeneralInspectionReportController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Car side images
        Wrap(spacing: 6.w, children: [_imageWidget(null), _imageWidget(null), _imageWidget(null), _imageWidget(null)]),
        const HeightBox(height: 20),

        ExteriorConditionWidget(
          reportOverview: null,
          carPartsSvgMap: DamageDiagramMap.partsMap,
        ).paddingOnly(bottom: 24),

        // Damage details table
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => const HeightBox(height: 10),
          itemBuilder: (context, index) => DamageReportTable(
            carSectionReport: CarSectionReport(
              sectionName: 'Left Side',
              svgImagePath: Assets.assetsSvgCarBody,
              partsCount: 10,
              healthPercent: 5,
              damageList: [DamageList(part: 'Front Bumper', partAreaList: [])],
            ),
            inspectionTypeEnum: null,
            carId: null,
            reportOverviewId: null,
          ),
        ),
      ],
    );
  }

  Widget _imageWidget(String? imageUrl) => InkWell(
    onTap: () {
      if (imageUrl != null) {
        Get.toNamed(
          RouterPaths.filePreview,
          arguments: {
            ArgumentsKey.attachments: [Attachment(url: imageUrl)],
          },
        );
      }
    },
    child: NetworkImageWidget(imageUrl: imageUrl, height: 56.h, width: 80.w, borderRadius: 6),
  );
}
