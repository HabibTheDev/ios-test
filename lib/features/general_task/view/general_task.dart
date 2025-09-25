import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../shared/model/single_task/steps_model.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../shared/enums/enums.dart';
import '../../../shared/utils/utils.dart';
import '../../../shared/widgets/widget_imports.dart';
import '../controller/general_task_controller.dart';
import '../../../shared/tiles/step_tile.dart';

class GeneralTask extends StatefulWidget {
  const GeneralTask({super.key});

  @override
  State<GeneralTask> createState() => _GeneralTaskState();
}

class _GeneralTaskState extends State<GeneralTask> {
  late GeneralTaskController controller;
  late int? taskId;
  bool showStep = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find();
    taskId = Get.arguments[ArgumentsKey.taskId];

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
    return Obx(() => ProgressBarScaffold(
          title: '${locale?.taskDetails}',
          progressValue:
              controller.taskModel.value != null ? (controller.taskModel.value?.task?.completionRate ?? 0) / 100 : 0.0,
          body: controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI(locale),
        ));
  }

  Widget _bodyUI(AppLocalizations? locale) => ListRefreshIndicator(
        onRefresh: () async => await controller.fetchSingleTask(taskId: taskId),
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            CardWidget(
                contentPadding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Task Title
                    TitleText(text: controller.taskModel.value?.task?.title ?? '${locale?.notAvailable}'),
                    SmallText(text: controller.taskModel.value?.task?.note ?? '${locale?.notAvailable}')
                        .paddingOnly(bottom: 20),

                    // Date & Time
                    BorderCardTile(
                      leading: const Icon(
                        Icons.watch_later,
                        color: AppColors.primaryColor,
                        size: 22,
                      ),
                      title: readableDate(controller.taskModel.value?.task?.date ?? DateTime.now(),
                          pattern: AppString.readableDateFormat),
                      secondaryTitle: readableDate(controller.taskModel.value?.task?.date ?? DateTime.now(),
                          pattern: AppString.readableTimeFormat),
                      subTitle: '${locale?.date} & ${locale?.time.toLowerCase()}',
                    )
                  ],
                )).paddingOnly(bottom: 10),

            //Task Steps
            CardWidget(
              contentPadding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonText(
                    text: '${locale?.task} ${locale?.steps.toLowerCase()}',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 20),
                  showStep == false
                      ? SolidTextButton(
                          onTap: () => showStartStepDialog(onProceed: () {
                                setState(() => showStep = true);
                                Get.back();
                              }),
                          buttonText: '${locale?.startProcess}')
                      : Obx(
                          () => controller.taskModel.value?.task?.steps != null
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.taskModel.value!.task!.steps!.length,
                                  itemBuilder: (context, index) {
                                    final Steps step = controller.taskModel.value!.task!.steps![index];
                                    return Obx(() => StepTile(
                                          onPressed: () =>
                                              controller.stepActionOnTap(taskId: taskId, step: step, locale: locale),
                                          index: index,
                                          listLength: controller.taskModel.value!.task!.steps!.length,
                                          step: step,
                                          buttonLoading: controller.stepLoading.value,
                                          taskState: TaskStateEnum.defaultType,
                                        ));
                                  },
                                  separatorBuilder: (context, index) => const HeightBox(height: 10),
                                )
                              : NoDataFound(message: '${locale?.noStepsFound}'),
                        )
                ],
              ),
            )
          ],
        ),
      );
}
