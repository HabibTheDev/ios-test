import 'dart:io';

import '../../../shared/enums/enums.dart';

class InspectionArgumentsModel {
  final String? title;
  final String? returnScreen;
  final int? taskId;
  final int? carID;
  final int? contactID;
  final int? taskStepId;
  final String? vin;
  final String? extractedVin;
  final InspectionTypeEnum? inspectionType;
  final CaptureFileModel? captureFileModel;
  final InspectionCaptureTypeEnum? inspectionCaptureTypeEnum;
  final String? damageResponse;

  InspectionArgumentsModel({
    required this.title,
    required this.returnScreen,
    required this.taskId,
    required this.carID,
    required this.contactID,
    required this.taskStepId,
    required this.inspectionType,
    required this.vin,
    this.extractedVin,
    this.captureFileModel,
    this.inspectionCaptureTypeEnum,
    this.damageResponse,
  });

  InspectionArgumentsModel copyWith({
    String? title,
    String? returnScreen,
    int? taskId,
    int? carID,
    int? contactID,
    int? taskStepId,
    String? vin,
    String? extractedVin,
    InspectionTypeEnum? inspectionType,
    CaptureFileModel? captureFileModel,
    InspectionCaptureTypeEnum? inspectionCaptureTypeEnum,
    String? damageResponse,
  }) {
    return InspectionArgumentsModel(
      title: title ?? this.title,
      returnScreen: returnScreen ?? this.returnScreen,
      taskId: taskId ?? this.taskId,
      carID: carID ?? this.carID,
      contactID: contactID ?? this.contactID,
      taskStepId: taskStepId ?? this.taskStepId,
      inspectionType: inspectionType ?? this.inspectionType,
      vin: vin ?? this.vin,
      extractedVin: extractedVin ?? this.extractedVin,
      captureFileModel: captureFileModel ?? this.captureFileModel,
      inspectionCaptureTypeEnum: inspectionCaptureTypeEnum ?? this.inspectionCaptureTypeEnum,
      damageResponse: damageResponse ?? this.damageResponse,
    );
  }

  @override
  String toString() {
    return 'InspectionArgumentsModel(\ntitle: $title,\n'
        'returnScreen: $returnScreen,\n'
        'taskId: $taskId,\n'
        'carID: $carID,\n'
        'contactID: $contactID,\n'
        'taskStepId: $taskStepId,\n'
        'inspectionType: ${inspectionType?.value},\n'
        'vin: $vin,\n'
        'extractedVin: $extractedVin,\n'
        'inspectionCaptureTypeEnum: ${inspectionCaptureTypeEnum?.value}),\n'
        'captureFileModel: (${captureFileModel?.leftSideImage?.path}, \n${captureFileModel?.frontSideImage?.path}, \n${captureFileModel?.rightSideImage?.path}, \n${captureFileModel?.rearSideImage?.path}, \n${captureFileModel?.licensePlateImage?.path}, \n${captureFileModel?.odometerImage?.path}, \n${captureFileModel?.doorVINStickerImage?.path})\n'
        'damageResponse: $damageResponse)\n';
  }
}

class CaptureFileModel {
  final File? leftSideImage;
  final File? frontSideImage;
  final File? rightSideImage;
  final File? rearSideImage;
  final File? licensePlateImage;
  final File? odometerImage;
  final File? doorVINStickerImage;

  CaptureFileModel({
    this.licensePlateImage,
    this.odometerImage,
    this.doorVINStickerImage,
    this.leftSideImage,
    this.frontSideImage,
    this.rightSideImage,
    this.rearSideImage,
  });

  CaptureFileModel copyWith({
    File? licensePlateImage,
    File? odometerImage,
    File? doorVINStickerImage,
    File? leftSideImage,
    File? frontSideImage,
    File? rightSideImage,
    File? rearSideImage,
  }) {
    return CaptureFileModel(
      licensePlateImage: licensePlateImage ?? this.licensePlateImage,
      odometerImage: odometerImage ?? this.odometerImage,
      doorVINStickerImage: doorVINStickerImage ?? this.doorVINStickerImage,
      leftSideImage: leftSideImage ?? this.leftSideImage,
      frontSideImage: frontSideImage ?? this.frontSideImage,
      rightSideImage: rightSideImage ?? this.rightSideImage,
      rearSideImage: rearSideImage ?? this.rearSideImage,
    );
  }
}
