import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/car_brand_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/schedule_maintenance_controller.dart';

class ScheduleMaintenance extends StatelessWidget {
  const ScheduleMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    final ScheduleMaintenanceController controller = Get.find();
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Schedule maintenance',
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.calendar_month_rounded,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: SafeArea(child: _bodyUI(context, controller)),
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.requestMaintenanceExchange),
    );
  }

  Widget _bodyUI(BuildContext context, ScheduleMaintenanceController controller) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Maintenance Type
          const CarBrandDetailsWidget(
                  leading: CircleAvatar(
                    radius: 20,
                    child: Icon(
                      Icons.handyman,
                      color: AppColors.primaryColor,
                      size: 24,
                    ),
                  ),
                  title: 'Damage repairing',
                  subTitle: 'Retrieve')
              .paddingOnly(bottom: 20),

          // Time & Date
          const CarInfoTile(titleKey: 'Requested date', titleValue: '12 Sep 2023').paddingOnly(bottom: 4),
          const CarInfoTile(titleKey: 'Requested time', titleValue: '12:04 PM').paddingOnly(bottom: 40),

          // Car details
          const BasicCarDetailsWidget(),
          const AppDivider(height: 30),

          // Provide the followings
          const BodyText(
            text: 'Provide the followings:',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),
          WarningNoteWidget(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightTextColor),
                children: [
                  TextSpan(text: 'An valet will '),
                  TextSpan(
                      text: 'retrieve',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  TextSpan(text: ' the car from your address and return the car to the garage.'),
                ],
              ),
            ),
          ).paddingOnly(bottom: 20),

          // Retrieve Date time
          CardWidget(
            contentPadding: const EdgeInsets.all(16),
            backgroundColor: AppColors.lightBgColor,
            showShadow: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Retrieve Date
                TextFormFieldWithLabel(
                  controller: controller.retrieveDateController,
                  labelText: 'Select Date',
                  hintText: 'Select date',
                  suffixIcon: Icons.calendar_month,
                  readOnly: true,
                  fillColor: AppColors.lightCardColor,
                  onTap: () {
                    controller.pickDateOnTap(context);
                  },
                ).paddingOnly(bottom: 16),

                // Retrieve Time
                TextFormFieldWithLabel(
                  controller: controller.retrieveTimeController,
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
            text: 'Retrieve address',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 5),
          TextFormFieldWidget(
            controller: controller.retrieveAddressController,
            hintText: 'Enter address',
            required: true,
            textCapitalization: TextCapitalization.sentences,
            textInputType: TextInputType.streetAddress,
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
