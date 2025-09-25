import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_list.dart';
import '../../repository/local/time_repo.dart';
import '../../utils/utils.dart';
import '../../widgets/outline_text_button.dart';
import '../../widgets/solid_text_button.dart';
import '../../widgets/text_widget.dart';
import '../../widgets/widthbox.dart';

class TimeService extends TimeRepo {
  @override
  Future<TimeOfDay?> iOSTimePicker(BuildContext context) async {
    TimeOfDay? selectedTime = TimeOfDay.now();
    const double itemExtend = 40;
    const double diameterRatio = 0.9;
    int selectedHour = 1;
    int selectedMinute = 0;
    String selectedAmPm = AppList.amPM.first;

    await showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      isDismissible: false,
      constraints: const BoxConstraints(maxHeight: 311),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      backgroundColor: AppColors.lightCardColor,
      builder: (BuildContext context) {
        //onChange
        void updateTime() {
          if (selectedAmPm == 'AM') {
            if (selectedHour == 12) {
              selectedTime = TimeOfDay(hour: 00, minute: formatNumber(selectedMinute));
            } else {
              selectedTime = TimeOfDay(hour: formatNumber(selectedHour), minute: formatNumber(selectedMinute));
            }
          } else {
            final adjustedHour = selectedHour + 12;
            if (adjustedHour == 24) {
              selectedTime = TimeOfDay(hour: 12, minute: formatNumber(selectedMinute));
            } else {
              selectedTime = TimeOfDay(hour: formatNumber(adjustedHour), minute: formatNumber(selectedMinute));
            }
          }
        }

        return SafeArea(
          child: StatefulBuilder(builder: (context, setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Time picker
                // Expanded(
                //   child: CupertinoDatePicker(
                //     initialDateTime: selectedDate,
                //     mode: CupertinoDatePickerMode.time,
                //     minuteInterval: 1,
                //     use24hFormat: false,
                //     itemExtent: 36,
                //     onDateTimeChanged: (dateTime) =>
                //         setState(() => selectedDate = dateTime),
                //   ).paddingSymmetric(horizontal: 16, vertical: 16),
                // ),

                Expanded(
                  child: Row(
                    children: [
                      // Hours
                      Expanded(
                        child: CupertinoPicker(
                          itemExtent: itemExtend,
                          diameterRatio: diameterRatio,
                          looping: true,
                          onSelectedItemChanged: (index) {
                            selectedHour = index + 1;
                            updateTime();
                          },
                          selectionOverlay: _overlay,
                          children: AppList.hours
                              .map((item) => Center(
                                    child: BodyText(
                                        text: formatNumberToString(item), fontWeight: FontWeight.w500, textSize: 16),
                                  ))
                              .toList(),
                        ),
                      ),
                      _dividerColon,

                      // Minute
                      Expanded(
                          child: CupertinoPicker(
                        itemExtent: itemExtend,
                        diameterRatio: diameterRatio,
                        looping: true,
                        onSelectedItemChanged: (index) {
                          selectedMinute = index;
                          updateTime();
                        },
                        selectionOverlay: _overlay,
                        children: AppList.minutes
                            .map((item) => Center(
                                  child: BodyText(
                                      text: formatNumberToString(item), fontWeight: FontWeight.w500, textSize: 16),
                                ))
                            .toList(),
                      )),
                      _dividerColon,

                      // AM/PM
                      Expanded(
                          child: CupertinoPicker(
                        itemExtent: itemExtend,
                        diameterRatio: diameterRatio,
                        looping: false,
                        onSelectedItemChanged: (index) {
                          selectedAmPm = AppList.amPM[index];
                          updateTime();
                        },
                        selectionOverlay: _overlay,
                        children: AppList.amPM
                            .map((item) => Center(
                                  child: BodyText(text: item, fontWeight: FontWeight.w500, textSize: 16),
                                ))
                            .toList(),
                      )),
                    ],
                  ).paddingSymmetric(horizontal: 16),
                ),

                // Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlineTextButton(
                        buttonText: 'Cancel',
                        onTap: () {
                          selectedTime = null;
                          Get.back();
                        },
                      ),
                    ),
                    const WidthBox(width: 8),
                    Expanded(
                      child: SolidTextButton(
                        buttonText: 'Select',
                        onTap: () {
                          updateTime();
                          debugPrint('Selected Time: $selectedTime');
                          Get.back();
                        },
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

    return selectedTime;
  }

  final Widget _dividerColon = Center(
    child: const BodyText(
      text: ':',
      textSize: 18,
      fontWeight: FontWeight.w500,
    ).paddingSymmetric(horizontal: 8),
  );

  final Widget _overlay = Container(
    decoration: const BoxDecoration(
      border: Border(
        top: BorderSide(color: AppColors.primaryColor, width: 0.5),
        bottom: BorderSide(color: AppColors.primaryColor, width: 0.5),
      ),
    ),
  );
}
