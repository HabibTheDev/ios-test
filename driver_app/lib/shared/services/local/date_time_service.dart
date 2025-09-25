import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_color.dart';
import '../../../customizable_date_picker/i18n/date_picker_i18n.dart';
import '../../../customizable_date_picker/model/date_picker_divider_theme.dart';
import '../../../customizable_date_picker/model/date_picker_theme.dart';
import '../../../customizable_date_picker/widget/customizable_date_picker_widget.dart';
import '../../repository/local/date_time_repo.dart';
import '../../widgets/outline_text_button.dart';
import '../../widgets/solid_text_button.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/widthbox.dart';

class DateTimeService extends DateTimeRepo {
  @override
  Future<DateTime?> androidDatePicker(BuildContext context, {DateTime? lastDate}) async {
    // Pick a date
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
    );
    return date;
  }

  @override
  Future<DateTime?> iOSDatePicker(BuildContext context, {DateTime? lastDate, DateTime? initialDate}) async {
    DateTime? selectedDate = initialDate ?? DateTime.now();
    Key? datePickerKey;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      constraints: const BoxConstraints(maxHeight: 380),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      backgroundColor: AppColors.lightCardColor,
      builder: (BuildContext context) {
        return SafeArea(
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ButtonText(
                      text: DateFormat('EEE dd-MMM, yyyy').format(selectedDate!),
                      textColor: AppColors.lightSecondaryTextColor,
                    )),
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedDate = DateTime.now();
                          datePickerKey = ValueKey(selectedDate);
                          Future.delayed(const Duration(milliseconds: 300)).then((value) => datePickerKey = null);
                        });
                      },
                      child: const Row(
                        children: [
                          BodyText(
                            text: 'Today ',
                            textColor: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          Icon(
                            Icons.replay_outlined,
                            color: AppColors.primaryColor,
                            size: 16,
                          )
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(left: 16, right: 16, top: 16),

                //Date picker
                CustomizableDatePickerWidget(
                  key: datePickerKey,
                  initialDate: selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: lastDate ?? DateTime.now(),
                  locale: DateTimePickerLocale.enUs,
                  looping: true,
                  dateFormat: "dd-MMMM-yyyy",
                  pickerTheme: const DateTimePickerTheme(
                    itemTextStyle:
                        TextStyle(color: AppColors.lightTextColor, fontSize: 16, fontWeight: FontWeight.w600),
                    backgroundColor: AppColors.lightCardColor,
                    itemHeight: 44,
                    pickerHeight: 220,
                    dividerTheme:
                        DatePickerDividerTheme(dividerColor: AppColors.primaryColor, thickness: 0.5, height: 1),
                  ),
                  onChange: (dateTime, selectedIndex) => setState(() => selectedDate = dateTime),
                ).paddingSymmetric(horizontal: 16),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlineTextButton(
                        buttonText: 'Cancel',
                        onTap: () {
                          selectedDate = null;
                          Get.back();
                        },
                      ),
                    ),
                    const WidthBox(width: 8),
                    Expanded(
                      child: SolidTextButton(
                        buttonText: 'Select',
                        onTap: () => Get.back(),
                      ),
                    ),
                  ],
                ).paddingOnly(left: 16, right: 16, bottom: 8),
              ],
            );
          }),
        );
      },
    );
    return selectedDate;
  }
}
