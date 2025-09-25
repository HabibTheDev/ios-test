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
import '../tiles/feedback_tile.dart';

class MyFeedbacks extends StatelessWidget {
  const MyFeedbacks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const AppBarLeadingIcon(),
          centerTitle: false,
          title: const ButtonText(
            text: 'My feedbacks',
            textColor: AppColors.lightAppBarIconColor,
          ),
          titleSpacing: 0.0,
        ),
        body: 1 != 1
            ? const EmptyContentWidget(
                title: 'Nothing to show here!',
                subTitle:
                    'We don\'t have any information to display at the moment. You\'ll be notified if there are any developments',
                svgAsset: Assets.assetsSvgSearch,
              )
            : Column(
                children: [
                  //title
                  const HeaderWidget(title: 'All feedbacks').paddingOnly(left: 16, right: 16, top: 16),

                  Expanded(
                      child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: 10,
                    separatorBuilder: (context, index) => const HeightBox(height: 10),
                    itemBuilder: (context, index) => const FeedbackTile(),
                  ))
                ],
              ),
        bottomNavigationBar: SafeArea(
          child: SolidTextButton(onTap: () => Get.toNamed(RouterPaths.pickFeedbackCar), buttonText: 'Give feedback')
              .paddingSymmetric(horizontal: 16),
        ));
  }
}
