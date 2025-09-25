import 'dart:convert';

List<RegularServicingModel> regularServicingModelFromJson(String str) =>
    List<RegularServicingModel>.from(json.decode(str).map((x) => RegularServicingModel.fromJson(x)));

class RegularServicingModel {
  final int? id;
  final String? title;
  final String? category;
  final int? availableCheckListForMaintainanceId;
  final int? brandId;

  RegularServicingModel({
    this.id,
    this.title,
    this.category,
    this.availableCheckListForMaintainanceId,
    this.brandId,
  });

  factory RegularServicingModel.fromJson(Map<String, dynamic> json) => RegularServicingModel(
        id: json["id"],
        title: json["title"],
        category: json["category"],
        availableCheckListForMaintainanceId: json["availableCheckListForMaintainanceId"],
        brandId: json["brandId"],
      );
}
