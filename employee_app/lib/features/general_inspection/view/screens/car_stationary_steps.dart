import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/car_stationary_steps_controller.dart';
import '../../model/car_stationary_step_model.dart';
import '../tiles/add_image_widget.dart';
import '../tiles/question_tile.dart';

class CarStationarySteps extends StatelessWidget {
  const CarStationarySteps({super.key});

  @override
  Widget build(BuildContext context) {
    final CarStationaryStepsController controller = Get.find();

    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.screenTerminationMsg, RouterPaths.vehiclePerformance);
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
          title: Obx(() {
            final int currentStep = controller.currentPageIndex.value + 1;
            final int totalStep = controller.carStationaryStepList.length;
            return ButtonText(text: '${locale?.step} $currentStep/$totalStep');
          }),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => screenTerminationWarning(
                locale,
                locale?.screenTerminationMsg,
                RouterPaths.vehiclePerformance,
              ),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: _bodyUI(locale, controller),
        bottomNavigationBar: Obx(
          () => SafeArea(
            child: controller.currentPageIndex.value == 0
                ? SolidTextButton(
                    onTap: controller.nextButtonOnTap,
                    buttonText: '${locale?.next}',
                    backgroundColor: !controller.ableToGoNext.value ? AppColors.disablePrimaryColor : null,
                  )
                : Row(
                    children: [
                      Expanded(
                        child: OutlineTextButton(
                          onTap: controller.previousButtonOnTap,
                          buttonText: '${locale?.previous}',
                        ),
                      ),
                      const WidthBox(width: 6),
                      Expanded(
                        child: SolidTextButton(
                          onTap: controller.nextButtonOnTap,
                          buttonText: '${locale?.next}',
                          backgroundColor: !controller.ableToGoNext.value ? AppColors.disablePrimaryColor : null,
                        ),
                      ),
                    ],
                  ),
          ),
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale, CarStationaryStepsController controller) => PageView.builder(
        controller: controller.stepPageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.carStationaryStepList.length,
        onPageChanged: controller.onPageChange,
        itemBuilder: (context, stepIndex) {
          final CarStationaryStepModel model = controller.carStationaryStepList[stepIndex];
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //Icon
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primaryColor.withAlpha(38),
                  child: SvgPicture.asset(
                    model.svgImagePath,
                    height: 20,
                  ),
                ).paddingOnly(bottom: 10),

                //Title
                TitleText(text: model.carStationaryStep.value),

                // Question list
                ListView.separated(
                  padding: const EdgeInsets.only(top: 40),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model.questions.length,
                  separatorBuilder: (context, quesIndex) => const HeightBox(height: 10),
                  itemBuilder: (context, quesIndex) {
                    final CarStationaryStepQuestionModel question = model.questions[quesIndex];
                    return Obx(
                      () => QuestionTile(
                        serialNo: quesIndex + 1,
                        question: question.question,
                        groupValue: question.answerRadioValue.value,
                        onChanged: (int? newValue) {
                          controller.questionRadioOnChanged(
                            stepIndex: stepIndex,
                            quesIndex: quesIndex,
                            newRadioValue: newValue,
                          );
                        },
                      ),
                    );
                  },
                ),
                const AppDivider(height: 40),

                // Images
                SizedBox(
                  width: double.infinity,
                  child: BodyText(
                    text: '${locale?.addImages} (${locale?.optional})',
                    textAlign: TextAlign.start,
                    fontWeight: FontWeight.bold,
                    textColor: AppColors.lightSecondaryTextColor,
                  ),
                ).paddingOnly(bottom: 16),
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    child: AddImageWidget(
                      imageList: model.images.toList(),
                      onDelete: (List<int> selectedIndex) {
                        controller.deleteSelectedImages(stepIndex: stepIndex, selectedIndex: selectedIndex);
                      },
                      onAddImage: (File imageFile) {
                        controller.addImage(stepIndex: stepIndex, imageFile: imageFile);
                      },
                    ),
                  ),
                ).paddingOnly(bottom: 28),

                // Notes
                TextFormFieldWithLabel(
                  controller: model.notes,
                  labelText: '${locale?.notes} (${locale?.optional})',
                  hintText: '${locale?.writeHere}',
                  textCapitalization: TextCapitalization.sentences,
                  minLine: 5,
                  maxLine: 10,
                )
              ],
            ),
          );
        },
      );
}
