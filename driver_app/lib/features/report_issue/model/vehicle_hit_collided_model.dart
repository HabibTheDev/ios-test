import 'package:flutter/material.dart';

class VehicleHitCollidedModel {
  final String? issue;
  final TextEditingController? customIssue;
  int radioValue;

  VehicleHitCollidedModel({required this.radioValue, required this.issue, this.customIssue});

  static List<VehicleHitCollidedModel> issueRadioList = [
    VehicleHitCollidedModel(
      issue: 'Another vehicle',
      radioValue: 0,
    ),
    VehicleHitCollidedModel(
      issue: 'Animal',
      radioValue: 1,
    ),
    VehicleHitCollidedModel(
      issue: 'Drove into the curb, sidewalk or ditch',
      radioValue: 2,
    ),
    VehicleHitCollidedModel(
      issue: 'Tree',
      radioValue: 3,
    ),
    VehicleHitCollidedModel(
      issue: 'Drove over a pothole',
      radioValue: 4,
    ),
    VehicleHitCollidedModel(
      issue: 'Cyclist',
      radioValue: 5,
    ),
    VehicleHitCollidedModel(
      issue: 'Pedestrian',
      radioValue: 6,
    ),
    VehicleHitCollidedModel(
      issue: 'Others',
      customIssue: TextEditingController(),
      radioValue: 7,
    ),
  ];

  VehicleHitCollidedModel copyWith({
    String? issue,
    String? description,
    TextEditingController? customIssue,
    int? radioValue,
  }) {
    return VehicleHitCollidedModel(
      issue: issue ?? this.issue,
      customIssue: customIssue ?? this.customIssue,
      radioValue: radioValue ?? this.radioValue,
    );
  }
}
