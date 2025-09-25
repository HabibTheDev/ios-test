import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/widget_imports.dart';
import '../../model/inspection_arguments_model.dart';
import '../tiles/ul_tile.dart';

class CarExteriorCaptureInstruction extends StatelessWidget {
  const CarExteriorCaptureInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context);
    final InspectionArgumentsModel? inspectionArgumentsModel = Get.arguments?[ArgumentsKey.inspectionArgumentsModel];
    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: CircleAvatar(
          radius: 12,
          backgroundColor: Colors.transparent,
          child: SvgPicture.asset(Assets.assetsSvgGeneralFlag),
        ),
        title: ButtonText(text: '${locale?.step} 1/3'),
        titleSpacing: 0.0,
        actions: [
          IconButton(
            onPressed: () => Get.until((route) => route.settings.name == inspectionArgumentsModel?.returnScreen),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: _bodyUI(locale, inspectionArgumentsModel),
    );
  }

  Widget _bodyUI(AppLocalizations? locale, InspectionArgumentsModel? inspectionArgumentsModel) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(Assets.assetsGifVideoInstruction, height: 160, width: double.infinity),
        const HeightBox(height: 20),

        Center(child: TitleText(text: '${locale?.captureExteriorImages}').paddingOnly(bottom: 16)),

        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.lightBorderColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(
                text: '${locale?.steps}',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.bold,
              ).paddingOnly(bottom: 16),

              // Instructions
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: AppList.inspectionInstructionList.length,
                separatorBuilder: (context, index) => const HeightBox(height: 10),
                itemBuilder: (context, index) => UlTile(title: AppList.inspectionInstructionList[index]),
              ),
            ],
          ),
        ).paddingOnly(bottom: 16),

        Row(
          children: [
            // Previous button
            Expanded(
              child: OutlineTextButton(onTap: () => Get.back(), buttonText: '${locale?.previous}'),
            ),
            const WidthBox(width: 6),
            // Start capturing button
            Expanded(
              child: SolidTextButton(
                onTap: () {
                  Get.toNamed(
                    RouterPaths.captureInspectionImage,
                    arguments: {ArgumentsKey.inspectionArgumentsModel: inspectionArgumentsModel},
                  );
                },
                buttonText: '${locale?.startCapturing}',
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
