import 'package:flutter/material.dart';

class IncidentVehicleLocationModel {
  final String locationName;
  final TextEditingController? nameController;
  final TextEditingController? addressController;
  int radioValue;

  IncidentVehicleLocationModel(
      {required this.locationName, this.nameController, this.addressController, required this.radioValue});

  static final List<IncidentVehicleLocationModel> damageLocationList = [
    IncidentVehicleLocationModel(
        locationName: 'Repair shop',
        nameController: TextEditingController(),
        addressController: TextEditingController(),
        radioValue: 0),
    IncidentVehicleLocationModel(locationName: 'Somewhere else', radioValue: 1),
    IncidentVehicleLocationModel(locationName: 'Unknown', radioValue: 2),
  ];
  static final List<IncidentVehicleLocationModel> weatherAndNone = [
    IncidentVehicleLocationModel(locationName: 'Tow yard', radioValue: 0),
    IncidentVehicleLocationModel(
        locationName: 'Repair shop',
        nameController: TextEditingController(),
        addressController: TextEditingController(),
        radioValue: 1),
    IncidentVehicleLocationModel(locationName: 'Home', radioValue: 2),
    IncidentVehicleLocationModel(locationName: 'Somewhere else', radioValue: 3),
    IncidentVehicleLocationModel(locationName: 'Unknown', radioValue: 4),
  ];

  IncidentVehicleLocationModel copyWith({
    String? locationName,
    TextEditingController? nameController,
    TextEditingController? addressController,
    int? radioValue,
  }) {
    return IncidentVehicleLocationModel(
      locationName: locationName ?? this.locationName,
      nameController: nameController ?? this.nameController,
      addressController: addressController ?? this.addressController,
      radioValue: radioValue ?? this.radioValue,
    );
  }
}
