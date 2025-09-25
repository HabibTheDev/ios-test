import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../shared/widgets/border_card_widget.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../model/day_slot_model.dart';

class DaySlotCheckboxWidget extends StatefulWidget {
  const DaySlotCheckboxWidget({
    super.key,
    required this.daySlots,
    required this.onSelectionChanged,
  });

  final List<DaySlotModel> daySlots;
  final ValueChanged<List<DaySlotModel>> onSelectionChanged;

  @override
  State<DaySlotCheckboxWidget> createState() => _DaySlotCheckboxWidgetState();
}

class _DaySlotCheckboxWidgetState extends State<DaySlotCheckboxWidget> {
  List<DaySlotModel> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    _selectedDays = List.from(widget.daySlots);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.daySlots.map((day) {
        return BorderCardWidget(
          borderColor:
              day.checkValue ? AppColors.primaryColor.withOpacity(0.4) : null,
          backgroundColor:
              day.checkValue ? AppColors.primaryColor.withOpacity(0.07) : null,
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.only(right: 12, top: 4, bottom: 4),
            dense: true,
            visualDensity: VisualDensity.compact,
            value: day.checkValue,
            onChanged: (bool? value) {
              setState(() {
                day.checkValue = value ?? false;
                _selectedDays = List.from(widget.daySlots);
                widget.onSelectionChanged(_selectedDays);
              });
            },
            title: SmallText(
              text: day.day,
              textColor: day.checkValue
                  ? AppColors.lightTextColor
                  : AppColors.lightSecondaryTextColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ).paddingSymmetric(vertical: 4);
      }).toList(),
    );
  }
}
