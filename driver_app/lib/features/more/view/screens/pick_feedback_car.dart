import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/widgets/header_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../tiles/feedback_car_pick_tile.dart';

class PickFeedbackCar extends StatelessWidget {
  const PickFeedbackCar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          leading: const Icon(Icons.reviews,
              size: 20, color: AppColors.lightAppBarIconColor),
          title: const ButtonText(text: 'Give feedback'),
          titleSpacing: 0.0,
          actions: [
            IconButton(
                onPressed: () => Get.back(), icon: const Icon(Icons.close))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const HeaderWidget(title: 'Pick a car')
                .paddingOnly(left: 16, right: 16, top: 16),
            const SmallText(
              text: 'Pick a car to share your feedback',
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(left: 16, right: 16, bottom: 4),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 10,
                separatorBuilder: (context, index) =>
                    const HeightBox(height: 10),
                itemBuilder: (context, index) =>
                    FeedbackCarPickTile(index: index),
              ),
            )
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: SolidTextButton(
                  onTap: () => Get.toNamed(RouterPaths.giveFeedback),
                  buttonText: 'Continue')
              .paddingSymmetric(horizontal: 16),
        ));
  }
}
