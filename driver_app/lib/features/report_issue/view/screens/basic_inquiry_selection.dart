import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_color.dart';
import '../../../../core/constants/arguments_key.dart';
import '../../../../core/router/router_paths.dart';
import '../../../../shared/utils/enums.dart';
import '../../../../shared/widgets/app_divider.dart';
import '../../../../shared/widgets/basic_car_details_widget.dart';
import '../../../../shared/widgets/outline_text_button.dart';
import '../../../../shared/widgets/solid_text_button.dart';
import '../../../../shared/widgets/text_field_widget.dart';
import '../../../../shared/widgets/text_field_with_label.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../shared/widgets/warning_note_widget.dart';
import '../../../../shared/widgets/widthbox.dart';
import '../../../explore_car/view/widgets/checkout_app_scaffold.dart';
import '../../controller/basic_inquiry_controller.dart';
import '../../controller/issue_selection_controller.dart';
import '../../model/incident_location_model.dart';
import '../../model/incident_time_slot_model.dart';
import '../../model/incident_vehicle_location_model.dart';
import '../widgets/incident_location_radio_widget.dart';
import '../widgets/incident_vehicle_location_radio_widget.dart';
import '../widgets/time_slot_radio_widget.dart';

class BasicInquirySelection extends StatelessWidget {
  const BasicInquirySelection({super.key});

  @override
  Widget build(BuildContext context) {
    final BasicInquiryController controller = Get.find();
    final IssueSelectionController issueController = Get.find();
    final issueTitle = Get.arguments?[ArgumentsKey.issueTitle];
    return CheckoutAppScaffold(
      backgroundColor: AppColors.lightCardColor,
      title: 'Report an issue',
      leading: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.transparent,
        child: SvgPicture.asset(Assets.assetsSvgCarCrush),
      ),
      progressValue: 0.2,
      progressColor: AppColors.inProgressColor,
      closeOnTap: () => Get.until((route) => route.settings.name == RouterPaths.drawer),
      body: _bodyUI(controller, issueController, context),
      bottomNavigationBar: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlineTextButton(onTap: () => Get.back(), buttonText: 'Previous'),
            ),
            const WidthBox(width: 6),
            Expanded(
              child: SolidTextButton(
                  onTap: () {
                    Get.toNamed(
                      RouterPaths.captureImageInstruction,
                      arguments: {
                        ArgumentsKey.title: 'Report an issue',
                        ArgumentsKey.issueTitle: issueTitle,
                        ArgumentsKey.returnScreen: RouterPaths.drawer,
                      },
                    );
                  },
                  buttonText: 'Next'),
            ),
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _bodyUI(BasicInquiryController controller, IssueSelectionController issueController, BuildContext context) =>
      SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Car details
            const BasicCarDetailsWidget(make: 'Lamborghini', model: 'Gallardo', year: 2022)
                .paddingOnly(top: 24, bottom: 32),

            // How did it happen?
            const TitleText(text: 'Basic inquiry').paddingOnly(bottom: 20),
            const SmallText(
              text: 'How did it happen?',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),
            TextFormFieldWidget(
              controller: controller.damageDetailsController,
              hintText: 'Explain here briefly',
              minLine: 5,
              maxLine: 10,
              required: true,
            ),
            const AppDivider(height: 32),

            // When did it happen?
            const SmallText(
              text: 'When did it happen?',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),

            // Slot radio widget
            TimeSlotRadioWidget(
              slotList: IncidentTimeSlotModel.slotList,
              onChanged: controller.changeDamageSlot,
            ).paddingOnly(bottom: 20),

            // Select date
            TextFormFieldWithLabel(
              controller: controller.dateController,
              labelText: 'Date',
              hintText: 'Select date',
              suffixIcon: Icons.calendar_month,
              readOnly: true,
              fillColor: AppColors.lightCardColor,
              onTap: () => controller.pickDateOnTap(context),
            ).paddingOnly(bottom: 16),

            // Warning note
            const WarningNoteWidget(
              child:
                  SmallText(text: 'If you\'re unsure when the damage occurred, choose the date you first noticed it.'),
            ),
            const AppDivider(height: 32),

            // Where did the incident occurred?
            const SmallText(
              text: 'Where did the incident occurred?',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),
            // Incident location
            IncidentLocationRadioWidget(
              locationList: IncidentLocationModel.locationList,
              onChanged: (value) {},
            ),
            const AppDivider(height: 32),

            // Where is the vehicle now?
            const SmallText(
              text: 'Where is the vehicle now?',
              fontWeight: FontWeight.w700,
              textColor: AppColors.lightSecondaryTextColor,
            ).paddingOnly(bottom: 10),
            // Vehicle location
            IncidentVehicleLocationRadioWidget(
              vehicleLocationList: issueController.selectedIssue.value?.issueType == ReportIssueType.weatherDamage ||
                      issueController.selectedIssue.value?.issueType == ReportIssueType.none
                  ? IncidentVehicleLocationModel.weatherAndNone
                  : IncidentVehicleLocationModel.damageLocationList,
              onChanged: (value) {},
            )
          ],
        ),
      );
}
