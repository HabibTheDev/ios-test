import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/car_parts_list.dart';
import '../../../core/constants/damage_diagram_map.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/inspection_maps.dart';
import '../../../features/inspection/model/damage_parts_svg_model.dart';
import '../../../features/inspection/model/inspection_report_model.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../../features/maintenance/model/maintenance_repair_damage_model.dart';
import '../../repository/remote/inspection_repo.dart';
import '../../utils/app_toast.dart';
import '../../api/api_exception.dart';
import '../../api/api_imports.dart';

class InspectionService extends ApiClient implements InspectionRepo {
  @override
  Future<String?> detectDamage({required Map<String, String?> filePathsMap}) async {
    try {
      final Response response = await aiMultipartPostRequest(
        path: ApiEndpoint.aiDetectDamage,
        filePathsMap: filePathsMap,
      );
      final String jsonString = jsonEncode(response.data);
      return jsonString;
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return null;
  }

  @override
  Future<InspectionReportModel?> putExteriorDamageReport({
    required String endPoint,
    required int carID,
    required Map<String, String?> filePathsMap,
    required String data,
  }) async {
    try {
      final response = await aiMultipartPutRequest(path: '$endPoint/$carID', filePathsMap: filePathsMap, data: data);

      if (response.data['data'] != null && response.data['data']['bodyDamages'].isNotEmpty) {
        var data = response.data['data'];
        var reportOverviewMapData = data;

        final damagesMap = data?['bodyDamages'];
        reportOverviewMapData.remove('bodyDamages');

        final List<Map<String, dynamic>> sectionDataMapList = [];

        damagesMap.forEach((sectionKey, sectionValue) {
          final List<Map<String, dynamic>> reportDataMapList = [];
          for (var carPart in InspectionMaps.carSectionListMap[sectionKey] ?? []) {
            final List<dynamic> matchingParts = [];

            for (var e in sectionValue) {
              if (e['part'] == carPart) {
                matchingParts.add(e);
              }
            }
            final String? partName = InspectionMaps.carPartMap[carPart];
            if (matchingParts.isNotEmpty) {
              reportDataMapList.add({
                "partName": partName,
                "part": carPart,
                "partAreaList": matchingParts
                    .map(
                      (item) => {
                        "id": item["id"],
                        "area": item["partArea"], // Left side, Right side
                        "partName": partName, // Fender, Arch panel
                        "part": item["part"],
                        "type": item["type"], // Scratch, Dents
                        "count": item["count"],
                        "severity": item["severity"],
                        "recommendation": item["recommendation"],
                        "image": item["image"],
                        "images": item["images"],
                        "isCurrent": item["isCurrent"],
                        "inspectionReportId": item["inspectionReportId"],
                        "requestMaintanainanceId": item["requestMaintanainanceId"],
                        "isNew": item["isNew"],
                      },
                    )
                    .toList(),
              });
            } else {
              reportDataMapList.add({"partName": partName, "part": carPart, "partAreaList": []});
            }
          }
          sectionDataMapList.add({
            "sectionName": InspectionMaps.carSectionNameMap[sectionKey], // Car body, Door, Window
            "svgImagePath": InspectionMaps.carSectionSvgMap[sectionKey],
            "partsCount": reportDataMapList.length,
            "healthPercent": reportOverviewMapData[sectionKey],
            "damageList": reportDataMapList,
          });
        });
        final finalResponse = {"reportOverview": reportOverviewMapData, "carSectionReports": sectionDataMapList};
        InspectionReportModel inspectionReportModel = inspectionReportModelFromJson(jsonEncode(finalResponse));
        return inspectionReportModel;
      }
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error, stacktrace) {
      showToast(error.toString());
      debugPrint(error.toString());
      debugPrint('stacktrace: $stacktrace');
    }
    return null;
  }

  @override
  Future<InspectionReportModel?> getExteriorInspectionReport({
    required String endPoint,
    required int carID,
    required String inspectionStatus,
  }) async {
    try {
      final response = await getRequest(path: '$endPoint/$carID', queryParameters: {'status': inspectionStatus});

      if (response.data['data']?['inspectionReport']?['bodyDamages'] != null) {
        var reportOverviewMapData = response.data['data']?['inspectionReport'];
        reportOverviewMapData['employee'] = response.data['data']?['employee'];

        final damagesMap = reportOverviewMapData['bodyDamages'];
        reportOverviewMapData.remove('bodyDamages');

        final List<Map<String, dynamic>> sectionDataMapList = [];

        final Map<String, DamagePartsSvgModel> carPartsSvgMap = DamageDiagramMap.partsMap;
        DamageDiagramMap.partsMap.updateAll((key, value) => value.copyWith(severity: []));

        damagesMap.forEach((sectionKey, sectionValue) {
          final List<Map<String, dynamic>> reportDataMapList = [];
          for (var carPart in InspectionMaps.carSectionListMap[sectionKey] ?? []) {
            final List<dynamic> matchingParts = [];

            for (var e in sectionValue) {
              if (e['part'] == carPart) {
                matchingParts.add(e);

                // Add severity to car-parts-svg-map
                DamageDiagramMap.partsMap.forEach((key, value) {
                  if (key == e['part']) {
                    // Check not null
                    if (e['severity'] != null) {
                      List<String>? severityList = [];
                      for (int i = 0; i < e['count']; i++) {
                        severityList.add(e['severity']);
                      }
                      severityList.addAll(carPartsSvgMap[key]!.severity);
                      carPartsSvgMap[key] = carPartsSvgMap[key]!.copyWith(severity: severityList);
                    }
                  }
                });
              }
            }
            final String? partName = InspectionMaps.carPartMap[carPart];
            if (matchingParts.isNotEmpty) {
              reportDataMapList.add({
                "partName": partName,
                "part": carPart,
                "partAreaList": matchingParts
                    .map(
                      (item) => {
                        "id": item["id"],
                        "area": item["partArea"], // Left side, Right side
                        "partName": partName, // Fender, Arch panel
                        "part": item["part"],
                        "type": item["type"], // Scratch, Dents
                        "count": item["count"],
                        "severity": item["severity"],
                        "recommendation": item["recommendation"],
                        "image": item["image"],
                        "images": item["images"],
                        "isCurrent": item["isCurrent"],
                        "inspectionReportId": item["inspectionReportId"],
                        "requestMaintanainanceId": item["requestMaintanainanceId"],
                        "isNew": item["isNew"],
                      },
                    )
                    .toList(),
              });
            } else {
              reportDataMapList.add({"partName": partName, "part": carPart, "partAreaList": []});
            }
          }
          sectionDataMapList.add({
            "sectionName": InspectionMaps.carSectionNameMap[sectionKey], // Car body, Door, Window
            "svgImagePath": InspectionMaps.carSectionSvgMap[sectionKey],
            "partsCount": reportDataMapList.length,
            "healthPercent": reportOverviewMapData[sectionKey],
            "damageList": reportDataMapList,
          });
        });
        final finalResponse = {"reportOverview": reportOverviewMapData, "carSectionReports": sectionDataMapList};
        InspectionReportModel inspectionReportModel = inspectionReportModelFromJson(jsonEncode(finalResponse));
        inspectionReportModel = inspectionReportModel.copyWith(carPartsSvgMap: carPartsSvgMap);
        return inspectionReportModel;
      }
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error, stacktrace) {
      showToast(error.toString());
      debugPrint(error.toString());
      debugPrint('stacktrace: $stacktrace');
    }
    return null;
  }

  @override
  Future<InspectionReportModel?> getFinalReport({required int carID, required int contractID}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.finalSummaryReport}/$carID/$contractID');

      if (response.data['data'] != null && response.data['data']['bodyDamages'].isNotEmpty) {
        var reportOverviewMapData = response.data['data'];
        final damagesMap = reportOverviewMapData['bodyDamages'];
        reportOverviewMapData.remove('bodyDamages');

        final List<Map<String, dynamic>> sectionDataMapList = [];

        damagesMap.forEach((sectionKey, sectionValue) {
          final List<Map<String, dynamic>> reportDataMapList = [];
          for (var carPart in InspectionMaps.carSectionListMap[sectionKey] ?? []) {
            final List<dynamic> matchingParts = [];

            for (var e in sectionValue) {
              if (e['part'].toLowerCase() == carPart.toLowerCase()) {
                matchingParts.add(e);
              }
            }

            final String? partName = InspectionMaps.carPartMap[carPart];
            if (matchingParts.isNotEmpty) {
              reportDataMapList.add({
                "partName": partName,
                "part": carPart,
                "partAreaList": matchingParts
                    .map(
                      (item) => {
                        "id": item["id"],
                        "area": item["partArea"],
                        "partName": partName,
                        "part": item["part"],
                        "type": item["type"],
                        "count": item["count"],
                        "severity": item["severity"],
                        "recommendation": item["recommendation"],
                        "image": item["image"],
                        "images": item["images"],
                        "isCurrent": item["isCurrent"],
                        "inspectionReportId": item["inspectionReportId"],
                        "requestMaintanainanceId": item["requestMaintanainanceId"],
                        "isNew": item["isNew"],
                      },
                    )
                    .toList(),
              });
            } else {
              reportDataMapList.add({"partName": partName, "part": carPart, "partAreaList": []});
            }
          }
          sectionDataMapList.add({
            "sectionName": InspectionMaps.carSectionNameMap[sectionKey],
            "svgImagePath": InspectionMaps.carSectionSvgMap[sectionKey],
            "partsCount": reportDataMapList.length,
            "healthPercent": reportOverviewMapData[sectionKey],
            "damageList": reportDataMapList,
          });
        });
        final finalResponse = {"reportOverview": reportOverviewMapData, "carSectionReports": sectionDataMapList};
        return inspectionReportModelFromJson(jsonEncode(finalResponse));
      }
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error, stacktrace) {
      showToast(error.toString());
      debugPrint(error.toString());
      debugPrint('stacktrace: $stacktrace');
    }
    return null;
  }

  @override
  Future<InspectionReportModel?> getCurrentDamageReport({required int carID}) async {
    try {
      final response = await getRequest(path: '${ApiEndpoint.getCurrentDamages}/$carID');

      if (response.data['data'] != null && response.data['data']['bodyDamages'].isNotEmpty) {
        var reportOverviewMapData = response.data['data'];
        final damagesMap = reportOverviewMapData['bodyDamages'];
        reportOverviewMapData.remove('bodyDamages');

        final List<Map<String, dynamic>> sectionDataMapList = [];

        damagesMap.forEach((sectionKey, sectionValue) {
          final List<Map<String, dynamic>> reportDataMapList = [];
          for (var carPart in InspectionMaps.carSectionListMap[sectionKey] ?? []) {
            final List<dynamic> matchingParts = [];

            for (var e in sectionValue) {
              if (e['part'].toLowerCase() == carPart.toLowerCase()) {
                matchingParts.add(e);
              }
            }

            final String? partName = InspectionMaps.carPartMap[carPart];
            if (matchingParts.isNotEmpty) {
              reportDataMapList.add({
                "partName": partName,
                "partAreaList": matchingParts
                    .map(
                      (item) => {
                        "id": item["id"],
                        "area": item["partArea"],
                        "partName": partName,
                        "part": item["part"],
                        "type": item["type"],
                        "count": item["count"],
                        "severity": item["severity"],
                        "recommendation": item["recommendation"],
                        "image": item["image"],
                        "images": item["images"],
                        "isCurrent": item["isCurrent"],
                        "inspectionReportId": item["inspectionReportId"],
                        "requestMaintanainanceId": item["requestMaintanainanceId"],
                        "isNew": item["isNew"],
                      },
                    )
                    .toList(),
              });
            } else {
              reportDataMapList.add({"partName": partName, "part": carPart, "partAreaList": []});
            }
          }
          sectionDataMapList.add({
            "sectionName": InspectionMaps.carSectionNameMap[sectionKey],
            "svgImagePath": InspectionMaps.carSectionSvgMap[sectionKey],
            "partsCount": reportDataMapList.length,
            "healthPercent": reportOverviewMapData[sectionKey],
            "damageList": reportDataMapList,
          });
        });
        final finalResponse = {"reportOverview": reportOverviewMapData, "carSectionReports": sectionDataMapList};
        return inspectionReportModelFromJson(jsonEncode(finalResponse));
      }
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error, stacktrace) {
      showToast(error.toString());
      debugPrint(error.toString());
      debugPrint('Stacktrace: $stacktrace');
    }
    return null;
  }

  @override
  List<MaintenanceRepairDamageModel> parseMaintenanceDamage({required dynamic damageDataList}) {
    try {
      final List<Map<String, dynamic>> sectionMapList = [];

      for (var sectionGroup in CarPartsList.carSectionGroupList) {
        final List<Map<String, dynamic>> damageMapList = [];
        for (var part in sectionGroup.parts) {
          final List<Map<String, dynamic>> partAreaList = [];
          final String? partName = InspectionMaps.carPartMap[part];
          for (var damageData in damageDataList) {
            if (part.toLowerCase() == damageData['bodyDamage']['part'].toLowerCase()) {
              partAreaList.add(damageData);
            }
          }
          damageMapList.add({"partName": partName, "partAreaList": partAreaList});
        }
        sectionMapList.add({
          "sectionName": sectionGroup.sectionName,
          "svgImagePath": sectionGroup.svgImagePath,
          "damageList": damageMapList,
        });
      }
      return List<MaintenanceRepairDamageModel>.from(
        sectionMapList.map((x) => MaintenanceRepairDamageModel.fromJson(x)),
      );
    } catch (error, stacktrace) {
      showToast(error.toString());
      debugPrint(error.toString());
      debugPrint('stacktrace: $stacktrace');
    }
    return [];
  }

  @override
  Future<String?> extractVin({required String filePath}) async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://vin-scan.fleetblox.com/',
        headers: {'Content-Type': 'multipart/form-data'},
        connectTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 2),
        receiveTimeout: const Duration(minutes: 2),
      ),
    );
    final FormData formData = FormData();

    try {
      // Prepare form data
      final MultipartFile multipartFile = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
      formData.files.add(MapEntry('image', multipartFile));

      final Response response = await dio.post(ApiEndpoint.vinData, data: formData);
      if (response.statusCode == 200) {
        if (response.data['message'] != null) showToast(response.data['message']);
        return response.data['result']?[0]?['barcode_data'];
      }
    } catch (error, stacktrace) {
      showToast(error.toString());
      debugPrint(error.toString());
      debugPrint('stacktrace: $stacktrace');
    }
    return null;
  }

  @override
  Future<bool> completeInspection({required Map<String, dynamic> payload}) async {
    try {
      final response = await postRequest(path: ApiEndpoint.detectDamage, body: payload);
      showToast(response.data['message']);
      return response.data['success'];
    } on ApiException catch (error) {
      showToast(error.message ?? AppString.unknownError);
      debugPrint(error.message ?? AppString.unknownError);
    } catch (error) {
      showToast(error.toString());
      debugPrint(error.toString());
    }
    return false;
  }
}
