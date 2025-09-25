part of 'widget_imports.dart';

// ignore: must_be_immutable
class BasicDropdown extends StatelessWidget {
  final List<String> items;
  String? selectedValue;
  final String hintText;
  final Function(String) onChanged;
  final double? width;
  final double? buttonHeight;
  final double? dropdownWidth;
  final bool required;
  final Color? buttonBorderColor;

  BasicDropdown(
      {super.key,
      required this.items,
      required this.selectedValue,
      required this.hintText,
      required this.onChanged,
      this.width,
      this.buttonHeight = 44,
      this.dropdownWidth,
      this.required = false,
      this.buttonBorderColor});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: BodyText(text: hintText, textColor: AppColors.lightSecondaryTextColor),
        items: items.map((item) => DropdownMenuItem<String>(value: item, child: BodyText(text: item))).toList(),
        value: selectedValue,
        onChanged: (String? value) {
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
          width: width ?? double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: const BoxDecoration(
            color: AppColors.lightTextFieldFillColor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          elevation: 0,
        ),
        menuItemStyleData: const MenuItemStyleData(height: 40, padding: EdgeInsets.only(left: 12, right: 12)),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 700,
          width: dropdownWidth ?? double.infinity,
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
