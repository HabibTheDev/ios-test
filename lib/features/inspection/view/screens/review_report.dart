import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../../shared/extensions/string_extension.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/network_image_widget.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/three_item_info_tile.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inbox/model/message_model.dart';
import '../../controller/review_report_controller.dart';
import '../../model/inspection_arguments_model.dart';
import '../tiles/basic_info_tile.dart';
import '../widgets/damage_report_table.dart';
import '../widgets/exterior_condition_widget.dart';

class ReviewReport extends StatefulWidget {
  const ReviewReport({super.key});

  @override
  State<ReviewReport> createState() => _ReviewReportState();
}

class _ReviewReportState extends State<ReviewReport> {
  late ReviewReportController controller;
  late InspectionArgumentsModel? inspectionArgumentsModel;
  bool viewInspectionReport = false;

  @override
  void initState() {
    super.initState();

    controller = Get.find();
    inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];
    viewInspectionReport = Get.arguments?[ArgumentsKey.viewInspectionReport] ?? false;
    debugPrint(inspectionArgumentsModel.toString());

    WidgetsBinding.instance.addPostFrameCallback((value) {
      controller.init(inspectionArgumentsModel: inspectionArgumentsModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (!viewInspectionReport) {
            screenTerminationWarning(locale, locale?.inspectionTerminationMgs, inspectionArgumentsModel?.returnScreen);
          } else {
            Get.back();
          }
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
          title: ButtonText(text: inspectionArgumentsModel?.title ?? '${locale?.notAvailable}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                if (!viewInspectionReport) {
                  screenTerminationWarning(
                    locale,
                    locale?.inspectionTerminationMgs,
                    inspectionArgumentsModel?.returnScreen,
                  );
                } else {
                  Get.back();
                }
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
    final report = controller.inspectionReportModel.value?.reportOverview;
    return ListRefreshIndicator(
      onRefresh: () async => await controller.init(inspectionArgumentsModel: inspectionArgumentsModel),
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
                      TitleText(
                        text:
                            '${(inspectionArgumentsModel?.inspectionType?.value ?? '${locale?.notAvailable}').toLowerCase().toCapitalized()} ${locale?.report.toLowerCase()}',
                      ),
                      SmallText(
                        text: '#${report?.id ?? '${locale?.notAvailable}'}',
                        textColor: AppColors.lightSecondaryTextColor,
                      ),
                    ],
                  ).paddingOnly(left: 10),
                ],
              ).paddingOnly(bottom: 10),

              ThreeItemInfoTile(
                leadingText: '${locale?.inspectionTime}',
                titleText: report?.updatedAt != null
                    ? readableDate(report!.updatedAt!, pattern: AppString.readableDateFormat)
                    : '',
                trailingText: report?.updatedAt != null
                    ? readableDate(report!.updatedAt!, pattern: AppString.readableTimeFormat)
                    : '',
              ).paddingOnly(bottom: 4),
              ThreeItemInfoTile(
                leadingText: '${locale?.inspectedBy}',
                titleText: report?.inspectedBy?.fullName ?? report?.employee?.fullName ?? locale?.notAvailable ?? '',
                trailingText: report?.inspectedBy?.email ?? report?.employee?.email ?? '',
              ).paddingOnly(bottom: 32),

              // Basic info
              BodyText(
                text: '${locale?.basicInfo}',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.w700,
              ).paddingOnly(bottom: 20),

              BasicInfoTile(
                leadingText: '${locale?.odometerReading}',
                value: '${roundDouble(report?.odometerReading ?? 0.0)} M',
              ),
              const AppDivider(height: 24),
              BasicInfoTile(
                leadingText: '${locale?.fuelTankLevel}',
                value: report?.fuel != null
                    ? '${roundDouble((report?.fuel?.percentRemaining ?? 0.0) * 100)}% / ${roundDouble(report?.fuel?.range ?? 0.0)} M'
                    : '${locale?.notAvailable}',
              ),
              const AppDivider(height: 24),
              BasicInfoTile(
                leadingText: '${locale?.engineOilLife}',
                value: '${roundDouble(report?.engineOilLife ?? 0.0)}%',
              ),
              const AppDivider(height: 24),
              BasicInfoTile(
                leadingText: '${locale?.tirePressure}',
                value:
                    '${locale?.backLeft}: ${roundDouble(report?.tirePressureBackLeft ?? 0.0)} psi\n${locale?.backRight}: ${roundDouble(report?.tirePressureBackRight ?? 0.0)} psi\n${locale?.frontLeft}: ${roundDouble(report?.tirePressureFrontLeft ?? 0.0)} psi\n${locale?.frontRight}: ${roundDouble(report?.tirePressureFrontRight ?? 0.0)} psi',
              ).paddingOnly(bottom: 32),

              // Car side images
              Wrap(
                spacing: 6.w,
                children: [
                  _imageWidget(report?.leftSideImage),
                  _imageWidget(report?.frontSideImage),
                  _imageWidget(report?.rightSideImage),
                  _imageWidget(report?.rearSideImage),
                ],
              ),

              // License, odometer, VIN images
              Wrap(
                spacing: 6.w,
                children: [
                  if (report?.licensePlateImage != null) _imageWidget(report?.licensePlateImage),
                  if (report?.odometerImage != null) _imageWidget(report?.odometerImage),
                  if (report?.doorVinStickerImage != null) _imageWidget(report?.doorVinStickerImage),
                ],
              ).paddingOnly(top: 8),
              const HeightBox(height: 32),

              // Exterior condition
              BodyText(
                text: '${locale?.exteriorCondition}',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.w700,
              ).paddingOnly(bottom: 20),
              ExteriorConditionWidget(
                reportOverview: report,
                carPartsSvgMap: controller.inspectionReportModel.value?.carPartsSvgMap,
              ).paddingOnly(bottom: 24),

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
                  ),
                ),

              // Buttons
              SafeArea(
                child: !viewInspectionReport
                    ? Row(
                        children: [
                          Expanded(
                            child: OutlineTextButton(
                              onTap: () => screenTerminationWarning(
                                locale,
                                locale?.inspectionTerminationMgs,
                                inspectionArgumentsModel?.returnScreen,
                              ),
                              buttonText: '${locale?.previous}',
                            ),
                          ),
                          const WidthBox(width: 6),
                          Expanded(
                            child: SolidTextButton(
                              isLoading: controller.functionLoading.value,
                              onTap: () => inspectionArgumentsModel?.returnScreen == RouterPaths.returnTask
                                  ? Get.toNamed(
                                      RouterPaths.finalSummary,
                                      arguments: {ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel},
                                    )
                                  : finishButtonWarning(locale),
                              buttonText: inspectionArgumentsModel?.returnScreen == RouterPaths.returnTask
                                  ? '${locale?.next}'
                                  : '${locale?.submit}',
                            ),
                          ),
                        ],
                      )
                    : SolidTextButton(
                        isLoading: controller.functionLoading.value,
                        onTap: () => Get.back(),
                        buttonText: '${locale?.close}',
                      ),
              ),
            ],
          ),
        ),
      ),
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
          controller.submitButtonOnTap(inspectionArgumentsModel: inspectionArgumentsModel);
        },
      ),
    );
  }
}
