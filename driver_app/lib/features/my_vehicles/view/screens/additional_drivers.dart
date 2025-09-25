import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/appbar_leading_icon.dart';
import '../../../../shared/widgets/empty_content_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../tiles/driver_tile.dart';

class AdditionalDrivers extends StatelessWidget {
  const AdditionalDrivers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBarLeadingIcon(),
        centerTitle: false,
        title: const ButtonText(
          text: 'Additional drivers',
          textColor: AppColors.lightAppBarIconColor,
        ),
        titleSpacing: 0.0,
      ),
      body: Column(
        children: [
          // All drivers
          HeaderWidget(
            title: 'All drivers',
            trailing: RichText(
              textAlign: TextAlign.end,
              text: const TextSpan(
                style: TextStyle(color: AppColors.lightSecondaryTextColor, fontSize: 12),
                children: [
                  TextSpan(
                    text: '0',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.lightTextColor),
                  ),
                  TextSpan(
                    text: ' /3',
                    style: TextStyle(color: AppColors.lightTextFieldHintColor),
                  ),
                  TextSpan(
                    text: '\nBalance',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ),
          ).paddingAll(16),

          // Driver List
          Expanded(
            child: 1 == 1
                ? ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    itemCount: 3,
                    separatorBuilder: (context, index) => const HeightBox(height: 10),
                    itemBuilder: (context, index) => const DriverTile(
                      awaiting: false,
                      verified: true,
                      fullAccess: false,
                    ),
                  )
                : const EmptyContentWidget(
                    title: 'Nothing to show here!',
                    subTitle:
                        'We don\'t have any information to display at the moment. You\'ll be notified if there are any developments',
                    svgAsset: Assets.assetsSvgSearch),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(onTap: () => Get.toNamed(RouterPaths.addDrivers), buttonText: 'Add drivers')
            .paddingSymmetric(horizontal: 16),
      ),
    );
  }
}
