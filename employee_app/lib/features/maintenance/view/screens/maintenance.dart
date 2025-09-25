import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/router/router_paths.dart';
import '../../../../shared/extensions/string_extension.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/model/single_task/steps_model.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/enums/enums.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../../shared/tiles/step_tile.dart';
import '../../../more/view/widgets/widget_imports.dart';
import '../../controller/maintenance_controller.dart';
import '../widgets/damage_repairing_checklist_widget.dart';
import '../widgets/regular_servicing_checklist_widget.dart';
import '../widgets/widget_imports.dart';

class Maintenance extends StatefulWidget {
  const Maintenance({super.key});

  @override
  State<Maintenance> createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  late MaintenanceController controller;
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
        title: controller.taskModel.value?.task?.state?.toCapitalized() ?? '${locale?.notAvailable}',
        subTitle: controller.taskModel.value?.task?.type?.toCapitalized() ?? '${locale?.notAvailable}',
        progressValue:
            controller.taskModel.value != null ? (controller.taskModel.value?.task?.completionRate ?? 0) / 100 : 0.0,
        body: controller.isLoading.value ? const CenterLoadingWidget() : _bodyUI(locale),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale) => ListRefreshIndicator(
        onRefresh: () async => await controller.fetchSingleTask(taskId: taskId),
        child: ListView(
          padding: const EdgeInsets.all(16),
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            MaintenanceCarDetailsWidget(taskModel: controller.taskModel.value),

            // Customer Info
            if (controller.taskModel.value?.task?.type != TaskTypeEnum.regular.value)
              UserInfoWidget(
                header: '${locale?.customer}',
                name: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.name,
                imageUrl: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.images,
                phone: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.phone,
                email: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.email,
                address: controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.address,
                verified:
                    controller.taskModel.value?.task?.cusotmerBrandCatalogue?.customer?.user?.isConfirmed ?? false,
              ).paddingOnly(bottom: 10),

            // Checklist
            if (controller.taskModel.value?.task?.type == TaskTypeEnum.regular.value &&
                    controller.taskModel.value?.task?.requestMaintenance?.repairDamage != null ||
                controller.taskModel.value?.task?.requestMaintenance?.regularRepairCheck != null)
              CardWidget(
                contentPadding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ButtonText(
                      text: '${locale?.checklist}',
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 20),

                    // Checklist (Damage repairing)
                    Obx(() => controller.taskModel.value?.task?.requestMaintenance?.maintanainanceType ==
                            RegularMaintenanceType.damage.value
                        ? DamageRepairingChecklistWidget(
                            damageList: controller.taskModel.value?.task?.requestMaintenance?.repairDamage ?? [])
                        : const SizedBox.shrink()),

                    // Checklist (Regular servicing)
                    Obx(() => controller.taskModel.value?.task?.requestMaintenance?.maintanainanceType ==
                            RegularMaintenanceType.regular.value
                        ? RegularServicingChecklistWidget(
                            regularServicingChecklist:
                                controller.taskModel.value?.task?.requestMaintenance?.regularRepairCheck ?? [])
                        : const SizedBox.shrink())
                  ],
                ),
              ).paddingOnly(bottom: 10),

            // Maintenance Steps
            CardWidget(
              contentPadding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonText(
                    text: '${locale?.maintenance} ${locale?.steps.toLowerCase()}',
                    textColor: AppColors.lightSecondaryTextColor,
                  ).paddingOnly(bottom: 20),
                  showStep == false
                      ? SolidTextButton(
                          onTap: () => showStartStepDialog(onProceed: () {
                            setState(() => showStep = true);
                            Get.back();
                          }),
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
                                        index: index,
                                        listLength: controller.taskModel.value!.task!.steps!.length,
                                        step: step,
                                        buttonLoading: controller.stepLoading.value,
                                        taskState: TaskStateEnum.maintenance,
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
