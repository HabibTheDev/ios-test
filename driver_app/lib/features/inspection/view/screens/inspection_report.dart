import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/inspection_capture_controller.dart';
import '../../controller/inspection_report_controller.dart';
import '../../model/damage_model.dart';
import '../tiles/basic_info_tile.dart';
import '../tiles/document_tile.dart';
import '../widgets/damage_report_table.dart';
import '../widgets/exterior_condition_widget.dart';

class InspectionReport extends StatefulWidget {
  const InspectionReport({super.key});

  @override
  State<InspectionReport> createState() => _InspectionReportState();
}

class _InspectionReportState extends State<InspectionReport> {
  late InspectionReportController controller;

  @override
  void initState() {
    super.initState();
    try {
      controller = Get.find();
    } catch (e) {
      controller = Get.put(InspectionReportController());
    }
  }

  @override
  Widget build(BuildContext context) {
    InspectionCaptureController captureController = Get.find();
    // Retrieve arguments
    final title = Get.arguments?[ArgumentsKey.title] ?? 'Report an issue';
    final issueTitle = Get.arguments?[ArgumentsKey.issueTitle];
    final returnScreen = Get.arguments?[ArgumentsKey.returnScreen] ?? RouterPaths.drawer;

    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: title,
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 1,
      progressColor: AppColors.inProgressColor,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: _bodyUI(
          returnScreen: returnScreen,
          issueTitle: issueTitle,
          controller: controller,
          captureController: captureController),
    );
  }

  Widget _bodyUI({
    required String returnScreen,
    required String issueTitle,
    required InspectionReportController controller,
    required InspectionCaptureController captureController,
  }) =>
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Damage info
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.primaryColor.withOpacity(0.15),
                    child: SvgPicture.asset(
                      Assets.assetsSvgCarCrush,
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(text: issueTitle),
                      const SmallText(
                        text: '#1233',
                        textColor: AppColors.lightSecondaryTextColor,
                      ),
                    ],
                  ).paddingOnly(left: 10)
                ],
              ).paddingOnly(bottom: 10),

              const ThreeItemInfoTile(leadingText: 'Reported at', titleText: '12 Jan 2024', trailingText: '12:34 PM')
                  .paddingOnly(bottom: 4),
              const ThreeItemInfoTile(
                      leadingText: 'Reported by', titleText: 'Danish Ali', trailingText: '(Main driver)')
                  .paddingOnly(bottom: 32),

              // Basic info
              const BodyText(
                      text: 'Basic info', textColor: AppColors.lightSecondaryTextColor, fontWeight: FontWeight.w700)
                  .paddingOnly(bottom: 20),

              const BasicInfoTile(
                  leadingText: 'Who was driving?', value: 'Nasir Shah Ali', trailingText: '(Main driver)'),
              const AppDivider(height: 24),
              const BasicInfoTile(leadingText: 'Was anybody hurt?', value: 'I\'m not sure'),
              const AppDivider(height: 24),
              const BasicInfoTile(leadingText: 'What collied with the vehicle?', value: 'Another vehicle'),
              const AppDivider(height: 24),
              const BasicInfoTile(leadingText: 'How many vehicle collied?', value: '02 or more'),
              const AppDivider(height: 24),
              const BasicInfoTile(
                  leadingText: 'How did it happen?',
                  value:
                      'While I was driving yesterday, the windshield of my car suddenly cracked. I didn’t hit anything major, but I think some debris must’ve struck it. At first, it was just a small chip, but within minutes, the crack spread across the glass. Now the entire windshield is covered in spider-like cracks, making it really hard to see. It feels dangerous to drive, and I need to get it replaced as soon as possible. I hope this can be fixed quickly because I rely on my car daily.'),
              const AppDivider(height: 24),
              const BasicInfoTile(leadingText: 'When did it happen?', value: 'Morning', trailingText: '6AM - 12PM'),
              const AppDivider(height: 24),
              const BasicInfoTile(leadingText: 'Date', value: '12 Jan 2023', trailingText: ''),
              const AppDivider(height: 24),
              const BasicInfoTile(
                  leadingText: 'Where did the incident occurred?',
                  value: '22/7 Dire streets, Vancouver, Canada',
                  trailingText: '(Somewhere else)'),
              const AppDivider(height: 24),
              const BasicInfoTile(
                      leadingText: 'Where is the vehicle now?',
                      value: 'Vicks Auto Repairs, 22/7 Dire streets, Vancouver, Canada',
                      trailingText: '(Repair shop)')
                  .paddingOnly(bottom: 32),

              // Images
              Row(
                children: captureController.carExteriorImageFiles
                    .map(
                      (item) => Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(6)),
                          child: Image.file(item, height: 56, fit: BoxFit.cover),
                        ).paddingOnly(right: 4),
                      ),
                    )
                    .toList(),
              ).paddingOnly(bottom: 16),

              const DocumentTile().paddingOnly(bottom: 10),
              const DocumentTile().paddingOnly(bottom: 32),

              // Exterior condition
              const BodyText(
                      text: 'Exterior condition',
                      textColor: AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700)
                  .paddingOnly(bottom: 20),
              const ExteriorConditionWidget().paddingOnly(bottom: 24),

              // Damage details table
              DamageReportTable(
                damageList: damageList,
                carPartImageUrl: imageUrl,
                carPartName: 'Front side',
                carPartCount: '8',
                percentOfDamage: 0.95,
              ).paddingOnly(bottom: 32),

              // Damage details table
              DamageReportTable(
                damageList: damageList,
                carPartImageUrl: imageUrl,
                carPartName: 'Front side',
                carPartCount: '8',
                percentOfDamage: 0.95,
              ).paddingOnly(bottom: 32),

              // Button
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineTextButton(onTap: () => Get.back(), buttonText: 'Previous'),
                    ),
                    const WidthBox(width: 6),
                    Expanded(
                      child: SolidTextButton(
                          onTap: () {
                            Get.until((route) => route.settings.name == returnScreen);
                          },
                          buttonText: 'Finish'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
