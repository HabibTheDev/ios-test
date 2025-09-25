import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../tiles/report_issue_car_pick_tile.dart';

class ReportIssueCarPick extends StatelessWidget {
  const ReportIssueCarPick({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Create collision report',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //title
            const HeaderWidget(title: 'Pick a car').paddingOnly(left: 16, right: 16, top: 16),
            const SmallText(
              text: 'Choose your damaged car to report collision',
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(left: 16, right: 16, bottom: 4),

            Expanded(
                child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: 5,
              separatorBuilder: (context, index) => const HeightBox(height: 10),
              itemBuilder: (context, index) => ReportIssueCarPickTile(index: index),
            ))
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(onTap: () => Get.toNamed(RouterPaths.driverInfoSelection), buttonText: 'Select car')
            .paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
