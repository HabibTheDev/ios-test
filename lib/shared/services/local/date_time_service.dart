import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:employee_app/core/l10n/app_localizations.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_string.dart';
import '../../../features/customizable_date_picker/i18n/date_picker_i18n.dart';
import '../../../features/customizable_date_picker/model/date_picker_divider_theme.dart';
import '../../../features/customizable_date_picker/model/date_picker_theme.dart';
import '../../../features/customizable_date_picker/widget/customizable_date_picker_widget.dart';
import '../../repository/local/date_time_repo.dart';
import '../../widgets/widget_imports.dart';

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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6))),
      backgroundColor: AppColors.lightCardColor,
      builder: (BuildContext context) {
        final locale = AppLocalizations.of(context);
        return SafeArea(
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ButtonText(
                      text: DateFormat(AppString.calenderTitleFormat).format(selectedDate!),
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
                      child: Row(
                        children: [
                          BodyText(
                            text: '${locale?.today} ',
                            textColor: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          const Icon(Icons.replay_outlined, color: AppColors.primaryColor, size: 16)
                        ],
                      ),
                    )
                  ],
                ).paddingOnly(left: 16, right: 16, top: 16),

                // Date picker
                CustomizableDatePickerWidget(
                  key: datePickerKey,
                  initialDate: selectedDate,
                  firstDate: DateTime(1900),
                  lastDate: lastDate ?? DateTime.now(),
                  locale: DateTimePickerLocale.enUs,
                  looping: true,
                  dateFormat: AppString.datePickerFormat,
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
                        buttonText: '${locale?.cancel}',
                        onTap: () {
                          selectedDate = null;
                          Get.back();
                        },
                      ),
                    ),
                    const WidthBox(width: 8),
                    Expanded(
                      child: SolidTextButton(
                        buttonText: '${locale?.select}',
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
