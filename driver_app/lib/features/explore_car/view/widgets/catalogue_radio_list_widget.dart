import 'package:flutter/material.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/catalogue_car_model.dart';

class CatalogueRadioListWidget extends StatefulWidget {
  const CatalogueRadioListWidget({super.key, required this.catalogues, required this.onCatalogueSelected});
  final List<CatalogueCarModel> catalogues;
  final ValueChanged<CatalogueCarModel> onCatalogueSelected;

  @override
  State<CatalogueRadioListWidget> createState() => _CatalogueRadioListWidgetState();
}

class _CatalogueRadioListWidgetState extends State<CatalogueRadioListWidget> {
  CatalogueCarModel? _selectedCatalogue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.catalogues.map((catalogue) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: AppColors.lightBorderColor, width: 1)),
          child: Theme(
            data: ThemeData(unselectedWidgetColor: Colors.red),
            child: RadioListTile<CatalogueCarModel>(
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              title: SmallText(
                text: catalogue.catalogueName ?? 'N/A',
                textColor: AppColors.lightSecondaryTextColor,
              ),
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (states) =>
                    _selectedCatalogue == catalogue ? AppColors.primaryColor : AppColors.lightTextFieldHintColor,
              ),
              value: catalogue,
              groupValue: _selectedCatalogue,
              onChanged: (value) {
                setState(() {
                  _selectedCatalogue = value;
                });
                widget.onCatalogueSelected(value!);
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
