import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/widgets/basic_dropdown.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_list.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../controller/car_checkout_controller.dart';
import '../../model/handover_method_radio_model.dart';
import 'handover_method_radio_widget.dart';

class HandoverMethodWidget extends StatelessWidget {
  const HandoverMethodWidget({super.key, required this.controller});
  final CarCheckoutController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BodyText(
          text: 'Handover method',
          fontWeight: FontWeight.w700,
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 20),
        const SmallText(
          text: 'Choose method',
          fontWeight: FontWeight.w700,
          textColor: AppColors.lightSecondaryTextColor,
        ).paddingOnly(bottom: 10),

        HandoverMethodRadioWidget(
            handoverMethodList: HandoverMethodRadioModel.handoverMethodList,
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
                  labelText:
                      '${controller.selectedHandoverMethod.value?.method} Date',
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
                  labelText:
                      '${controller.selectedHandoverMethod.value?.method} Time',
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
                    leading: Icon(Icons.info,
                        color: AppColors.primaryColor, size: 16),
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
          () => controller.selectedHandoverMethod.value?.typeEnum ==
                  HandoverTypeEnum.pickup
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
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightTextColor),
              children: [
                TextSpan(text: 'Pick-up location is '),
                TextSpan(
                    text: 'selected',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    )),
                TextSpan(text: ' automatically based on vehicle\'s location.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
