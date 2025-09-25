import 'package:get/get_rx/get_rx.dart';

class DamageCustomizationModel {
  int? id;
  int? carId;
  int? count;
  String? inspectionReportId;
  String? part;
  String? partName;
  String? partArea;
  String? image;
  Rx<String?> type;
  Rx<String?> severity;
  Rx<String?> recommendation;
  Rx<String?> imagePath;

  DamageCustomizationModel({
    this.id,
    this.inspectionReportId,
    this.carId,
    this.part,
    this.partName,
    this.partArea,
    this.count,
    this.image,
    String? type,
    String? severity,
    String? recommendation,
    String? imagePath,
  }) : type = type.obs,
       severity = severity.obs,
       recommendation = recommendation.obs,
       imagePath = imagePath.obs;

  DamageCustomizationModel copyWith({
    int? id,
    int? carId,
    int? count,
    String? inspectionReportId,
    String? part,
    String? partName,
    String? partArea,
    String? type,
    String? image,
    String? severity,
    String? recommendation,
    String? imagePath,
  }) {
    return DamageCustomizationModel(
      id: id ?? this.id,
      inspectionReportId: inspectionReportId ?? this.inspectionReportId,
      carId: carId ?? this.carId,
      part: part ?? this.part,
      partName: partName ?? this.partName,
      partArea: partArea ?? this.partArea,
      count: count ?? this.count,
      image: image ?? this.image,
      type: type ?? this.type.value,
      severity: severity ?? this.severity.value,
      recommendation: recommendation ?? this.recommendation.value,
      imagePath: imagePath ?? this.imagePath.value,
    );
  }
}
