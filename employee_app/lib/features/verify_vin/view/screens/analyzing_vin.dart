import 'package:flutter/material.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../shared/utils/app_toast.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../../inspection/model/inspection_arguments_model.dart';

class AnalyzingVin extends StatelessWidget {
  const AnalyzingVin({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    // Retrieve arguments
    final InspectionArgumentsModel? inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          screenTerminationWarning(locale, locale?.screenTerminationMsg, inspectionArgumentsModel?.returnScreen);
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
            child: SvgPicture.asset(Assets.assetsSvgGeneralVin),
          ),
          title: ButtonText(text: '${locale?.verifyVin}'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                screenTerminationWarning(locale, locale?.screenTerminationMsg, inspectionArgumentsModel?.returnScreen);
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        body: _bodyUI(locale: locale),
      ),
    );
  }

  Widget _bodyUI({required AppLocalizations? locale}) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(Assets.assetsGifProcessingImage, height: 140).paddingOnly(bottom: 40, top: 100),
          TitleText(text: '${locale?.analyzingVin}').paddingOnly(bottom: 10),
          SmallText(text: '${locale?.analyzingVinMsg}', textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}
