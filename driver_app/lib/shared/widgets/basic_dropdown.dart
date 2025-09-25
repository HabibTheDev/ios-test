import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../../core/constants/app_color.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class BasicDropdown extends StatelessWidget {
  final List<String> items;
  String? selectedValue;
  final String hintText;
  final Function(String) onChanged;
  final double? width;
  final double? dropdownWidth;
  final double? buttonHeight;
  final bool required;
  final Color? buttonBorderColor;
  final Color? bgColor;

  BasicDropdown(
      {super.key,
      required this.items,
      required this.selectedValue,
      required this.hintText,
      required this.onChanged,
      this.width,
      this.buttonHeight = 44,
      this.required = false,
      this.buttonBorderColor,
      this.bgColor,
      this.dropdownWidth});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: BodyText(
          text: hintText,
          textColor: AppColors.lightSecondaryTextColor,
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: BodyText(
                    text: item,
                  ),
                ))
            .toList(),
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
          decoration: BoxDecoration(
            color: bgColor ?? AppColors.lightTextFieldFillColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          elevation: 0,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 12, right: 12),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 700,
          width: dropdownWidth ?? double.infinity,
          padding: null,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6), color: Colors.white),
          elevation: 8,
          // offset: Offset(0, -40),
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
