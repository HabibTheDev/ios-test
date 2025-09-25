import 'package:driver_app/shared/tiles/car_info_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_dropdown.dart';
import '../../../../shared/widgets/car_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/request_exchange_controller.dart';
import '../../model/vehicle_handover_radio_model.dart';
import '../widgets/vehicle_handover_radio_widget.dart';

class RequestExchange extends StatelessWidget {
  const RequestExchange({super.key});

  @override
  Widget build(BuildContext context) {
    final RequestExchangeController controller = Get.find();
    final bool hasCar = Get.arguments?['hasCar'] ?? true;
    return CheckoutAppScaffold(
      title: 'Request exchange',
      backgroundColor: AppColors.lightCardColor,
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.swap_horizontal_circle_outlined,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: _bodyUI(context, controller, hasCar),
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.contractDetails),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlineTextButton(onTap: () => Get.back(), buttonText: 'Change car'),
            ),
            const WidthBox(width: 10),
            Expanded(
              child: SolidTextButton(
                  onTap: () => Get.toNamed(RouterPaths.requestMaintenanceExchange), buttonText: 'Send request'),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI(BuildContext context, RequestExchangeController controller, bool hasCar) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Car details
          hasCar
              ? const CarDetailsWidget()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TitleText(text: 'No car selected'),
                    const SmallText(
                      text: 'Admin will suggest some available cars for you.',
                      textColor: AppColors.lightSecondaryTextColor,
                    ).paddingOnly(bottom: 32),
                    Image.asset(
                      Assets.assetsImageNoCar,
                      height: 90,
                      fit: BoxFit.fitHeight,
                    )
                  ],
                ),
          const AppDivider(height: 32),

          const BodyText(
            text: 'Vehicle handover',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 20),
          const SmallText(
            text: 'Choose method',
            fontWeight: FontWeight.w700,
            textColor: AppColors.lightSecondaryTextColor,
          ).paddingOnly(bottom: 10),

          VehicleHandoverRadioWidget(
              vehicleHandoverList: VehicleHandoverRadioModel.vehicleHandoverList,
              onChanged: (value) {
                debugPrint(value.method);
                controller.selectedHandoverMethod(value);
              }).paddingOnly(bottom: 20),

          // Handover Date time
          Obx(
            () => CardWidget(
              contentPadding: const EdgeInsets.all(16),
              backgroundColor: AppColors.lightBgColor,
              showShadow: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Handover Date
                  TextFormFieldWithLabel(
                    controller: controller.handoverDateController,
                    labelText: '${controller.selectedHandoverMethod.value?.method} Date',
                    hintText: 'Select date',
                    suffixIcon: Icons.calendar_month,
                    readOnly: true,
                    fillColor: AppColors.lightCardColor,
                    onTap: () {
                      controller.pickDateOnTap(context);
                    },
                  ).paddingOnly(bottom: 16),

                  // Handover Time
                  TextFormFieldWithLabel(
                    controller: controller.handoverTimeController,
                    labelText: '${controller.selectedHandoverMethod.value?.method} Time',
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

          // Handover location
          Obx(() => SmallText(
                text:
                    '${controller.selectedHandoverMethod.value?.method} ${controller.selectedHandoverMethod.value?.typeEnum == HandoverTypeEnum.pickup ? 'location' : 'address'}',
                fontWeight: FontWeight.w700,
                textColor: AppColors.lightSecondaryTextColor,
              )).paddingOnly(bottom: 5),

          Obx(
            () => controller.selectedHandoverMethod.value?.typeEnum == HandoverTypeEnum.pickup
                ? CardWidget(
                    showShadow: false,
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    backgroundColor: AppColors.lightTextFieldFillColor,
                    child: BasicDropdown(
                        dropdownWidth: MediaQuery.of(context).size.width * .9,
                        bgColor: Colors.transparent,
                        items: AppList.locationList,
                        selectedValue: controller.selectedPickupLocation.value,
                        hintText: 'Select pickup location',
                        onChanged: (value) {
                          controller.changePickupLocation(value);
                        }),
                  )
                : TextFormFieldWidget(
                    controller: controller.deliveryAddressController,
                    hintText: 'Enter address',
                    required: true,
                    textCapitalization: TextCapitalization.sentences,
                    textInputType: TextInputType.streetAddress,
                  ),
          ).paddingOnly(bottom: 16),

          // Warning note
          WarningNoteWidget(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.lightTextColor),
                children: [
                  TextSpan(text: 'Pick-up location will be '),
                  TextSpan(
                      text: 'selected',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      )),
                  TextSpan(text: ' automatically after you pick your vehicle.'),
                ],
              ),
            ),
          ),
        ],
      );
}
