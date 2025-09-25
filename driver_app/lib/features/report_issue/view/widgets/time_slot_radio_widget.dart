import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/incident_time_slot_model.dart';

class TimeSlotRadioWidget extends StatefulWidget {
  final List<IncidentTimeSlotModel> slotList;
  final ValueChanged<IncidentTimeSlotModel> onChanged;

  const TimeSlotRadioWidget({
    super.key,
    required this.slotList,
    required this.onChanged,
  });

  @override
  State<TimeSlotRadioWidget> createState() => _TimeSlotRadioWidgetState();
}

class _TimeSlotRadioWidgetState extends State<TimeSlotRadioWidget> {
  List<IncidentTimeSlotModel> _slotList = [];
  int groupValue = 0;

  @override
  void initState() {
    super.initState();
    _slotList = List.from(widget.slotList);
    widget.onChanged(_slotList.first);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.slotList.map((slot) {
        return BorderCardWidget(
          contentPadding: const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          backgroundColor:
              groupValue == slot.radioValue ? AppColors.primaryColor.withOpacity(0.1) : AppColors.lightCardColor,
          borderColor: groupValue == slot.radioValue ? AppColors.primaryColor.withOpacity(0.1) : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<int>(
                    visualDensity: VisualDensity.compact,
                    value: slot.radioValue,
                    groupValue: groupValue,
                    onChanged: (value) {
                      setState(() => groupValue = value!);
                      for (var item in _slotList) {
                        if (item.radioValue == groupValue) {
                          widget.onChanged(item);
                          break;
                        }
                      }
                    },
                  ),

                  // Slot & Time
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Slot
                        SmallText(
                          text: slot.slotName,
                          textColor: groupValue == slot.radioValue
                              ? AppColors.lightTextColor
                              : AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w700,
                        ).paddingOnly(bottom: 2),

                        // Time
                        ExtraSmallText(
                          text: '${slot.startTime} - ${slot.endTime}',
                          textColor: AppColors.lightSecondaryTextColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ).paddingOnly(bottom: 10);
      }).toList(),
    );
  }
}
