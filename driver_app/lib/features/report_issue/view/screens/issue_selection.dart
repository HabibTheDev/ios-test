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
import '../../controller/issue_selection_controller.dart';
import '../../model/issue_model.dart';
import '../widgets/issue_radio_widget.dart';

class IssueSelection extends StatelessWidget {
  const IssueSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final IssueSelectionController controller = Get.find();
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Report an issue',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0.1,
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
              child: SolidTextButton(onTap: () => controller.nextButtonOnTap(), buttonText: 'Next'),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI(IssueSelectionController controller) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Car details
            const BasicCarDetailsWidget(make: 'Lamborghini', model: 'Gallardo', year: 2022)
                .paddingOnly(top: 24, bottom: 32),

            // Issue
            const TitleText(text: 'What happened?').paddingOnly(bottom: 20),
            const SmallText(
              text: 'Select issue',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),

            // Issue radio widget
            IssueRadioWidget(
              issueList: IssueModel.issueRadioList,
              onChanged: controller.changeIssue,
            ),
          ],
        ),
      );
}
