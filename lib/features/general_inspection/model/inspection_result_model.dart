import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InspectionResultModel {
  final String title;
  final RxInt answerRadioValue;
  final RxList<File> images;
  final TextEditingController notes;

  InspectionResultModel({required this.title, int answer = -1, required List<File> images, required this.notes})
      : answerRadioValue = RxInt(answer),
        images = RxList<File>.from(images);

  // Copy method
  InspectionResultModel copy() {
    return InspectionResultModel(title: title, answer: answerRadioValue.value, images: images, notes: notes);
  }

  static final List<InspectionResultModel> steps = [
    InspectionResultModel(title: 'Engine oil', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'Oil filter', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'Air filter', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'Cabin air filter', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'Spark plug', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'Ignition coil', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'Fuel injector', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'PCV valve', images: [File('')], notes: TextEditingController()),
    InspectionResultModel(title: 'Turbocharger or supercharger', images: [File('')], notes: TextEditingController()),
  ];
}
