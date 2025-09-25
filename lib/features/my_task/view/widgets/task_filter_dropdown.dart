part of 'widget_imports.dart';

// ignore: must_be_immutable
class TaskFilterDropdown<T> extends StatelessWidget {
  final List<T> items;
  T? selectedValue;
  final String hintText;
  final Function(T?) onChanged;
  final double? buttonWidth;
  final double? buttonHeight;
  final double? dropdownWidth;
  final bool required;
  final Color? buttonBorderColor;
  final String Function(T) itemToString;

  TaskFilterDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.hintText,
    required this.onChanged,
    required this.itemToString,
    this.buttonWidth,
    this.buttonHeight = 36,
    this.dropdownWidth,
    this.required = false,
    this.buttonBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: BodyText(text: hintText, textColor: AppColors.lightSecondaryTextColor),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: BodyText(text: itemToString(item)), // Use itemToString for display
              ),
            )
            .toList(),
        value: selectedValue,
        onChanged: (T? value) {
          selectedValue = value;
          onChanged(selectedValue);
        },
        iconStyleData: const IconStyleData(
          icon: Icon(Icons.keyboard_arrow_down, size: 20),
          iconSize: 14,
          iconEnabledColor: AppColors.lightTextFieldHintColor,
          iconDisabledColor: Colors.grey,
        ),
        buttonStyleData: ButtonStyleData(
          height: buttonHeight,
          width: buttonWidth ?? 144,
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
