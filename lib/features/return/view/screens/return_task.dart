import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../shared/extensions/string_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/model/single_task/steps_model.dart';
import '../../../../shared/tiles/step_tile.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../more/view/widgets/widget_imports.dart';
import '../../controller/return_controller.dart';
import '../widgets/return_car_details_widget.dart';

class ReturnTask extends StatefulWidget {
  const ReturnTask({super.key});

  @override
  State<ReturnTask> createState() => _ReturnTaskState();
}

class _ReturnTaskState extends State<ReturnTask> {
  late ReturnController controller;
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
    return Obx(
      () => ProgressBarScaffold(
        title: controller.taskModel.value?.task?.state?.toCapitalized() ?? '',
        subTitle: controller.taskModel.value?.task?.type?.toCapitalized() ?? '',
        progressValue:
            controller.taskModel.value != null ? (controller.taskModel.value?.task?.completionRate ?? 0) / 100 : 0.0,
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
            ReturnCarDetailsWidget(taskModel: controller.taskModel.value),

            // Customer Info
            UserInfoWidget(
              header: '${locale?.customer}',
              name: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.name,
              imageUrl: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.images,
              phone: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.phone,
              email: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.email,
              address: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.address,
              verified: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.user?.isConfirmed ?? false,
            ).paddingOnly(bottom: 10),

            // Return Steps
            CardWidget(
              contentPadding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonText(
                    text:
                        '${controller.taskModel.value?.task?.type?.toCapitalized() ?? ''} ${locale?.steps.toLowerCase()}',
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
                                    return Obx(
                                      () => StepTile(
                                        onPressed: () => controller.stepActionOnTap(step: step, locale: locale),
                                        carDirectionOnTap: () {
                                          final latitude = controller.taskModel.value?.task?.location?.latitude;
                                          final longitude = controller.taskModel.value?.task?.location?.longitude;
                                          final destinationAddress =
                                              controller.taskModel.value?.task?.location?.locationName;
                                          if (latitude == null || longitude == null) {
                                            showToast('${locale?.addressNotFound}');
                                            return;
                                          }
                                          Get.toNamed(RouterPaths.carDirection, arguments: {
                                            ArgumentsKey.latitude: latitude,
                                            ArgumentsKey.longitude: longitude,
                                            ArgumentsKey.destinationAddress: destinationAddress,
                                          });
                                        },
                                        buttonLoading: controller.stepLoading.value,
                                        index: index,
                                        listLength: controller.taskModel.value!.task!.steps!.length,
                                        step: controller.taskModel.value!.task!.steps![index],
                                        taskState: TaskStateEnum.returnTask,
                                      ),
                                    );
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
