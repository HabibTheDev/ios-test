import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/general_inspection_report_controller.dart';
import '../widgets/car_condition_tab_widget.dart';
import '../widgets/car_exterior_tab_widget.dart';
import '../widgets/car_health_overview_widget.dart';
import '../widgets/car_performance_tab_widget.dart';

class GeneralInspectionReport extends StatelessWidget {
  const GeneralInspectionReport({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GeneralInspectionReportController>();
    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.inspectionTerminationMgs, RouterPaths.drawer);
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
            child: SvgPicture.asset(Assets.assetsSvgReport),
          ),
          title: ButtonText(text: '${locale?.inspectionReport}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                screenTerminationWarning(locale, locale?.inspectionTerminationMgs, RouterPaths.drawer);
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: Obx(() => controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI(locale)),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale) {
    final controller = Get.find<GeneralInspectionReportController>();
    return RefreshIndicator(
      backgroundColor: AppColors.lightCardColor,
      onRefresh: () async {},
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                    backgroundColor: AppColors.primaryColor.withAlpha(38),
                    child: SvgPicture.asset(
                      Assets.assetsSvgCarSearch,
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(text: '${locale?.generalInspection}'),
                      SmallText(text: '#12345645', textColor: AppColors.lightSecondaryTextColor),
                    ],
                  ).paddingOnly(left: 10),
                ],
              ).paddingOnly(bottom: 10),

              ThreeItemInfoTile(
                leadingText: '${locale?.inspectionTime}',
                titleText: '2025-07-29',
                trailingText: '10:00 AM',
              ).paddingOnly(bottom: 4),
              ThreeItemInfoTile(
                leadingText: '${locale?.inspectedBy}',
                titleText: 'John Doe',
                trailingText: 'john.doe@example.com',
              ).paddingOnly(bottom: 32),

              // car Details
              CarDetailsWidget(
                imageUrl: null,
                carBrandImageUrl: null,
                model: 'A-Class',
                make: 'Mercedes-Benz',
                vin: '1234567890',
                location: 'Dhaka, Bangladesh',
                license: '1234567890',
                carColorName: 'Red',
                carColorCode: Colors.red,
              ),
              const HeightBox(height: 20),

              // Car health overview
              CarHealthOverviewWidget(engineOilLabel: 0.6, fuelLabel: 0.2, batteryLabel: 0.4, tireLabel: 0.4),
              const HeightBox(height: 20),

              // Tab bar
              TabBar(
                controller: controller.tabController,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: AppColors.lightSecondaryTextColor,
                indicatorColor: AppColors.primaryColor,
                indicatorWeight: 2,
                labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                tabs: AppList.carHealthTabList.map((tab) => Tab(text: tab)).toList(),
                onTap: controller.onTabChanged,
              ),
              const HeightBox(height: 20),
              Obx(
                () => controller.selectedTab.value == 0
                    ? CarExteriorTabWidget(locale: locale, controller: controller)
                    : controller.selectedTab.value == 1
                    ? CarConditionTabWidget(locale: locale, controller: controller)
                    : controller.selectedTab.value == 2
                    ? const CarPerformanceTabWidget()
                    : const SizedBox.shrink(),
              ),
              const HeightBox(height: 24),

              SolidTextButton(onTap: () {}, buttonText: '${locale?.submit}'),
            ],
          ),
        ),
      ),
    );
  }
}
