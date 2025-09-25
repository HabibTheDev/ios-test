import 'dart:convert';

import 'damage_parts_svg_model.dart';

InspectionReportModel inspectionReportModelFromJson(String str) => InspectionReportModel.fromJson(json.decode(str));

class InspectionReportModel {
  final ReportOverview? reportOverview;
  final List<CarSectionReport>? carSectionReports;
  final Map<String, DamagePartsSvgModel>? carPartsSvgMap;

  InspectionReportModel({this.reportOverview, this.carSectionReports, this.carPartsSvgMap});

  factory InspectionReportModel.fromJson(Map<String, dynamic> json) => InspectionReportModel(
    reportOverview: json["reportOverview"] == null ? null : ReportOverview.fromJson(json["reportOverview"]),
    carSectionReports: json["carSectionReports"] == null
        ? []
        : List<CarSectionReport>.from(json["carSectionReports"]!.map((x) => CarSectionReport.fromJson(x))),
  );

  InspectionReportModel copyWith({
    ReportOverview? reportOverview,
    List<CarSectionReport>? carSectionReports,
    Map<String, DamagePartsSvgModel>? carPartsSvgMap,
  }) {
    return InspectionReportModel(
      reportOverview: reportOverview ?? this.reportOverview,
      carSectionReports: carSectionReports ?? this.carSectionReports,
      carPartsSvgMap: carPartsSvgMap ?? this.carPartsSvgMap,
    );
  }
}

class CarSectionReport {
  final String? sectionName;
  final String? svgImagePath;
  final int? partsCount;
  final int? healthPercent;
  final List<DamageList>? damageList;

  CarSectionReport({this.sectionName, this.svgImagePath, this.partsCount, this.healthPercent, this.damageList});

  factory CarSectionReport.fromJson(Map<String, dynamic> json) => CarSectionReport(
    sectionName: json["sectionName"],
    svgImagePath: json["svgImagePath"],
    partsCount: json["partsCount"],
    healthPercent: json["healthPercent"],
    damageList: json["damageList"] == null
        ? []
        : List<DamageList>.from(json["damageList"]!.map((x) => DamageList.fromJson(x))),
  );
}

class DamageList {
  final String? partName;
  final String? part;
  final List<PartAreaList>? partAreaList;

  DamageList({this.partName, this.partAreaList, this.part});

  factory DamageList.fromJson(Map<String, dynamic> json) => DamageList(
    partName: json["partName"],
    part: json["part"],
    partAreaList: json["partAreaList"] == null
        ? []
        : List<PartAreaList>.from(json["partAreaList"]!.map((x) => PartAreaList.fromJson(x))),
  );
}

class PartAreaList {
  final int? id;
  final String? area;
  final String? partName;
  final String? part;
  final String? type;
  final int? count;
  final String? severity;
  final String? recommendation;
  final String? image;
  final List<String>? images;
  final bool? isCurrent;
  final String? inspectionReportId;
  final dynamic requestMaintanainanceId;
  final bool? isNew;
  bool checkValue;

  PartAreaList({
    this.id,
    this.area,
    this.partName,
    this.part,
    this.type,
    this.count,
    this.severity,
    this.recommendation,
    this.image,
    this.images,
    this.isCurrent,
    this.inspectionReportId,
    this.requestMaintanainanceId,
    this.isNew,
    this.checkValue = false,
  });

  factory PartAreaList.fromJson(Map<String, dynamic> json) => PartAreaList(
    id: json["id"],
    area: json["area"],
    partName: json["partName"],
    part: json["part"],
    type: json["type"],
    count: json["count"],
    severity: json["severity"],
    recommendation: json["recommendation"],
    image: json["image"],
    images: json["images"] != null ? List<String>.from(json["images"].map((x) => x)) : [],
    isCurrent: json["isCurrent"],
    inspectionReportId: json["inspectionReportId"],
    requestMaintanainanceId: json["requestMaintanainanceId"],
    isNew: json["isNew"],
  );
}

class ReportOverview {
  final String? id;
  final int? inspectedById;
  final int? brandId;
  final String? licensePlateImage;
  final String? odometerImage;
  final String? doorVinStickerImage;
  final String? frontSideImage;
  final String? rearSideImage;
  final String? leftSideImage;
  final String? rightSideImage;
  final double? odometerReading;
  final double? engineOilLife;
  final Fuel? fuel;
  final double? tirePressureBackLeft;
  final double? tirePressureBackRight;
  final double? tirePressureFrontLeft;
  final double? tirePressureFrontRight;
  final int? totalPartsDetected;
  final int? previousTotalPartsDetected;
  final int? totalDamagesDetected;
  final int? previousTotalDamageDetected;
  final int? totalMissingParts;
  final int? previousTotalMissingParts;
  final int? fullExteriorCondition;
  final int? leftSideHealth;
  final int? rightSideHealth;
  final int? frontHealth;
  final int? rearHealth;
  final int? contactId;
  final int? carId;
  final String? status;
  final String? inspectionType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final InspectedBy? inspectedBy;
  final ReporterEmployee? employee;

  ReportOverview({
    this.id,
    this.inspectedById,
    this.brandId,
    this.licensePlateImage,
    this.odometerImage,
    this.doorVinStickerImage,
    this.frontSideImage,
    this.rearSideImage,
    this.leftSideImage,
    this.rightSideImage,
    this.odometerReading,
    this.engineOilLife,
    this.fuel,
    this.tirePressureBackLeft,
    this.tirePressureBackRight,
    this.tirePressureFrontLeft,
    this.tirePressureFrontRight,
    this.totalPartsDetected,
    this.previousTotalPartsDetected,
    this.totalDamagesDetected,
    this.previousTotalDamageDetected,
    this.totalMissingParts,
    this.previousTotalMissingParts,
    this.fullExteriorCondition,
    this.leftSideHealth,
    this.rightSideHealth,
    this.frontHealth,
    this.rearHealth,
    this.contactId,
    this.carId,
    this.status,
    this.inspectionType,
    this.createdAt,
    this.updatedAt,
    this.inspectedBy,
    this.employee,
  });

  factory ReportOverview.fromJson(Map<String, dynamic> json) => ReportOverview(
    id: json["id"],
    inspectedById: json["inspectedById"],
    brandId: json["brandId"],
    licensePlateImage: json["licensePlateImage"],
    odometerImage: json["odometerImage"],
    doorVinStickerImage: json["doorVINStickerImage"],
    frontSideImage: json["frontSideImage"],
    rearSideImage: json["rearSideImage"],
    leftSideImage: json["leftSideImage"],
    rightSideImage: json["rightSideImage"],
    odometerReading: json["odometerReading"] != null ? double.parse('${json["odometerReading"]}') : 0.0,
    engineOilLife: double.tryParse('${json["engineOilLife"]}'),
    fuel: json["fuel"] == null ? null : Fuel.fromJson(json["fuel"]),
    tirePressureBackLeft: json["tirePressureBackLeft"],
    tirePressureBackRight: json["tirePressureBackRight"],
    tirePressureFrontLeft: json["tirePressureFrontLeft"],
    tirePressureFrontRight: json["tirePressureFrontRight"],
    totalPartsDetected: json["totalPartsDetected"],
    previousTotalPartsDetected: json["previousTotalPartsDetected"],
    totalDamagesDetected: json["totalDamagesDetected"],
    previousTotalDamageDetected: json["previousTotalDamageDetected"],
    totalMissingParts: json["totalMissingParts"],
    previousTotalMissingParts: json["previousTotalMissingParts"],
    fullExteriorCondition: json["fullExteriorCondition"],
    leftSideHealth: json["leftSideHealth"],
    rightSideHealth: json["rightSideHealth"],
    frontHealth: json["frontHealth"],
    rearHealth: json["rearHealth"],
    contactId: json["contactId"],
    carId: json["carId"],
    status: json["status"],
    inspectionType: json["inspectionType"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    inspectedBy: json["inspectedBy"] == null ? null : InspectedBy.fromJson(json["inspectedBy"]),
    employee: json["employee"] == null ? null : ReporterEmployee.fromJson(json["employee"]),
  );
}

class Fuel {
  final double? range;
  final double? amountRemaining;
  final double? percentRemaining;

  Fuel({this.range, this.amountRemaining, this.percentRemaining});

  factory Fuel.fromJson(Map<String, dynamic> json) => Fuel(
    range: json["range"]?.toDouble(),
    amountRemaining: json["amountRemaining"]?.toDouble(),
    percentRemaining: json["percentRemaining"]?.toDouble(),
  );
}

class InspectedBy {
  final dynamic fullName;
  final String? email;

  InspectedBy({this.fullName, this.email});

  factory InspectedBy.fromJson(Map<String, dynamic> json) =>
      InspectedBy(fullName: json["fullName"], email: json["email"]);
}

class ReporterEmployee {
  final int? id;
  final String? fullName;
  final String? email;
  final dynamic countryId;
  final int? phoneCountryId;
  final String? phone;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? address;
  final int? brandId;
  final dynamic companyInfo;
  final dynamic photo;
  final bool? verified;
  final bool? isActive;
  final dynamic notes;
  final int? locationId;
  final int? userId;
  final bool? needVerification;
  final String? taskStatus;
  final int? designationId;
  final DateTime? createdAt;
  final int? viewedBy;
  final bool? isDeleted;
  final dynamic passportId;
  final dynamic lisenceId;
  final dynamic verificationCode;

  ReporterEmployee({
    this.id,
    this.fullName,
    this.email,
    this.countryId,
    this.phoneCountryId,
    this.phone,
    this.gender,
    this.dateOfBirth,
    this.address,
    this.brandId,
    this.companyInfo,
    this.photo,
    this.verified,
    this.isActive,
    this.notes,
    this.locationId,
    this.userId,
    this.needVerification,
    this.taskStatus,
    this.designationId,
    this.createdAt,
    this.viewedBy,
    this.isDeleted,
    this.passportId,
    this.lisenceId,
    this.verificationCode,
  });

  factory ReporterEmployee.fromJson(Map<String, dynamic> json) => ReporterEmployee(
    id: json["id"],
    fullName: json["fullName"],
    email: json["email"],
    countryId: json["countryId"],
    phoneCountryId: json["phoneCountryId"],
    phone: json["phone"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    address: json["address"],
    brandId: json["brand_id"],
    companyInfo: json["companyInfo"],
    photo: json["photo"],
    verified: json["verified"],
    isActive: json["isActive"],
    notes: json["notes"],
    locationId: json["locationId"],
    userId: json["userId"],
    needVerification: json["needVerification"],
    taskStatus: json["TaskStatus"],
    designationId: json["designationId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    viewedBy: json["viewedBy"],
    isDeleted: json["isDeleted"],
    passportId: json["passportId"],
    lisenceId: json["lisenceId"],
    verificationCode: json["verificationCode"],
  );
}
