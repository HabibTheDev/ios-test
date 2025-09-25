import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../controller/inspection_capture_controller.dart';
import '../../model/inspection_arguments_model.dart';
import '../tiles/inspection_type_tile.dart';

class InspectionCaptureType extends StatelessWidget {
  const InspectionCaptureType({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final InspectionCaptureController controller = Get.find();

    // Retrieve arguments
    final InspectionArgumentsModel? inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];
    debugPrint(inspectionArgumentsModel.toString());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.inspectionTerminationMgs, inspectionArgumentsModel?.returnScreen);
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
          title: ButtonText(text: inspectionArgumentsModel?.title ?? '${locale?.notAvailable}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () => screenTerminationWarning(
                locale,
                locale?.inspectionTerminationMgs,
                inspectionArgumentsModel?.returnScreen,
              ),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: _bodyUI(inspectionArgumentsModel: inspectionArgumentsModel, controller: controller, locale: locale),
        bottomNavigationBar: SafeArea(
          child: Obx(
            () => SolidTextButton(
              onTap: () {
                if (controller.disableFinishButton.value) return;
                _finishButtonWarning(
                  inspectionArgumentsModel: inspectionArgumentsModel,
                  controller: controller,
                  locale: locale,
                  context: context,
                );
              },
              buttonText: '${locale?.finish}',
              isLoading: controller.finishLoading.value,
              backgroundColor: controller.disableFinishButton.value ? AppColors.disablePrimaryColor : null,
            ),
          ),
        ).paddingSymmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  Widget _bodyUI({
    required InspectionArgumentsModel? inspectionArgumentsModel,
    required InspectionCaptureController controller,
    required AppLocalizations? locale,
  }) => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Capture the followings
      TitleText(text: '${locale?.captureTheFollowings}').paddingOnly(bottom: 32),

      // Capture type list
      Expanded(
        child: Obx(
          () => ListView.separated(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: controller.inspectionCaptureTypeList.length,
            separatorBuilder: (context, index) => const AppDivider(),
            itemBuilder: (context, index) => InspectionTypeTile(
              model: controller.inspectionCaptureTypeList[index],
              inspectionArgumentsModel: inspectionArgumentsModel,
            ),
          ),
        ),
      ),
    ],
  ).paddingAll(16);

  void _finishButtonWarning({
    required InspectionArgumentsModel? inspectionArgumentsModel,
    required InspectionCaptureController controller,
    required AppLocalizations? locale,
    required BuildContext context,
  }) {
    showDialog(
      barrierDismissible: false,
      context: Get.key.currentState!.context,
      builder: (_) => AppAlertDialog(
        iconData: Icons.info,
        title: locale?.areYouSure ?? '',
        message: locale?.reportFinishConfirmationMgs ?? '',
        primaryButtonText: locale?.ok ?? '',
        themeColor: AppColors.warningColor,
        buttonAction: () {
          Navigator.of(context).pop();
          controller.finishButtonOnTap(inspectionArgumentsModel: inspectionArgumentsModel);
        },
      ),
    );
  }
}
