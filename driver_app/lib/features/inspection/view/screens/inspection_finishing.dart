import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/inspection_finishing_controller.dart';
import '../../model/finishing_doc_model.dart';
import '../widgets/finishing_doc_checkbox_widget.dart';

class InspectionFinishing extends StatelessWidget {
  const InspectionFinishing({super.key});

  @override
  Widget build(BuildContext context) {
    final InspectionFinishingController controller = Get.find();
    final title = Get.arguments?[ArgumentsKey.title] ?? 'Processing images';
    final issueTitle = Get.arguments?[ArgumentsKey.issueTitle];
    final returnScreen = Get.arguments?[ArgumentsKey.returnScreen] ?? RouterPaths.drawer;
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Report an issue',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0.8,
      progressColor: AppColors.inProgressColor,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: _bodyUI(controller, context),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlineTextButton(onTap: () => Get.back(), buttonText: 'Previous'),
            ),
            const WidthBox(width: 6),
            Expanded(
              child: SolidTextButton(
                  onTap: () {
                    Get.toNamed(
                      RouterPaths.inspectionReport,
                      arguments: {
                        ArgumentsKey.title: title,
                        ArgumentsKey.issueTitle: issueTitle,
                        ArgumentsKey.returnScreen: returnScreen,
                      },
                    );
                  },
                  buttonText: 'Next'),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI(InspectionFinishingController controller, BuildContext context) => SafeArea(
          child: ListView(padding: const EdgeInsets.all(16), children: [
        // Car details
        const BasicCarDetailsWidget(make: 'Lamborghini', model: 'Gallardo', year: 2022)
            .paddingOnly(top: 24, bottom: 32),

        // How did it happen?
        const TitleText(text: 'Finishing up').paddingOnly(bottom: 20),
        const SmallText(
          text: 'Want to add anything else? (optional)',
          fontWeight: FontWeight.w700,
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 10),
        FinishingDocCheckboxWidget(
          finishingDocsList: FinishingDocModel.list,
          onSelectionChanged: (value) {},
        )
      ]));
}
