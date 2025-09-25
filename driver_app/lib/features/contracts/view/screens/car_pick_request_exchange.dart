import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../../more/view/tiles/feedback_car_pick_tile.dart';
import '../../controller/request_exchange_controller.dart';

class CarPickRequestExchange extends StatelessWidget {
  const CarPickRequestExchange({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestExchangeController controller = Get.find();
    return CheckoutAppScaffold(
      title: 'Request exchange',
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.swap_horizontal_circle_outlined,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: _bodyUI(context, controller),
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.contractDetails),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(
                onTap: () => Get.toNamed(RouterPaths.requestExchange, arguments: {'hasCar': true}),
                buttonText: 'Choose')
            .paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI(BuildContext context, RequestExchangeController controller) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const HeaderWidget(title: 'Pick a car'),
          const SmallText(
            text: 'Choose your preferred car from the available car list',
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),
          CardWidget(
            contentPadding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    Assets.assetsImageNoCar,
                    height: 60,
                    fit: BoxFit.fitHeight,
                  ),
                ).paddingOnly(bottom: 10),
                const TitleText(
                  text: 'Can\'t find your ride?',
                ),
                const SmallText(
                  text: 'Let admin suggest some available cars for you.',
                  textColor: AppColors.lightSecondaryTextColor,
                ).paddingOnly(bottom: 10),
                OutlineTextButton(
                  onTap: () {
                    Get.toNamed(RouterPaths.requestExchange, arguments: {'hasCar': false});
                  },
                  buttonText: 'Continue',
                  primaryColor: AppColors.primaryColor,
                )
              ],
            ),
          ).paddingOnly(bottom: 24),

          // Available cars
          const SmallText(
            text: 'Available cars',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            separatorBuilder: (context, index) => const HeightBox(height: 10),
            itemBuilder: (context, index) => FeedbackCarPickTile(
              index: index,
              showContractId: false,
            ),
          ),
        ],
      );
}
