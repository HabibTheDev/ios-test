import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/tiles/car_info_tile.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/card_widget.dart';
import '../../../../shared/widgets/heightbox.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/driver_controller.dart';
import '../../model/day_slot_model.dart';
import '../../model/driver_permission_radio_model.dart';
import '../widgets/day_slot_checkbox_widget.dart';
import '../widgets/driver_permission_radio_widget.dart';

class EditDriverAccess extends StatelessWidget {
  const EditDriverAccess({super.key});

  @override
  Widget build(BuildContext context) {
    final DriverController controller = Get.find();
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Edit access',
      leading: const IconButton(
        onPressed: null,
        icon: Icon(
          Icons.phonelink_lock_rounded,
          size: 20,
          color: AppColors.lightAppBarIconColor,
        ),
      ),
      body: _bodyUI(context, controller),
      closeOnTap: () => Get.back(),
      bottomNavigationBar: SafeArea(
        child: SolidTextButton(onTap: () {}, buttonText: 'Save changes').paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI(BuildContext context, DriverController controller) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Car details
          const BasicCarDetailsWidget().paddingOnly(bottom: 20),

          // Driver Name
          TextFormFieldWithLabel(
            controller: TextEditingController(),
            hintText: 'Enter name',
            labelText: 'Driver name',
            textCapitalization: TextCapitalization.words,
            textInputType: TextInputType.name,
          ).paddingOnly(bottom: 16),

          // Driver email
          TextFormFieldWithLabel(
            controller: TextEditingController(),
            hintText: 'Enter email',
            labelText: 'Email',
            textCapitalization: TextCapitalization.words,
            textInputType: TextInputType.name,
          ),
          const AppDivider(height: 36).paddingOnly(bottom: 8),

          // Permission type
          const SmallText(
            text: 'Permission type',
            textColor: AppColors.lightSecondaryTextColor,
            fontWeight: FontWeight.w700,
          ).paddingOnly(bottom: 10),
          DriverPermissionRadioWidget(
            permissionList: DriverPermissionRadioModel.permissionTypes,
            onChanged: (value) {
              controller.changePermission(value);
            },
          ),

          // Start & End time
          Obx(
            () => controller.selectedPermission.value?.typeEnum == DriverPermissionType.partialAccess
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeightBox(height: 16),
                      CardWidget(
                        contentPadding: const EdgeInsets.all(16),
                        backgroundColor: AppColors.lightBgColor,
                        showShadow: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Start Time
                            TextFormFieldWithLabel(
                              controller: controller.startTimeController,
                              labelText: 'Select Time',
                              hintText: 'Select Time',
                              suffixIcon: Icons.watch_later_rounded,
                              readOnly: true,
                              fillColor: AppColors.lightCardColor,
                              onTap: () {
                                controller.pickStartTimeOnTap(context);
                              },
                            ).paddingOnly(bottom: 16),
                            // End Time
                            TextFormFieldWithLabel(
                              controller: controller.endTimeController,
                              labelText: 'Select Time',
                              hintText: 'Select time',
                              suffixIcon: Icons.watch_later_rounded,
                              readOnly: true,
                              fillColor: AppColors.lightCardColor,
                              onTap: () {
                                controller.pickEndTimeOnTap(context);
                              },
                            ).paddingOnly(bottom: 16),
                            // Access period
                            const CarInfoTile(titleKey: 'Access period', titleValue: '08:00 AM - 08:00 PM')
                          ],
                        ),
                      ),
                      const AppDivider(height: 36),
                      const SmallText(
                        text: 'Select days',
                        textColor: AppColors.lightSecondaryTextColor,
                        fontWeight: FontWeight.w700,
                      ).paddingOnly(bottom: 10),
                      DaySlotCheckboxWidget(
                        daySlots: DaySlotModel.daySlotList,
                        onSelectionChanged: (value) {},
                      )
                    ],
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
}
