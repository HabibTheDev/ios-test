part of 'widget_imports.dart';

class RegularDamageWidget extends StatefulWidget {
  const RegularDamageWidget({
    super.key,
    required this.onComplete,
    required this.step,
    required this.regularMaintenanceType,
  });
  final Function(bool) onComplete;
  final Steps? step;
  final String? regularMaintenanceType;

  @override
  State<RegularDamageWidget> createState() => _RegularDamageWidgetState();
}

class _RegularDamageWidgetState extends State<RegularDamageWidget> {
  late MaintenanceController controller;
  final maintenanceCost = TextEditingController();
  final maintenanceCostFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller = Get.find();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return GestureDetector(
      onTap: hideKeyboard,
      child: SafeArea(
        child: Form(
          key: maintenanceCostFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    TextFormFieldWithLabel(
                      controller: maintenanceCost,
                      hintText: '${locale?.enterExpanse}',
                      labelText: '${locale?.maintenanceCost}',
                      required: true,
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ).paddingOnly(top: 20, bottom: 20),
                    BodyText(
                      text: '${locale?.maintenanceReceipt}',
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 16),
                    InkWell(
                      onTap: () => controller.selectFileOnTap(),
                      child: Obx(() {
                        return controller.selectedFileSize.value != null
                            ? DocumentTile(
                                fileName: controller.selectedFile.value!.path.split('/').last,
                                fileSizeInMB: controller.selectedFileSize.value ?? 0,
                                onClose: () => controller.removeSelectFile(),
                              ).paddingOnly(bottom: 16)
                            : DottedBorder(
                                options: RoundedRectDottedBorderOptions(
                                  dashPattern: const [8],
                                  radius: const Radius.circular(8),
                                  color: AppColors.lightTextFieldHintColor,
                                ),
                                child: Container(
                                  height: 120,
                                  width: double.infinity,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: AppColors.lightCardColor,
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.file_upload_outlined, color: AppColors.primaryColor, size: 24),
                                      BodyText(
                                        text: '${locale?.selectFile}',
                                        textColor: AppColors.primaryColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      const SmallText(
                                        text: 'JPEG, PNG, PDF. Max size limit 3 MB',
                                        textColor: AppColors.lightSecondaryTextColor,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                      }),
                    ).paddingOnly(bottom: 20),

                    // Checklist
                    BodyText(
                      text:
                          '${widget.regularMaintenanceType == RegularMaintenanceType.regular.value ? locale?.selectServicedAreas : locale?.selectRepairedDamages}',
                      fontWeight: FontWeight.w600,
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 10),

                    widget.regularMaintenanceType == RegularMaintenanceType.regular.value
                        ? RegularServicingChecklistWidget(
                            regularServicingChecklist:
                                controller.taskModel.value?.task?.requestMaintenance?.regularRepairCheck ?? [],
                            onSelectionChanged: controller.serviceAreaOnChange,
                          )
                        : DamageRepairingChecklistWidget(
                            damageList: controller.taskModel.value?.task?.requestMaintenance?.repairDamage ?? [],
                            onSelectionChanged: controller.bodyDamageOnChange,
                          ),
                  ],
                ),
              ),
              const AppDivider(),

              // Button
              Row(
                children: [
                  Expanded(
                    child: OutlineTextButton(buttonText: '${locale?.cancel}', onTap: () => Get.back()),
                  ),
                  const WidthBox(width: 8),
                  Expanded(
                    child: Obx(
                      () => SolidTextButton(
                        buttonText: '${locale?.done}',
                        isLoading: controller.provideInfoLoading.value,
                        onTap: () async {
                          if (maintenanceCostFormKey.currentState!.validate()) {
                            final result = await controller.provideInfo(
                              step: widget.step,
                              maintenanceExpense: maintenanceCost.text,
                              locale: locale,
                              regularMaintenanceType: widget.regularMaintenanceType,
                            );
                            if (result) widget.onComplete(true);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ).paddingSymmetric(horizontal: 16, vertical: 16),
            ],
          ),
        ),
      ),
    );
  }
}
