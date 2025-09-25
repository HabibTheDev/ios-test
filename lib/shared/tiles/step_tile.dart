import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../shared/extensions/string_extension.dart';
import '../../core/constants/app_color.dart';
import '../model/single_task/steps_model.dart';
import '../enums/enums.dart';
import '../widgets/widget_imports.dart';

class StepTile extends StatelessWidget {
  const StepTile({
    super.key,
    required this.step,
    required this.index,
    required this.onPressed,
    this.carDirectionOnTap,
    required this.listLength,
    this.buttonLoading = false,
    required this.taskState,
  });
  final Steps step;
  final int index;
  final int listLength;
  final bool buttonLoading;
  final TaskStateEnum taskState;
  final Function() onPressed;
  final Function()? carDirectionOnTap;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color:
              step.status == TaskStepStatusEnum.awaiting.value ||
                  (step.status == TaskStepStatusEnum.pendingApproval.value && step.isLastStep == true)
              ? AppColors.primaryColor
              : AppColors.lightTextFieldFillColor,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              step.isCompleted! && step.status == TaskStepStatusEnum.completed.value
                  ? const Icon(Icons.check_circle, color: AppColors.primaryColor, size: 24).paddingOnly(right: 10)
                  : Container(
                      height: 20,
                      width: 20,
                      margin: const EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              step.status == TaskStepStatusEnum.awaiting.value ||
                                  (step.status == TaskStepStatusEnum.pendingApproval.value && step.isLastStep == true)
                              ? AppColors.primaryColor
                              : AppColors.lightTextFieldHintColor,
                          width: 1,
                        ),
                      ),
                      child: SmallText(
                        text: (index + 1).toString(),
                        textColor:
                            step.status == TaskStepStatusEnum.awaiting.value ||
                                (step.status == TaskStepStatusEnum.pendingApproval.value && step.isLastStep == true)
                            ? AppColors.primaryColor
                            : AppColors.lightTextFieldHintColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              BodyText(
                text: step.title ?? '${locale?.notAvailable}',
                fontWeight: FontWeight.w500,
                textColor:
                    step.status == TaskStepStatusEnum.awaiting.value && step.isCompleted == false ||
                        (step.status == TaskStepStatusEnum.pendingApproval.value && step.isLastStep == true)
                    ? AppColors.lightTextColor
                    : step.isCompleted == true
                    ? AppColors.lightSecondaryTextColor
                    : AppColors.lightTextFieldHintColor,
              ),
            ],
          ),
          if ((step.status == TaskStepStatusEnum.awaiting.value ||
                  (step.status == TaskStepStatusEnum.pendingApproval.value && step.isLastStep == true)) &&
              step.isCompleted == false)
            step.handledBy.isNotNull() && step.handledBy!.isNotEmpty
                ? InkWell(
                    onTap: () => showSigningCompleteDialog(onNext: onPressed, locale: locale),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const CircleAvatar(backgroundColor: AppColors.awaitingColor, radius: 3).paddingOnly(right: 4),
                        SmallText(
                          text: 'Awaiting customer ${taskState == TaskStateEnum.returnTask ? 'consent' : 'signing'}',
                          maxLine: 2,
                          fontWeight: FontWeight.w600,
                          textColor: AppColors.awaitingColor,
                        ),
                      ],
                    ).paddingOnly(top: 16, left: 30),
                  )
                : step.status == TaskStepStatusEnum.pendingApproval.value && step.isLastStep == true
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(backgroundColor: AppColors.awaitingColor, radius: 3),
                      SmallText(
                        text: ' ${locale?.awaitingForApproval}',
                        maxLine: 2,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.awaitingColor,
                      ),
                    ],
                  ).paddingOnly(top: 16)
                : SolidTextButton(
                    onTap: () {
                      if (index == (listLength - 1)) {
                        showCompleteTaskDialog(onComplete: onPressed, locale: locale);
                      } else {
                        showNextStepDialog(onNext: onPressed, locale: locale);
                      }
                    },
                    isLoading: buttonLoading,
                    buttonText: index == (listLength - 1)
                        ? '${locale?.finishAndEndProcess}'
                        : '${locale?.finishAndContinue}',
                  ).paddingOnly(top: 16),

          // Car Direction
          if (index == 0 &&
              !step.isCompleted! &&
              (taskState == TaskStateEnum.handover ||
                  taskState == TaskStateEnum.maintenance ||
                  taskState == TaskStateEnum.exchange ||
                  taskState == TaskStateEnum.returnTask ||
                  taskState == TaskStateEnum.entryInspection ||
                  taskState == TaskStateEnum.generalInspection))
            OutlineButton(
              onTap: carDirectionOnTap ?? () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.primaryColor, size: 18),
                  ButtonText(text: ' ${locale?.carDirection}', textColor: AppColors.primaryColor),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void showNextStepDialog({required Function() onNext, required AppLocalizations? locale}) {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.verified,
        title: '${locale?.goToNextStep}',
        message: '${locale?.goToNextStepMgs}',
        primaryButtonText: '${locale?.proceed}',
        themeColor: AppColors.lightDialogGreenColor,
        buttonAction: () {
          Get.back();
          onNext();
        },
      ),
    );
  }

  void showSigningCompleteDialog({required Function() onNext, required AppLocalizations? locale}) {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.receipt_long,
        title: '${locale?.signingComplete}',
        message: '${locale?.signingCompleteMgs}',
        primaryButtonText: '${locale?.proceed}',
        buttonAction: () {
          Get.back();
          onNext();
        },
      ),
    );
  }

  void showCompleteTaskDialog({required Function() onComplete, required AppLocalizations? locale}) {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.task_alt,
        title: '${locale?.completeTask}',
        message: '${locale?.completeTaskMgs}',
        primaryButtonText: '${locale?.proceed}',
        buttonAction: () {
          Get.back();
          onComplete();
        },
      ),
    );
  }
}
