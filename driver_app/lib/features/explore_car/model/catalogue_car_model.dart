import 'dart:convert';

List<CatalogueCarModel> catalogueCarModelFromJson(String str) =>
    List<CatalogueCarModel>.from(json.decode(str).map((x) => CatalogueCarModel.fromJson(x)));

class CatalogueCarModel {
  final int? id;
  final String? catalogueName;
  final int? totalCarCount;
  final VehicleExample? vehicleExample;
  final int? startingSubscriptionCharge;

  CatalogueCarModel({
    this.id,
    this.catalogueName,
    this.totalCarCount,
    this.vehicleExample,
    this.startingSubscriptionCharge,
  });

  factory CatalogueCarModel.fromJson(Map<String, dynamic> json) => CatalogueCarModel(
        id: json["id"],
        catalogueName: json["catalogue_name"],
        totalCarCount: json["totalCarCount"],
        vehicleExample: json["vehicleExample"] == null ? null : VehicleExample.fromJson(json["vehicleExample"]),
        startingSubscriptionCharge: json["startingSubscriptionCharge"],
      );

  CatalogueCarModel copyWith({
    int? id,
    String? catalogueName,
    int? totalCarCount,
    VehicleExample? vehicleExample,
    int? startingSubscriptionCharge,
  }) {
    return CatalogueCarModel(
      id: id ?? this.id,
      catalogueName: catalogueName ?? this.catalogueName,
      totalCarCount: totalCarCount ?? this.totalCarCount,
      vehicleExample: vehicleExample ?? this.vehicleExample,
      startingSubscriptionCharge: startingSubscriptionCharge ?? this.startingSubscriptionCharge,
    );
  }
}

class VehicleExample {
  final int? id;
  final String? model;
  final String? make;
  final int? year;
  final String? images;

  VehicleExample({
    this.id,
    this.model,
    this.make,
    this.year,
    this.images,
  });

  factory VehicleExample.fromJson(Map<String, dynamic> json) => VehicleExample(
        id: json["id"],
        model: json["model"],
        make: json["make"],
        year: json["year"],
        images: json["images"],
      );

  VehicleExample copyWith({
    int? id,
    String? model,
    String? make,
    int? year,
    String? images,
  }) {
    return VehicleExample(
      id: id ?? this.id,
      model: model ?? this.model,
      make: make ?? this.make,
      year: year ?? this.year,
      images: images ?? this.images,
    );
  }
}
