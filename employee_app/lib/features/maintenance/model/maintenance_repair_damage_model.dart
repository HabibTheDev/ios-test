import 'package:flutter/widgets.dart';

import '../../../core/constants/car_parts_list.dart';
import '../../../core/constants/inspection_maps.dart';
import '../../../shared/utils/app_toast.dart';

class MaintenanceRepairDamageModel {
  final String? sectionName;
  final String? svgImagePath;
  final List<DamageList>? damageList;

  MaintenanceRepairDamageModel({
    this.sectionName,
    this.svgImagePath,
    this.damageList,
  });

  factory MaintenanceRepairDamageModel.fromJson(Map<String, dynamic> json) => MaintenanceRepairDamageModel(
        sectionName: json["sectionName"],
        svgImagePath: json["svgImagePath"],
        damageList: json["damageList"] == null
            ? []
            : List<DamageList>.from(json["damageList"]!.map((x) => DamageList.fromJson(x))),
      );

  static List<MaintenanceRepairDamageModel>? parseMaintenanceDamage({required dynamic damageDataList}) {
    try {
      final List<Map<String, dynamic>> sectionMapList = [];

      for (var sectionGroup in CarPartsList.carSectionGroupList) {
        final List<Map<String, dynamic>> damageMapList = [];
        for (var part in sectionGroup.parts) {
          final List<Map<String, dynamic>> partAreaList = [];
          for (var damageData in damageDataList) {
            if (part.toLowerCase() == damageData['bodyDamage']['part'].toLowerCase()) {
              partAreaList.add(damageData);
            }
          }
          if (partAreaList.isNotEmpty) {
            final String? partName = InspectionMaps.carPartMap[part];
            damageMapList.add({"partName": partName, "partAreaList": partAreaList});
          }
        }
        if (damageMapList.isNotEmpty) {
          sectionMapList.add({
            "sectionName": sectionGroup.sectionName,
            "svgImagePath": sectionGroup.svgImagePath,
            "damageList": damageMapList,
          });
        }
      }
      final result =
          List<MaintenanceRepairDamageModel>.from(sectionMapList.map((x) => MaintenanceRepairDamageModel.fromJson(x)));
      if (result.isNotEmpty) return result;
    } catch (error) {
      showToast('Damage parsing error');
      debugPrint(error.toString());
    }
    return null;
  }
}

class DamageList {
  final String? partName;
  final List<PartAreaList>? partAreaList;

  DamageList({
    this.partName,
    this.partAreaList,
  });

  factory DamageList.fromJson(Map<String, dynamic> json) => DamageList(
        partName: json["partName"],
        partAreaList: json["partAreaList"] == null
            ? []
            : List<PartAreaList>.from(json["partAreaList"]!.map((x) => PartAreaList.fromJson(x))),
      );
}

class PartAreaList {
  final int? id;
  final int? damageId;
  final bool? isRepaired;
  final DateTime? repairDate;
  final dynamic repairMethod;
  final int? requestMaintanainanceId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final BodyDamage? bodyDamage;

  PartAreaList({
    this.id,
    this.damageId,
    this.isRepaired,
    this.repairDate,
    this.repairMethod,
    this.requestMaintanainanceId,
    this.createdAt,
    this.updatedAt,
    this.bodyDamage,
  });

  factory PartAreaList.fromJson(Map<String, dynamic> json) => PartAreaList(
        id: json["id"],
        damageId: json["damageId"],
        isRepaired: json["isRepaired"],
        repairDate: json["repairDate"] == null ? null : DateTime.parse(json["repairDate"]),
        repairMethod: json["repairMethod"],
        requestMaintanainanceId: json["requestMaintanainanceId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        bodyDamage: json["bodyDamage"] == null ? null : BodyDamage.fromJson(json["bodyDamage"]),
      );
}

class BodyDamage {
  final int? id;
  final String? partArea;
  final String? partName;
  final String? bodyDamagePart;
  final String? type;
  final int? count;
  final String? severity;
  final String? slug;
  final String? recommendation;
  final String? image;
  final bool? isCurrent;
  final String? inspectionReportId;
  final bool? isNew;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic requestMaintanainanceId;
  bool checkValue;

  BodyDamage(
      {this.id,
      this.partArea,
      this.partName,
      this.bodyDamagePart,
      this.type,
      this.count,
      this.severity,
      this.slug,
      this.recommendation,
      this.image,
      this.isCurrent,
      this.inspectionReportId,
      this.isNew,
      this.createdAt,
      this.updatedAt,
      this.requestMaintanainanceId,
      this.checkValue = false});

  factory BodyDamage.fromJson(Map<String, dynamic> json) => BodyDamage(
        id: json["id"],
        partArea: json["partArea"],
        partName: json["partName"],
        bodyDamagePart: json["part"],
        type: json["type"],
        count: json["count"],
        severity: json["severity"],
        slug: json["slug"],
        recommendation: json["recommendation"],
        image: json["image"],
        isCurrent: json["isCurrent"],
        inspectionReportId: json["inspectionReportId"],
        isNew: json["isNew"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        requestMaintanainanceId: json["requestMaintanainanceId"],
      );
}
