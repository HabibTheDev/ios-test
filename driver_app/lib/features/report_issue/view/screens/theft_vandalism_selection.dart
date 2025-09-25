import 'package:driver_app/core/constants/arguments_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/theft_vandalism_controller.dart';
import '../../model/theft_vandalism_model.dart';
import '../widgets/theft_vandalism_radio_widget.dart';

class TheftVandalismSelection extends StatelessWidget {
  const TheftVandalismSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final TheftVandalismController controller = Get.find();
    final issueTitle = Get.arguments?[ArgumentsKey.issueTitle];
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Report an issue',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0.15,
      progressColor: AppColors.inProgressColor,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: _bodyUI(controller),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlineTextButton(onTap: () => Get.back(), buttonText: 'Previous'),
            ),
            const WidthBox(width: 6),
            Expanded(
              child: SolidTextButton(
                  onTap: () =>
                      Get.toNamed(RouterPaths.basicInquirySelection, arguments: {ArgumentsKey.issueTitle: issueTitle}),
                  buttonText: 'Next'),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI(TheftVandalismController controller) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Car details
            const BasicCarDetailsWidget(make: 'Lamborghini', model: 'Gallardo', year: 2022)
                .paddingOnly(top: 24, bottom: 32),

            // What happened to the vehicle?
            const TitleText(text: 'What happened to the vehicle?').paddingOnly(bottom: 20),
            const SmallText(
              text: 'Choose the option that best fits the situation',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),

            // Issue radio widget
            TheftVandalismRadioWidget(
              issueList: TheftVandalismModel.issueRadioList,
              onChanged: controller.changeIssue,
            ),
          ],
        ),
      );
}
