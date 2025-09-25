import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../model/anybody_hurt_model.dart';
import '../../model/driver_info_model.dart';
import '../widgets/anybody_hurt_radio_widget.dart';
import '../widgets/driver_info_radio_widget.dart';

class DriverInfoSelection extends StatelessWidget {
  const DriverInfoSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Report condition',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0.05,
      progressColor: AppColors.inProgressColor,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: _bodyUI(),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlineTextButton(onTap: () => Get.back(), buttonText: 'Change car'),
            ),
            const WidthBox(width: 6),
            Expanded(
              child: SolidTextButton(onTap: () => Get.toNamed(RouterPaths.issueSelection), buttonText: 'Next'),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI() => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Car details
            const BasicCarDetailsWidget(make: 'Lamborghini', model: 'Gallardo', year: 2022)
                .paddingOnly(top: 24, bottom: 32),

            // Driver info
            const TitleText(text: 'Driver info').paddingOnly(bottom: 20),
            const SmallText(
              text: 'Who was driving?',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),

            // Driver radio widget
            DriverInfoRadioWidget(
              driverInfoList: DriverInfoModel.driverRadioList,
              onChanged: (DriverInfoModel value) {},
            ),

            const AppDivider(height: 20),

            // Was anybody hurt?
            const SmallText(
              text: 'Was anybody hurt?',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),
            AnybodyHurtRadioWidget(
              anybodyHurtList: AnybodyHurtModel.anybodyHurtRadioList,
              onChanged: (AnybodyHurtModel value) {},
            )
          ],
        ),
      );
}
