import 'package:flutter/material.dart';

import '../../../shared/utils/enums.dart';

class IssueModel {
  final String? issue;
  final String? description;
  final TextEditingController? customIssue;
  final ReportIssueType? issueType;
  int radioValue;

  IssueModel({required this.radioValue, required this.issue, this.customIssue, this.description, this.issueType});

  static List<IssueModel> issueRadioList = [
    IssueModel(
      issue: 'Damaged or broken glass',
      description: 'Cracked or shattered windows and windshields from rocks or hail damage.',
      issueType: ReportIssueType.damageOrBroken,
      radioValue: 0,
    ),
    IssueModel(
      issue: 'Theft or vandalism',
      description: 'Vehicle stolen, damaged on purpose, or parts stolen.',
      issueType: ReportIssueType.theftOrVandalism,
      radioValue: 1,
    ),
    IssueModel(
      issue: 'Vehicle hit something or rolled over',
      description: 'Collided with another vehicle, person, tree, or object, or drove over a pothole.',
      issueType: ReportIssueType.vehicleHit,
      radioValue: 2,
    ),
    IssueModel(
      issue: 'Something collided or fell on my vehicle',
      description: 'Another vehicle, tree, debris etc.',
      issueType: ReportIssueType.collidedOrFell,
      radioValue: 3,
    ),
    IssueModel(
      issue: 'Weather or environmental damage',
      description: 'Hail, water, fire, rodents etc.',
      issueType: ReportIssueType.weatherDamage,
      radioValue: 4,
    ),
    IssueModel(
      issue: 'None of the above',
      customIssue: TextEditingController(),
      issueType: ReportIssueType.none,
      radioValue: 5,
    ),
  ];

  IssueModel copyWith({
    String? issue,
    String? description,
    TextEditingController? customIssue,
    ReportIssueType? issueType,
    int? radioValue,
  }) {
    return IssueModel(
      issue: issue ?? this.issue,
      description: description ?? this.description,
      customIssue: customIssue ?? this.customIssue,
      issueType: issueType ?? this.issueType,
      radioValue: radioValue ?? this.radioValue,
    );
  }
}
