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
import '../../controller/inspection_results_controller.dart';
import '../../model/inspection_result_model.dart';
import '../tiles/inspection_result_tile.dart';

class InspectionResults extends StatelessWidget {
  const InspectionResults({super.key});

  @override
  Widget build(BuildContext context) {
    final InspectionResultsController controller = Get.find();

    final locale = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.screenTerminationMsg, RouterPaths.vehicleCondition);
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
            child: SvgPicture.asset(Assets.assetsSvgCarSearch),
          ),
          title: ButtonText(text: '${locale?.inspectionResults}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => screenTerminationWarning(
                locale,
                locale?.screenTerminationMsg,
                RouterPaths.vehicleCondition,
              ),
              icon: const Icon(Icons.close),
            )
          ],
        ),
        body: _bodyUI(locale, controller),
        bottomNavigationBar: SafeArea(
          child: SolidTextButton(
            onTap: () {},
            buttonText: '${locale?.finish}',
            backgroundColor: 1 == 1 ? AppColors.disablePrimaryColor : null,
          ),
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _bodyUI(AppLocalizations? locale, InspectionResultsController controller) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.primaryColor.withAlpha(38),
              child: SvgPicture.asset(
                Assets.assetsSvgGeneralEngine,
                height: 20,
              ),
            ).paddingOnly(bottom: 10),

            // Title
            const TitleText(text: 'Engine'),

            // Question list
            ListView.separated(
              padding: const EdgeInsets.only(top: 40),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.inspectionResultList.length,
              separatorBuilder: (context, index) => const HeightBox(height: 10),
              itemBuilder: (context, index) {
                InspectionResultModel model = controller.inspectionResultList[index];
                return Obx(
                  () => InspectionResultTile(
                    onRadioValueChanged: (int? newValue) {
                      controller.questionRadioOnChanged(stepIndex: index, newRadioValue: newValue);
                    },
                    title: model.title,
                    radioGroupValue: model.answerRadioValue.value,
                    imageList: model.images.toList(),
                    onAddImage: (File imageFile) {
                      controller.addImage(stepIndex: index, imageFile: imageFile);
                    },
                    onDeleteImages: (List<int> selectedImageIndex) {
                      controller.deleteSelectedImages(stepIndex: index, selectedIndex: selectedImageIndex);
                    },
                    noteController: model.notes,
                  ),
                );
              },
            )
          ],
        ),
      );
}
