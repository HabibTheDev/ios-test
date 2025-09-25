import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../shared/enums/enums.dart';

class CarRunningStepModel {
  final CarRunningStep carRunningStep;
  final String svgImagePath;
  final RxList<File> images;
  final TextEditingController notes;
  final List<CarRunningStepQuestionModel> questions;
  final String? instructionTitle;
  final List<String>? instructionList;

  CarRunningStepModel({
    required this.carRunningStep,
    required this.svgImagePath,
    required this.questions,
    required List<File> images,
    required this.notes,
    this.instructionTitle,
    this.instructionList,
  }) : images = images.obs;

  // Deep copy function
  CarRunningStepModel copy() {
    return CarRunningStepModel(
      carRunningStep: carRunningStep,
      svgImagePath: svgImagePath,
      images: [...images], // Shallow copy is enough since File is immutable
      notes: TextEditingController(text: notes.text),
      instructionTitle: instructionTitle,
      instructionList: instructionList,
      questions: questions.map((q) => q.copy()).toList(),
    );
  }

  static final List<CarRunningStepModel> carRunningSteps = [
    CarRunningStepModel(
      carRunningStep: CarRunningStep.driveCar,
      svgImagePath: Assets.assetsSvgDriveCar,
      instructionTitle: 'Notice the followings',
      instructionList: [
        'Acceleration',
        'Braking',
        'Steering',
        'Transmission',
        'Suspension',
        'Car alignment while driving',
        'Cruise control',
      ],
      images: [],
      notes: TextEditingController(),
      questions: [],
    ),
    CarRunningStepModel(
      carRunningStep: CarRunningStep.shareObservations,
      svgImagePath: Assets.assetsSvgGeneralSearchPrimary,
      images: [File('')],
      notes: TextEditingController(),
      questions: [
        CarRunningStepQuestionModel(question: 'Was the acceleration smooth?'),
        CarRunningStepQuestionModel(question: 'Was the brake performing well?'),
        CarRunningStepQuestionModel(question: 'Was the steering smooth and aligned?'),
        CarRunningStepQuestionModel(question: 'Was the transmission performing smooth?'),
        CarRunningStepQuestionModel(question: 'Was the suspension smooth?'),
        CarRunningStepQuestionModel(question: 'Was there any weird noise while driving?'),
        CarRunningStepQuestionModel(question: 'Did the vehicle drive straight with proper alignment?'),
        CarRunningStepQuestionModel(question: 'Was the cruise control performing well?'),
      ],
    ),
  ];
}

class CarRunningStepQuestionModel {
  final String question;
  final RxInt answerRadioValue;

  CarRunningStepQuestionModel({
    required this.question,
    int answer = -1,
  }) : answerRadioValue = RxInt(answer);

  // Copy method
  CarRunningStepQuestionModel copy() {
    return CarRunningStepQuestionModel(
      question: question,
      answer: answerRadioValue.value,
    );
  }
}
