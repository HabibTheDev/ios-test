import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'network_image_widget.dart';
import 'text_widget.dart';

import '../../core/constants/app_color.dart';
import '../../features/more/model/country_code_model.dart';

// ignore: must_be_immutable
class CountryCodeDropdown extends StatelessWidget {
  final List<CountryCodeModel> items;
  CountryCodeModel? selectedValue;
  final String hintText;
  final Function(CountryCodeModel) onChanged;
  final double? width;
  final double? buttonHeight;
  final double? dropdownWidth;
  final bool required;
  final Color? buttonBorderColor;

  CountryCodeDropdown(
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
      child: DropdownButton2<CountryCodeModel>(
        isExpanded: true,
        hint: BodyText(
          text: hintText,
          textColor: AppColors.lightSecondaryTextColor,
        ),
        items: items
            .map((item) => DropdownMenuItem<CountryCodeModel>(
                  value: item,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NetworkImageWidget(
                        imageUrl: item.countryFlag,
                        fit: BoxFit.fitHeight,
                        height: 20,
                        width: 20,
                        borderRadius: 4,
                      ),
                      Expanded(child: BodyText(text: ' ${item.phoneCode}')),
                    ],
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (CountryCodeModel? value) {
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
          width: width ?? 94,
          padding: const EdgeInsets.only(left: 12),
          decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
          elevation: 0,
        ),
        menuItemStyleData: const MenuItemStyleData(height: 40, padding: EdgeInsets.only(left: 12, right: 12)),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 700,
          width: dropdownWidth ?? 100,
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
