import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/vehicle_performance_controller.dart';
import '../tiles/vehicle_performance_tile.dart';

class VehiclePerformance extends StatelessWidget {
  const VehiclePerformance({super.key});

  @override
  Widget build(BuildContext context) {
    final VehiclePerformanceController controller = Get.find();

    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.screenTerminationMsg, RouterPaths.generalInspection);
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
            child: SvgPicture.asset(Assets.assetsSvgGeneralEcgHeart),
          ),
          title: ButtonText(text: '${locale?.vehiclePerformance}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => screenTerminationWarning(
                locale,
                locale?.screenTerminationMsg,
                RouterPaths.generalInspection,
              ),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: _bodyUI(locale: locale, controller: controller),
        bottomNavigationBar: Obx(
          () => SafeArea(
            child: SolidTextButton(
              onTap: () => controller.finishTestingOnTap(),
              buttonText: '${locale?.finishTesting}',
              backgroundColor: !controller.completedAllTesting.value ? AppColors.disablePrimaryColor : null,
            ),
          ),
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _bodyUI({required AppLocalizations? locale, required VehiclePerformanceController controller}) => Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleText(text: '${locale?.testVehiclePerformance}').paddingOnly(bottom: 16, top: 20),

            // Vehicle performance test type
            Expanded(
              child: Obx(
                () => ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.performanceTestTypeList.length,
                  separatorBuilder: (context, index) => const AppDivider(),
                  itemBuilder: (context, index) => VehiclePerformanceTile(
                    model: controller.performanceTestTypeList[index],
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
