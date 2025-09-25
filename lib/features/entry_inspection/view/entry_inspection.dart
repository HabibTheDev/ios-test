import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/l10n/app_localizations.dart';
import '../../../core/router/router_paths.dart';

import '../../../shared/enums/enums.dart';
import '../../../shared/extensions/string_extension.dart';
import '../../../shared/model/single_task/steps_model.dart';
import '../../../shared/tiles/step_tile.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';

import '../../inspection/model/inspection_arguments_model.dart';
import '../../maintenance/view/widgets/widget_imports.dart';
import '../../my_task/view/widgets/report_issue_button_widget.dart';
import '../../my_task/view/widgets/task_assignee_widget.dart';
import '../controller/entry_inspection_controller.dart';

class EntryInspection extends StatefulWidget {
  const EntryInspection({super.key});

  @override
  State<EntryInspection> createState() => _EntryInspectionState();
}

class _EntryInspectionState extends State<EntryInspection> {
  late EntryInspectionController controller;
  late int? taskId;
  bool showStep = false;

  @override
  void initState() {
    controller = Get.find();
    taskId = Get.arguments[ArgumentsKey.taskId];
    controller.fetchSingleTaskOnInitially(taskId: taskId).then((_) {
      if (controller.taskModel.value?.task?.completionRate != null &&
          controller.taskModel.value!.task!.completionRate! > 0) {
        setState(() => showStep = true);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Obx(
      () => ProgressBarScaffold(
        title: '${locale?.entryInspection}',
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
                imageUrl: controller.taskModel.value?.carInfo?.images?.firstOrNull,
                carBrandImageUrl: controller.taskModel.value?.carInfo?.brandLogo,
                model: controller.taskModel.value?.carInfo?.model,
                make: controller.taskModel.value?.carInfo?.make,
                vin: controller.taskModel.value?.carInfo?.vin,
                location: controller.taskModel.value?.carInfo?.location?.locationName,
                license: controller.taskModel.value?.carInfo?.license,
                carColorName: controller.taskModel.value?.carInfo?.exteriorColor,
                carColorCode: controller.taskModel.value?.carInfo?.exteriorColorCode,
              ),
              const AppDivider().paddingSymmetric(vertical: 12),

              // Task priority
              CarInfoTile(
                titleKey: '${locale?.priority}',
                titleValue: '${controller.taskModel.value?.task?.priority?.toCapitalized()}',
              ).paddingOnly(bottom: 4),

              // Task status
              CarInfoTile(
                titleKey: '${locale?.taskStatus}',
                titleValue: '${controller.taskModel.value?.task?.status?.toCapitalized().replaceAll('-', ' ')}',
              ).paddingOnly(bottom: 16),

              // Date & Time
              BorderCardTile(
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

              // Note
              if (isNoteNotNullAndEmpty())
                BodyText(text: controller.taskModel.value?.task?.note ?? '${locale?.notAvailable}'),
            ],
          ),
        ).paddingOnly(bottom: 10),

        // Assigned by
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: TaskAssigneeWidget(assignedBy: controller.taskModel.value?.task?.assignedBy),
        ).paddingOnly(bottom: 10),
        CardWidget(
          contentPadding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Inspection Steps
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ButtonText(
                    text: '${locale?.inspection} ${locale?.steps.toLowerCase()}',
                    textColor: AppColors.lightSecondaryTextColor,
                  ),

                  // Report issue button
                  ReportIssueButtonWidget(
                    taskModel: controller.taskModel.value,
                    onReportComplete: () {
                      controller.fetchSingleTask(taskId: taskId);
                    },
                  ),
                ],
              ),

              // Task starting date
              if (controller.taskModel.value?.task?.startTaskDate != null)
                CarInfoTile(
                  fontSize: 10,
                  titleKey: '${locale?.started}',
                  titleValue: readableDate(
                    controller.taskModel.value!.task!.startTaskDate!,
                    pattern: '${AppString.readableDateFormat} - ${AppString.readableTimeFormat}',
                  ),
                ),
              HeightBox(height: 16),

              showStep == false
                  ? SolidTextButton(
                      onTap: () => showStartStepDialog(
                        onProceed: () {
                          setState(() => showStep = true);
                          Get.back();
                        },
                      ),
                      buttonText: '${locale?.startProcess}',
                    )
                  : Obx(
                      () => controller.taskModel.value?.task?.steps != null
                          ? ListView.separated(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.taskModel.value!.task!.steps!.length,
                              separatorBuilder: (context, index) => const HeightBox(height: 10),
                              itemBuilder: (context, index) {
                                final Steps step = controller.taskModel.value!.task!.steps![index];
                                return Obx(
                                  () => StepTile(
                                    onPressed: () {
                                      controller.stepActionOnTap(step: step, locale: locale);
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
                                    taskState: TaskStateEnum.entryInspection,
                                  ),
                                );
                              },
                            )
                          : SizedBox.shrink(),
                    ),

              // Task completion date
              if (controller.taskModel.value?.task?.completedOn != null)
                CarInfoTile(
                  fontSize: 10,
                  titleKey: '${locale?.completed}',
                  titleValue: readableDate(
                    controller.taskModel.value!.task!.completedOn!,
                    pattern: '${AppString.readableDateFormat} - ${AppString.readableTimeFormat}',
                  ),
                ).paddingSymmetric(vertical: 16),

              // View report button
              if (controller.taskModel.value?.task?.status == TaskStepStatusEnum.completed.value)
                Center(
                  child: SolidTextButton(
                    buttonText: '${locale?.viewReport}',
                    onTap: () {
                      Get.toNamed(
                        RouterPaths.reviewReport,
                        arguments: {
                          ArgumentsKey.viewInspectionReport: true,
                          ArgumentsKey.inspectionArgumentsModel: InspectionArgumentsModel(
                            title: '${locale?.report}',
                            returnScreen: RouterPaths.entryInspection,
                            inspectionType: InspectionTypeEnum.entryInspection,
                            taskId: controller.taskModel.value?.task?.id,
                            carID: controller.taskModel.value?.task?.carId,
                            contactID: controller.taskModel.value?.task?.contactId,
                            taskStepId: null,
                            vin: null,
                          ),
                        },
                      );
                    },
                  ),
                ).paddingOnly(top: 16),
            ],
          ),
        ),
      ],
    ),
  );

  bool isNoteNotNullAndEmpty() =>
      controller.taskModel.value?.task?.note != null && controller.taskModel.value!.task!.note!.isNotEmpty;

  bool isTaskCompleted() =>
      controller.taskModel.value?.task?.status?.toLowerCase() == TaskStepStatusEnum.completed.value;
}
