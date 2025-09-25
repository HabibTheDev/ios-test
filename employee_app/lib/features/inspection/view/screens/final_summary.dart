import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/final_summary_controller.dart';
import '../../model/inspection_arguments_model.dart';
import '../tiles/basic_info_tile.dart';
import '../tiles/overall_info_tile.dart';
import '../widgets/summary_table_widget.dart';

class FinalSummary extends StatefulWidget {
  const FinalSummary({super.key});

  @override
  State<FinalSummary> createState() => _FinalSummaryState();
}

class _FinalSummaryState extends State<FinalSummary> {
  late FinalSummaryController controller;
  late InspectionArgumentsModel? inspectionArgumentsModel;

  @override
  void initState() {
    super.initState();

    controller = Get.find();
    inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];
    debugPrint(inspectionArgumentsModel.toString());

    WidgetsBinding.instance.addPostFrameCallback((value) {
      controller.fetchFinalSummary(inspectionArgumentsModel: inspectionArgumentsModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.inspectionTerminationMgs, inspectionArgumentsModel?.returnScreen);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightCardColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.transparent,
            child: SvgPicture.asset(Assets.assetsSvgCarSearch),
          ),
          title: ButtonText(text: inspectionArgumentsModel?.inspectionType?.value ?? '${locale?.notAvailable}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => screenTerminationWarning(
                locale,
                locale?.inspectionTerminationMgs,
                inspectionArgumentsModel?.returnScreen,
              ),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: Obx(() => controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI()),
      ),
    );
  }

  Widget _bodyUI() {
    return ListRefreshIndicator(
      onRefresh: () async => await controller.fetchFinalSummary(inspectionArgumentsModel: inspectionArgumentsModel),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const AlwaysScrollableScrollPhysics(),
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
                    backgroundColor: AppColors.primaryColor.withAlpha(38),
                    child: SvgPicture.asset(
                      Assets.assetsSvgMenuBar,
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(text: 'Final summary'),
                      SmallText(
                        text: '11 Mar 2023 - 10 Aug 2024',
                        textColor: AppColors.lightSecondaryTextColor,
                      ),
                    ],
                  ).paddingOnly(left: 10)
                ],
              ).paddingOnly(bottom: 10),

              const ThreeItemInfoTile(
                      leadingText: 'Departure inspection by', titleText: 'Danish Ali', trailingText: 'danish@email.com')
                  .paddingOnly(bottom: 4),
              const ThreeItemInfoTile(
                      leadingText: 'Return inspection by', titleText: 'Danish Ali', trailingText: 'danish@email.com')
                  .paddingOnly(bottom: 32),

              // Total Issue & Maintenance
              Row(
                children: [
                  Expanded(
                      child: CardWidget(
                    contentPadding: const EdgeInsets.all(16),
                    showShadow: false,
                    bgColor: AppColors.primaryColor.withAlpha(25),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [TitleText(text: '04'), SmallText(text: 'Total reported issues')],
                    ),
                  )),
                  const WidthBox(width: 10),
                  Expanded(
                      child: CardWidget(
                    contentPadding: const EdgeInsets.all(16),
                    showShadow: false,
                    bgColor: AppColors.primaryColor.withAlpha(25),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [TitleText(text: '01'), SmallText(text: 'Total maintenance')],
                    ),
                  )),
                ],
              ).paddingOnly(bottom: 32),

              // Car health
              const BodyText(
                      text: 'Car health', textColor: AppColors.lightSecondaryTextColor, fontWeight: FontWeight.w700)
                  .paddingOnly(bottom: 20),

              const SummaryTableWidget(
                headerTitle: 'Departure',
                tableRow: {
                  'Odometer reading': [SmallText(text: '751 M', fontWeight: FontWeight.w600)],
                  'Fuel tank level': [SmallText(text: '90% / 170.5 M', fontWeight: FontWeight.w600)],
                  'Engine oil life': [SmallText(text: '90%', fontWeight: FontWeight.w600)],
                  'Tire pressure': [
                    BasicInfoTile(leadingText: 'Back left:', value: '323 psi', fontWeight: FontWeight.w600),
                    BasicInfoTile(leadingText: 'Back right:', value: '323 psi', fontWeight: FontWeight.w600),
                    BasicInfoTile(leadingText: 'Front left:', value: '323 psi', fontWeight: FontWeight.w600),
                    BasicInfoTile(leadingText: 'Back right:', value: '323 psi', fontWeight: FontWeight.w600),
                  ]
                },
              ),

              const SummaryTableWidget(
                headerTitle: 'Return',
                tableRow: {
                  'Odometer reading': [SmallText(text: '3245 M', fontWeight: FontWeight.w600)],
                  'Fuel tank level': [SmallText(text: '80% / 170.5 M', fontWeight: FontWeight.w600)],
                  'Engine oil life': [SmallText(text: '90%', fontWeight: FontWeight.w600)],
                  'Tire pressure': [
                    BasicInfoTile(leadingText: 'Back left:', value: '323 psi', fontWeight: FontWeight.w600),
                    BasicInfoTile(leadingText: 'Back right:', value: '323 psi', fontWeight: FontWeight.w600),
                    BasicInfoTile(leadingText: 'Front left:', value: '323 psi', fontWeight: FontWeight.w600),
                    BasicInfoTile(leadingText: 'Back right:', value: '323 psi', fontWeight: FontWeight.w600),
                  ]
                },
              ).paddingOnly(bottom: 32),

              // Maintenance
              const BodyText(
                      text: 'Maintenance', textColor: AppColors.lightSecondaryTextColor, fontWeight: FontWeight.w700)
                  .paddingOnly(bottom: 20),
              const SummaryTableWidget(
                headerLeading: '1',
                headerTitle: 'Regular servicing',
                headerSubTitle: '12 Apr 2023  10:08 AM',
                applyBg: true,
                borderRadius: 4,
                tableRow: {
                  'Maintained by': [
                    SmallText(text: 'Danish Ali', fontWeight: FontWeight.w600),
                    SmallText(
                      text: 'danish@gmail.com',
                      textColor: AppColors.lightSecondaryTextColor,
                    ),
                  ],
                  'Damages fixed': [SmallText(text: '-', fontWeight: FontWeight.w600)],
                  'Amount spent': [SmallText(text: '90% / 323.7 M', fontWeight: FontWeight.w600)],
                },
              ).paddingOnly(bottom: 10),

              // Damage servicing
              const SummaryTableWidget(
                headerLeading: '2',
                headerTitle: 'Damage servicing',
                headerSubTitle: '12 Apr 2023  10:08 AM',
                applyBg: true,
                borderRadius: 4,
                tableRow: {
                  'Maintained by': [
                    SmallText(text: 'Danish Ali', fontWeight: FontWeight.w600),
                    SmallText(
                      text: 'danish@gmail.com',
                      textColor: AppColors.lightSecondaryTextColor,
                    ),
                  ],
                  'Damages fixed': [SmallText(text: '-', fontWeight: FontWeight.w600)],
                  'Amount spent': [SmallText(text: '90% / 323.7 M', fontWeight: FontWeight.w600)],
                },
              ).paddingOnly(bottom: 32),

              // Exterior damages
              const BodyText(
                      text: 'Exterior damages',
                      textColor: AppColors.lightSecondaryTextColor,
                      fontWeight: FontWeight.w700)
                  .paddingOnly(bottom: 20),
              const SummaryTableWidget(
                headerLeading: '1',
                headerTitle: 'Departure inspection',
                headerSubTitle: '12 Apr 2023  10:08 AM',
                applyBg: true,
                borderRadius: 4,
                tableRow: {
                  'Maintained by': [SmallText(text: '7 / 10', fontWeight: FontWeight.w600)],
                  'Damages found': [SmallText(text: '30', fontWeight: FontWeight.w600)],
                  'New damages': [SmallText(text: '0', fontWeight: FontWeight.w600)],
                  'Missing parts': [SmallText(text: '0', fontWeight: FontWeight.w600)],
                },
              ).paddingOnly(bottom: 10),

              const SummaryTableWidget(
                headerLeading: '2',
                headerTitle: 'Reported issue',
                headerSubTitle: '12 Apr 2023  10:08 AM',
                applyBg: true,
                borderRadius: 4,
                tableRow: {
                  'Maintained by': [SmallText(text: '7 / 10', fontWeight: FontWeight.w600)],
                  'Damages found': [SmallText(text: '30', fontWeight: FontWeight.w600)],
                  'New damages': [SmallText(text: '0', fontWeight: FontWeight.w600)],
                  'Missing parts': [SmallText(text: '0', fontWeight: FontWeight.w600)],
                },
              ).paddingOnly(bottom: 32),

              const OverallInfoTile(title: 'Total new damages', value: '40'),
              const AppDivider(height: 16),
              const OverallInfoTile(title: 'Total missing parts', value: '10').paddingOnly(bottom: 32),

              // Button
              SafeArea(
                child: SolidTextButton(
                  isLoading: controller.functionLoading.value,
                  onTap: () => controller.finishInspection(inspectionArgumentsModel: inspectionArgumentsModel),
                  buttonText: 'Finish',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
