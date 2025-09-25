part of 'widget_imports.dart';

// ignore: must_be_immutable
class TimeSlotDropdown extends StatelessWidget {
  final List<TimeSlotModel> items;
  TimeSlotModel? selectedValue;
  final String hintText;
  final Function(TimeSlotModel) onChanged;
  final double? width;
  final double? buttonHeight;
  final double? dropdownWidth;
  final bool required;
  final Color? buttonBorderColor;

  TimeSlotDropdown(
      {super.key,
      required this.items,
      required this.selectedValue,
      required this.hintText,
      required this.onChanged,
      this.width,
      this.buttonHeight = 36,
      this.dropdownWidth,
      this.required = false,
      this.buttonBorderColor});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<TimeSlotModel>(
        isExpanded: true,
        hint: BodyText(
          text: hintText,
          textColor: AppColors.lightSecondaryTextColor,
        ),
        items: items
            .map((item) => DropdownMenuItem<TimeSlotModel>(
                  value: item,
                  child: BodyText(
                    text: item.name,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (TimeSlotModel? value) {
          selectedValue = value;
          onChanged(selectedValue!);
        },
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down, size: 20),
          iconSize: 14,
          iconEnabledColor: AppColors.lightTextFieldHintColor,
          iconDisabledColor: Colors.grey,
        ),
        buttonStyleData: ButtonStyleData(
          height: buttonHeight,
          width: width ?? 144,
          padding: const EdgeInsets.only(left: 12, right: 12),
          decoration: BoxDecoration(
            border: Border.all(width: .7, color: buttonBorderColor ?? AppColors.lightTextFieldHintColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          elevation: 0,
        ),
        menuItemStyleData: const MenuItemStyleData(height: 40, padding: EdgeInsets.only(left: 12, right: 12)),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 700,
          width: dropdownWidth ?? 150,
          padding: null,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.white),
          elevation: 8,
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(10),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
      ),
    );
  }
}
