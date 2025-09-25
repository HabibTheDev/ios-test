import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inspection/view/tiles/ul_tile.dart';
import '../../controller/car_running_steps_controller.dart';
import '../../model/car_running_step_model.dart';
import '../tiles/add_image_widget.dart';
import '../tiles/question_tile.dart';

class CarRunningSteps extends StatelessWidget {
  const CarRunningSteps({super.key});

  @override
  Widget build(BuildContext context) {
    final CarRunningStepsController controller = Get.find();

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
            final int totalStep = controller.carRunningStepList.length;
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
            child: SolidTextButton(
              onTap: controller.nextButtonOnTap,
              buttonText: controller.currentPageIndex.value == 0 ? '${locale?.drivingComplete}' : '${locale?.finish}',
              backgroundColor: !controller.ableToGoNext.value ? AppColors.disablePrimaryColor : null,
            ),
          ),
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale, CarRunningStepsController controller) => PageView.builder(
        controller: controller.stepPageController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.carRunningStepList.length,
        onPageChanged: controller.onPageChange,
        itemBuilder: (context, stepIndex) {
          final CarRunningStepModel model = controller.carRunningStepList[stepIndex];
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primaryColor.withAlpha(38),
                  child: SvgPicture.asset(model.svgImagePath, height: 20),
                ).paddingOnly(bottom: 10),

                // Title
                TitleText(text: model.carRunningStep.value),

                // Instruction
                if (model.instructionList != null && model.instructionList!.isNotEmpty)
                  BorderCardWidget(
                    contentPadding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BodyText(
                          text: model.instructionTitle ?? '',
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.lightSecondaryTextColor,
                        ),
                        ListView.separated(
                          padding: const EdgeInsets.only(top: 16),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.instructionList!.length,
                          separatorBuilder: (context, quesIndex) => const HeightBox(height: 10),
                          itemBuilder: (context, index) => UlTile(title: model.instructionList![index]),
                        ),
                      ],
                    ),
                  ).paddingOnly(top: 40),

                // Question list
                if (model.questions.isNotEmpty)
                  ListView.separated(
                    padding: const EdgeInsets.only(top: 40),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: model.questions.length,
                    separatorBuilder: (context, quesIndex) => const HeightBox(height: 10),
                    itemBuilder: (context, quesIndex) {
                      final CarRunningStepQuestionModel question = model.questions[quesIndex];
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
                if (model.questions.isNotEmpty) const AppDivider(height: 40),

                // Images
                if (model.images.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: BodyText(
                      text: '${locale?.addImages} (${locale?.optional})',
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.bold,
                      textColor: AppColors.lightSecondaryTextColor,
                    ),
                  ).paddingOnly(bottom: 16),
                if (model.images.isNotEmpty)
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
                if (model.instructionTitle == null)
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
