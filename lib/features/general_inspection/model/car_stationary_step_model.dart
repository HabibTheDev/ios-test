import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_assets.dart';
import '../../../shared/enums/enums.dart';

class CarStationaryStepModel {
  final CarStationaryStep carStationaryStep;
  final String svgImagePath;
  final RxList<File> images;
  final TextEditingController notes;
  final List<CarStationaryStepQuestionModel> questions;

  CarStationaryStepModel({
    required this.carStationaryStep,
    required this.svgImagePath,
    required this.questions,
    required List<File> images,
    required this.notes,
  }) : images = images.obs;

  // Deep copy function
  CarStationaryStepModel copy() {
    return CarStationaryStepModel(
      carStationaryStep: carStationaryStep,
      svgImagePath: svgImagePath,
      images: [...images], // Shallow copy is enough since File is immutable
      notes: TextEditingController(text: notes.text),
      questions: questions.map((q) => q.copy()).toList(),
    );
  }

  static final List<CarStationaryStepModel> carStationarySteps = [
    CarStationaryStepModel(
      carStationaryStep: CarStationaryStep.startEngineState,
      svgImagePath: Assets.assetsSvgGeneralEngine,
      images: [File('')],
      notes: TextEditingController(),
      questions: [
        CarStationaryStepQuestionModel(question: 'Did it start normally?'),
        CarStationaryStepQuestionModel(question: 'Did it have any battery issue / disturbance?'),
        CarStationaryStepQuestionModel(question: 'Are there any engine-related warning lights on the dashboard?'),
        CarStationaryStepQuestionModel(question: 'Was there any weird noise while starting?'),
      ],
    ),
    CarStationaryStepModel(
      carStationaryStep: CarStationaryStep.pressAndReleaseBrakeState,
      svgImagePath: Assets.assetsSvgGeneralBrake,
      images: [File('')],
      notes: TextEditingController(),
      questions: [
        CarStationaryStepQuestionModel(question: 'Did the brake feel firm? (not too soft or spongy)'),
        CarStationaryStepQuestionModel(question: 'Did the brake return smoothly?'),
        CarStationaryStepQuestionModel(question: 'Are there any brake- related warning lights on the dashboard?'),
      ],
    ),
    CarStationaryStepModel(
      carStationaryStep: CarStationaryStep.turnSteeringWheelLeftRightState,
      svgImagePath: Assets.assetsSvgGeneralSteering,
      images: [File('')],
      notes: TextEditingController(),
      questions: [
        CarStationaryStepQuestionModel(question: 'Did it feel smooth? (not stiff or not too loose)'),
        CarStationaryStepQuestionModel(question: 'Was there any weird noise while steering?'),
        CarStationaryStepQuestionModel(question: 'Is the steering wheel centered?'),
      ],
    ),
    CarStationaryStepModel(
      carStationaryStep: CarStationaryStep.changeGearState,
      svgImagePath: Assets.assetsSvgGeneralGear,
      images: [File('')],
      notes: TextEditingController(),
      questions: [
        CarStationaryStepQuestionModel(question: 'Did it feel smooth? (not stiff or not too loose)'),
        CarStationaryStepQuestionModel(question: 'Was there any weird noise while shifting?'),
      ],
    ),
  ];
}

class CarStationaryStepQuestionModel {
  final String question;
  final RxInt answerRadioValue;

  CarStationaryStepQuestionModel({
    required this.question,
    int answer = -1,
  }) : answerRadioValue = RxInt(answer);

  // Copy method
  CarStationaryStepQuestionModel copy() {
    return CarStationaryStepQuestionModel(
      question: question,
      answer: answerRadioValue.value,
    );
  }
}
