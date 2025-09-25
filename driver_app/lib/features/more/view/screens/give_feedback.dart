import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../controller/feedback_controller.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';

class GiveFeedback extends StatelessWidget {
  const GiveFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final FeedbackController controller = Get.find();

    return Scaffold(
      backgroundColor: AppColors.lightCardColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: const Icon(Icons.reviews,
            size: 20, color: AppColors.lightAppBarIconColor),
        title: const ButtonText(text: 'Give feedback'),
        titleSpacing: 0.0,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.close))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.fire_truck_rounded,
                      color: AppColors.lightSecondaryTextColor.withOpacity(0.5),
                      size: 30,
                    ),
                  ),
                  Expanded(
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyText(
                          text: 'Lemborghini',
                          fontWeight: FontWeight.bold,
                        ),
                        SmallText(
                          text: 'Gallardo 2022',
                          textColor: AppColors.lightSecondaryTextColor,
                          textSize: 10,
                        ),
                      ],
                    ).paddingOnly(left: 8),
                  )
                ],
              ).paddingOnly(bottom: 8),
              const CarInfoTile(titleKey: 'Contract ID', titleValue: '#ID20034')
                  .paddingOnly(bottom: 20),

              //Brand & Logo
              const BasicCarDetailsWidget().paddingOnly(bottom: 10),
              const AppDivider(height: 28),

              const SmallText(
                text: 'Rate your satisfaction',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.bold,
              ).paddingOnly(bottom: 16),

              Center(
                child: RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  glowColor: AppColors.lightStartColor.withOpacity(0.4),
                  unratedColor: AppColors.lightTextFieldHintColor,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, _) => const Icon(
                    CupertinoIcons.star_fill,
                    color: AppColors.lightStartColor,
                  ),
                  onRatingUpdate: (rating) {
                    debugPrint(rating.toString());
                  },
                ),
              ).paddingOnly(bottom: 30),

              const SmallText(
                text: 'Share your thoughts',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.bold,
              ).paddingOnly(bottom: 8),

              TextFormFieldWidget(
                controller: TextEditingController(),
                hintText: 'Type here',
                minLine: 5,
                maxLine: 10,
              ).paddingOnly(bottom: 20),

              const SmallText(
                text: 'Would you recommend us?',
                textColor: AppColors.lightSecondaryTextColor,
                fontWeight: FontWeight.w600,
              ).paddingOnly(bottom: 8),
              Obx(
                () => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BorderCardWidget(
                      child: RadioListTile<bool>(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        title: const BodyText(text: 'Yes'),
                        value: true,
                        groupValue: controller.selectedRadioValue.value,
                        onChanged: controller.onChanged,
                      ),
                    ).paddingOnly(bottom: 10),
                    BorderCardWidget(
                      child: RadioListTile<bool>(
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: const BodyText(text: 'No'),
                        visualDensity: VisualDensity.compact,
                        value: false,
                        groupValue: controller.selectedRadioValue.value,
                        onChanged: controller.onChanged,
                      ),
                    ),
                  ],
                ),
              ).paddingOnly(bottom: 16),

              SolidTextButton(
                      onTap: () => Get.toNamed(RouterPaths.giveFeedback),
                      buttonText: 'Submit')
                  .paddingOnly(bottom: 16),
            ],
          ),
        ),
      ),
    );
  }
}
