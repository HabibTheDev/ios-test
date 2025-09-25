import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../../more/view/tiles/feedback_car_pick_tile.dart';
import '../../controller/schedule_exchange_controller.dart';

class ScheduleExchange extends StatelessWidget {
  const ScheduleExchange({super.key});

  @override
  Widget build(BuildContext context) {
    final ScheduleExchangeController controller = Get.find();
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Schedule exchange',
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.swap_horizontal_circle_outlined,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: SafeArea(child: _bodyUI(context, controller)),
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.requestMaintenanceExchange),
    );
  }

  Widget _bodyUI(BuildContext context, ScheduleExchangeController controller) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CarBrandDetailsWidget(
            title: 'Company exchange',
            subTitle: 'Delivery',
            leading: CircleAvatar(
              radius: 20,
              child: Icon(
                Icons.swap_horizontal_circle,
                size: 24,
                color: AppColors.primaryColor,
              ),
            ),
          ).paddingOnly(bottom: 20),
          const CarInfoTile(titleKey: 'Requested date', titleValue: '12 Sep 2023').paddingOnly(bottom: 4),
          const CarInfoTile(titleKey: 'Requested time', titleValue: '12:04 PM').paddingOnly(bottom: 30),

          // Select car
          const SmallText(
            text: 'Select car',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: 2,
            separatorBuilder: (context, index) => const HeightBox(height: 10),
            itemBuilder: (context, index) => FeedbackCarPickTile(
              index: index,
              showContractId: false,
              showBorder: true,
              showShadow: false,
            ),
          ),
          const AppDivider().paddingOnly(bottom: 16),

          const BodyText(
            text: 'Provide the followings:',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),

          // Note
          WarningNoteWidget(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightTextColor),
                children: [
                  TextSpan(text: 'An valet will '),
                  TextSpan(
                      text: 'deliver',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  TextSpan(text: ' the new car to your address and return the previous car.'),
                ],
              ),
            ),
          ).paddingOnly(bottom: 20),

          // Delivery Date time
          CardWidget(
            contentPadding: const EdgeInsets.all(16),
            backgroundColor: AppColors.lightBgColor,
            showShadow: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Delivery Date
                TextFormFieldWithLabel(
                  controller: controller.deliveryDateController,
                  labelText: 'Select Date',
                  hintText: 'Select date',
                  suffixIcon: Icons.calendar_month,
                  readOnly: true,
                  fillColor: AppColors.lightCardColor,
                  onTap: () {
                    controller.pickDateOnTap(context);
                  },
                ).paddingOnly(bottom: 16),

                // Delivery Time
                TextFormFieldWithLabel(
                  controller: controller.deliveryTimeController,
                  labelText: 'Select Time',
                  hintText: 'Select time',
                  suffixIcon: Icons.watch_later_rounded,
                  readOnly: true,
                  fillColor: AppColors.lightCardColor,
                  onTap: () {
                    controller.pickTimeOnTap(context);
                  },
                ).paddingOnly(bottom: 16),

                // Working hour
                const CarInfoTile(
                    leading: Icon(Icons.info, color: AppColors.primaryColor, size: 16),
                    titleKey: 'Working hour',
                    titleValue: '08:00 AM - 08:00 PM')
              ],
            ),
          ).paddingOnly(bottom: 16),

          const SmallText(
            text: 'Delivery address',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 5),
          TextFormFieldWidget(
            controller: controller.deliveryAddressController,
            hintText: 'Enter address',
            required: true,
            textCapitalization: TextCapitalization.sentences,
            textInputType: TextInputType.streetAddress,
          ).paddingOnly(bottom: 24),

          SolidTextButton(
                  onTap: () => Get.until((route) => route.settings.name == RouterPaths.requestMaintenanceExchange),
                  buttonText: 'Finish')
              .paddingOnly(bottom: 20),
        ],
      );
}
