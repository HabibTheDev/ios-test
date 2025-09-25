import 'package:flutter/material.dart';
import '../../../../shared/widgets/text_widget.dart';
import '../../../../core/constants/app_color.dart';
import '../../model/city_model.dart';

class LocationRadioListWidget extends StatefulWidget {
  const LocationRadioListWidget({super.key, required this.locations, required this.onLocationSelected});
  final List<CityModel> locations;
  final ValueChanged<CityModel> onLocationSelected;

  @override
  State<LocationRadioListWidget> createState() => _LocationRadioListWidgetState();
}

class _LocationRadioListWidgetState extends State<LocationRadioListWidget> {
  CityModel? _selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.locations.map((location) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: AppColors.lightBorderColor, width: 1)),
          child: Theme(
            data: ThemeData(unselectedWidgetColor: Colors.red),
            child: RadioListTile<CityModel>(
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              title: SmallText(
                text: location.city ?? 'N/A',
                textColor: AppColors.lightSecondaryTextColor,
              ),
              fillColor: WidgetStateProperty.resolveWith<Color>(
                (states) => _selectedLocation == location ? AppColors.primaryColor : AppColors.lightTextFieldHintColor,
              ),
              value: location,
              groupValue: _selectedLocation,
              onChanged: (value) {
                setState(() {
                  _selectedLocation = value;
                });
                widget.onLocationSelected(value!);
              },
            ),
          ),
        );
      }).toList(),
    );
  }
}
