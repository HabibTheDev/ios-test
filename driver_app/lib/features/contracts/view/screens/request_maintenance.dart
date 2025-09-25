import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/basic_dropdown.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/request_maintenance_controller.dart';
import '../../model/maintenance_type_radio_model.dart';
import '../../model/return_method_radio_model.dart';
import '../widgets/maintenance_service_type_radio_widget.dart';
import '../widgets/return_method_radio_widget.dart';

class RequestMaintenance extends StatelessWidget {
  const RequestMaintenance({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestMaintenanceController controller = Get.find();
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Request maintenance',
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.handyman_rounded,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: SafeArea(child: _bodyUI(context, controller)),
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.contractDetails),
    );
  }

  Widget _bodyUI(BuildContext context, RequestMaintenanceController controller) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const BasicCarDetailsWidget().paddingOnly(bottom: 20),

          // Maintenance type
          const SmallText(
            text: 'Maintenance type',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          // Maintenance Radio Widget
          MaintenanceServiceTypeRadioWidget(
              maintenanceServiceList: MaintenanceTypeRadioModel.maintenanceServiceTypes,
              onChanged: (value) {
                debugPrint(value.serviceType);
                controller.selectedMaintenanceType(value);
              }),

          const AppDivider(height: 20).paddingOnly(bottom: 16),

          // Return & delivery
          const BodyText(
            text: 'Return  & delivery',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),
          const SmallText(
            text: 'How do you want to return the car?',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          // Return Radio Widget
          ReturnMethodRadioWidget(
              returnMethodList: ReturnMethodRadioModel.returnMethodList,
              onChanged: (value) {
                debugPrint(value.method);
                controller.selectedReturnMethod(value);
              }).paddingOnly(bottom: 20),

          // Return Date time
          Obx(
            () => CardWidget(
              contentPadding: const EdgeInsets.all(16),
              backgroundColor: AppColors.lightBgColor,
              showShadow: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // return Date
                  TextFormFieldWithLabel(
                    controller: controller.selectedDateController,
                    labelText: '${controller.selectedReturnMethod.value?.method} Date',
                    hintText: 'Select date',
                    suffixIcon: Icons.calendar_month,
                    readOnly: true,
                    fillColor: AppColors.lightCardColor,
                    onTap: () {
                      controller.pickDateOnTap(context);
                    },
                  ).paddingOnly(bottom: 16),

                  // return Time
                  TextFormFieldWithLabel(
                    controller: controller.selectedTimeController,
                    labelText: '${controller.selectedReturnMethod.value?.method} Time',
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
            ),
          ).paddingOnly(bottom: 16),

          // return location
          Obx(
            () => SmallText(
              text:
                  '${controller.selectedReturnMethod.value?.method} ${controller.selectedReturnMethod.value?.typeEnum == ReturnTypeEnum.dropOff ? 'location' : 'address'}',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ),
          ).paddingOnly(bottom: 5),

          Obx(
            () => controller.selectedReturnMethod.value?.typeEnum == ReturnTypeEnum.dropOff
                ? CardWidget(
                    showShadow: false,
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    backgroundColor: AppColors.lightTextFieldFillColor,
                    child: BasicDropdown(
                        bgColor: Colors.transparent,
                        items: AppList.locationList,
                        selectedValue: controller.selectedPickupLocation.value,
                        hintText: 'Select location',
                        dropdownWidth: MediaQuery.of(context).size.width * .9,
                        onChanged: (value) {
                          controller.changePickupLocation(value);
                        }),
                  )
                : TextFormFieldWidget(
                    controller: controller.retrieveAddressController,
                    hintText: 'Enter address',
                    required: true,
                    textCapitalization: TextCapitalization.sentences,
                    textInputType: TextInputType.streetAddress,
                  ),
          ).paddingOnly(bottom: 16),

          const SmallText(
            text: 'Delivery address',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 5),
          TextFormFieldWidget(
            controller: controller.deliveryAddressController,
            hintText: 'Delivery address',
            required: true,
            textCapitalization: TextCapitalization.sentences,
            textInputType: TextInputType.streetAddress,
          ).paddingOnly(bottom: 24),

          SolidTextButton(onTap: () => Get.toNamed(RouterPaths.requestMaintenanceExchange), buttonText: 'Send request')
              .paddingOnly(bottom: 20),
        ],
      );
}
