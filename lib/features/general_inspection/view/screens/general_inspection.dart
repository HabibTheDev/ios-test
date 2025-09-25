import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/model/single_task/steps_model.dart';
import '../../../../shared/tiles/step_tile.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/general_inspection_controller.dart';

class GeneralInspection extends StatefulWidget {
  const GeneralInspection({super.key});

  @override
  State<GeneralInspection> createState() => _GeneralInspectionState();
}

class _GeneralInspectionState extends State<GeneralInspection> {
  late GeneralInspectionController controller;
  late int? taskId;
  bool showStep = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find();

    taskId = Get.arguments?[ArgumentsKey.taskId];
    controller.fetchSingleTaskOnInitially(taskId: taskId).then((value) {
      if (controller.taskModel.value?.task?.completionRate != null &&
          controller.taskModel.value!.task!.completionRate! > 0) {
        setState(() => showStep = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Obx(
      () => ProgressBarScaffold(
        title: '${locale?.generalInspection}',
        progressValue: controller.taskModel.value != null
            ? (controller.taskModel.value?.task?.completionRate ?? 0) / 100
            : 0.0,
        body: controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI(locale),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale) => ListRefreshIndicator(
    onRefresh: () async => await controller.fetchSingleTask(taskId: taskId),
    child: ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // car Details
              CarDetailsWidget(
                imageUrl: controller.taskModel.value?.carInfo?.images?.first,
                carBrandImageUrl: controller.taskModel.value?.carInfo?.brandLogo,
                model: controller.taskModel.value?.carInfo?.model,
                make: controller.taskModel.value?.carInfo?.make,
                vin: controller.taskModel.value?.carInfo?.vin,
                location: controller.taskModel.value?.carInfo?.location?.locationName,
                license: controller.taskModel.value?.carInfo?.license,
                carColorName: controller.taskModel.value?.carInfo?.exteriorColor,
                carColorCode: controller.taskModel.value?.carInfo?.exteriorColorCode,
              ),
              const AppDivider().paddingSymmetric(vertical: 16),

              // Date & Time
              InkWell(
                onTap: () => Get.toNamed(RouterPaths.vehiclePerformance),
                child: BorderCardTile(
                  leading: const Icon(Icons.watch_later, color: AppColors.primaryColor, size: 22),
                  title: readableDate(
                    controller.taskModel.value?.task?.date ?? DateTime.now(),
                    pattern: AppString.readableDateFormat,
                  ),
                  secondaryTitle: readableDate(
                    controller.taskModel.value?.task?.date ?? DateTime.now(),
                    pattern: AppString.readableTimeFormat,
                  ),
                  subTitle: '${locale?.inspectionTime}',
                ).paddingOnly(bottom: 20),
              ),

              // Note
              BodyText(
                text: controller.taskModel.value?.task?.note ?? '${locale?.notAvailable}',
              ).paddingOnly(bottom: 20),

              // Inspection Steps
              CardWidget(
                contentPadding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ButtonText(
                      text: '${locale?.inspection} ${locale?.steps.toLowerCase()}',
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 20),
                    showStep == false
                        ? SolidTextButton(
                            onTap: () => showStartStepDialog(
                              onProceed: () {
                                setState(() => showStep = true);
                                Get.back();
                                Get.toNamed(RouterPaths.captureVin);
                              },
                            ),
                            buttonText: '${locale?.startProcess}',
                          )
                        : Obx(
                            () => controller.taskModel.value?.task?.steps != null
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.taskModel.value!.task!.steps!.length,
                                    itemBuilder: (context, index) {
                                      final Steps step = controller.taskModel.value!.task!.steps![index];
                                      return Obx(
                                        () => StepTile(
                                          onPressed: () {
                                            // Implement stepper button action
                                            Get.toNamed(RouterPaths.captureVin);
                                          },
                                          carDirectionOnTap: () {
                                            final latitude = controller.taskModel.value?.task?.location?.latitude;
                                            final longitude = controller.taskModel.value?.task?.location?.longitude;
                                            final destinationAddress =
                                                controller.taskModel.value?.task?.location?.locationName;
                                            if (latitude == null || longitude == null) {
                                              showToast('${locale?.addressNotFound}');
                                              return;
                                            }
                                            Get.toNamed(
                                              RouterPaths.carDirection,
                                              arguments: {
                                                ArgumentsKey.latitude: latitude,
                                                ArgumentsKey.longitude: longitude,
                                                ArgumentsKey.destinationAddress: destinationAddress,
                                              },
                                            );
                                          },
                                          index: index,
                                          listLength: controller.taskModel.value!.task!.steps!.length,
                                          step: step,
                                          buttonLoading: controller.stepLoading.value,
                                          taskState: TaskStateEnum.generalInspection,
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => const HeightBox(height: 10),
                                  )
                                : NoDataFound(message: '${locale?.noStepsFound}'),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
