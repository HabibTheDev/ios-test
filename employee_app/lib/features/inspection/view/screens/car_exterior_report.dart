import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/car_exterior_report_controller.dart';
import '../../model/inspection_arguments_model.dart';
import '../widgets/damage_report_table.dart';

class CarExteriorReport extends StatefulWidget {
  const CarExteriorReport({super.key});

  @override
  State<CarExteriorReport> createState() => _CarExteriorReportState();
}

class _CarExteriorReportState extends State<CarExteriorReport> {
  late CarExteriorReportController controller;
  late InspectionArgumentsModel? inspectionArgumentsModel;

  @override
  void initState() {
    super.initState();

    controller = Get.find();
    inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];
    debugPrint(inspectionArgumentsModel.toString());

    WidgetsBinding.instance.addPostFrameCallback((value) {
      controller.putExteriorDamageReport(inspectionArgumentsModel: inspectionArgumentsModel);
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
            child: SvgPicture.asset(Assets.assetsSvgGeneralFlag),
          ),
          title: ButtonText(text: '${locale?.step} 3/3'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => screenTerminationWarning(
                locale,
                locale?.inspectionTerminationMgs,
                inspectionArgumentsModel?.returnScreen,
              ),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: Obx(() => controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI(locale)),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale) {
    return ListRefreshIndicator(
      onRefresh: () async =>
          await controller.fetchExteriorInspectionReport(inspectionArgumentsModel: inspectionArgumentsModel),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Review damages
              TitleText(text: '${locale?.reviewDamages}').paddingOnly(bottom: 32),

              // Damage details table
              if (controller.inspectionReportModel.value != null &&
                  controller.inspectionReportModel.value!.carSectionReports!.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.inspectionReportModel.value!.carSectionReports!.length,
                  separatorBuilder: (context, index) => const HeightBox(height: 10),
                  itemBuilder: (context, index) => DamageReportTable(
                    carSectionReport: controller.inspectionReportModel.value!.carSectionReports![index],
                    inspectionTypeEnum: inspectionArgumentsModel?.inspectionType,
                    carId: inspectionArgumentsModel?.carID,
                    reportOverviewId: controller.inspectionReportModel.value?.reportOverview?.id,
                    isEdit: true,
                    editSuccessCallback: (result) {
                      if (result == true) {
                        controller.fetchExteriorInspectionReport(inspectionArgumentsModel: inspectionArgumentsModel);
                      }
                      // Refresh list if damage deleted
                      if (controller.deletedDamageFromDamageCustomization == true) {
                        controller.fetchExteriorInspectionReport(inspectionArgumentsModel: inspectionArgumentsModel);
                        controller.deletedDamageFromDamageCustomization == false;
                      }
                    },
                  ),
                ),

              // Buttons
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineTextButton(
                        onTap: () => controller.recaptureButtonOnTap(),
                        buttonText: '${locale?.reCapture}',
                      ),
                    ),
                    const WidthBox(width: 6),
                    Expanded(
                      child: SolidTextButton(
                        isLoading: controller.functionLoading.value,
                        onTap: () => inspectionArgumentsModel?.returnScreen == RouterPaths.returnTask
                            ? Get.toNamed(
                                RouterPaths.reviewReport,
                                arguments: {ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel},
                              )
                            : controller.finishButtonOnTap(inspectionArgumentsModel: inspectionArgumentsModel),
                        buttonText: inspectionArgumentsModel?.returnScreen == RouterPaths.returnTask
                            ? '${locale?.next}'
                            : '${locale?.finish}',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void finishButtonWarning(AppLocalizations? locale) {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.info,
        title: locale?.areYouSure ?? '',
        message: locale?.reportFinishConfirmationMgs ?? '',
        primaryButtonText: locale?.ok ?? '',
        themeColor: AppColors.warningColor,
        buttonAction: () {
          Navigator.of(context).pop();
          controller.finishButtonOnTap(inspectionArgumentsModel: inspectionArgumentsModel);
        },
      ),
    );
  }
}
