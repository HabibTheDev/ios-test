import 'package:flutter/material.dart';

class TheftVandalismModel {
  final String? issue;
  final String? description;
  final TextEditingController? customIssue;
  int radioValue;

  TheftVandalismModel({required this.radioValue, required this.issue, this.customIssue, this.description});

  static List<TheftVandalismModel> issueRadioList = [
    TheftVandalismModel(
      issue: 'Vehicle stolen',
      radioValue: 0,
    ),
    TheftVandalismModel(
      issue: 'Vehicle stolen and found',
      radioValue: 1,
    ),
    TheftVandalismModel(
      issue: 'Stolen parts or equipments',
      description: 'Vehicle parts, equipment, accessories, and other car-related items',
      radioValue: 2,
    ),
    TheftVandalismModel(
      issue: 'Attempted break-in',
      description: 'Damaged glass or broken locks, whether or not personal items were stolen',
      radioValue: 3,
    ),
    TheftVandalismModel(
      issue: 'Vandalism',
      description: 'Graffiti, key scratches, broken glass, etc.',
      radioValue: 4,
    ),
    TheftVandalismModel(
      issue: 'Others',
      customIssue: TextEditingController(),
      radioValue: 5,
    ),
  ];

  TheftVandalismModel copyWith({
    String? issue,
    String? description,
    TextEditingController? customIssue,
    int? radioValue,
  }) {
    return TheftVandalismModel(
      issue: issue ?? this.issue,
      description: description ?? this.description,
      customIssue: customIssue ?? this.customIssue,
      radioValue: radioValue ?? this.radioValue,
    );
  }
}
