import 'package:flutter/material.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';

class BasicRadioListWidget extends StatefulWidget {
  const BasicRadioListWidget({super.key, required this.items, required this.onItemSelected});
  final List<String> items;
  final ValueChanged<String> onItemSelected;

  @override
  State<BasicRadioListWidget> createState() => _BasicRadioListWidgetState();
}

class _BasicRadioListWidgetState extends State<BasicRadioListWidget> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: AppColors.lightBorderColor, width: 1)),
          child: Theme(
            data: ThemeData(unselectedWidgetColor: Colors.red),
            child: RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              title: SmallText(
                text: item,
                textColor: AppColors.lightSecondaryTextColor,
              ),
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (states) => _selectedItem == item ? AppColors.primaryColor : AppColors.lightTextFieldHintColor,
              ),
              value: item,
              groupValue: _selectedItem,
              onChanged: (value) {
                setState(() => _selectedItem = value);
                widget.onItemSelected(value!);
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
