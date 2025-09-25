import 'package:flutter/material.dart';

class IncidentLocationModel {
  final String locationName;
  final TextEditingController? provinceOrState;
  final TextEditingController? addressOrLocation;
  String? country;
  int radioValue;

  IncidentLocationModel(
      {required this.locationName,
      this.country,
      this.provinceOrState,
      this.addressOrLocation,
      required this.radioValue});

  static final List<IncidentLocationModel> locationList = [
    IncidentLocationModel(locationName: 'Home', radioValue: 0),
    IncidentLocationModel(
      locationName: 'Somewhere else',
      radioValue: 1,
      provinceOrState: TextEditingController(),
      addressOrLocation: TextEditingController(),
    ),
    IncidentLocationModel(locationName: 'Unknown', radioValue: 2),
  ];

  IncidentLocationModel copyWith({
    String? locationName,
    String? country,
    TextEditingController? provinceOrState,
    TextEditingController? addressOrLocation,
    int? radioValue,
  }) {
    return IncidentLocationModel(
      locationName: locationName ?? this.locationName,
      country: country ?? this.country,
      provinceOrState: provinceOrState ?? this.provinceOrState,
      addressOrLocation: addressOrLocation ?? this.addressOrLocation,
      radioValue: radioValue ?? this.radioValue,
    );
  }
}
