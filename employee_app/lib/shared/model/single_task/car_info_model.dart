import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'active_car_info_location_model.dart';
import 'engine_model.dart';

class CarInfo {
  final String? license;
  final String? brandLogo;
  final List<dynamic>? images;
  final String? model;
  final String? make;
  final Engine? engine;
  final String? vin;
  final String? exteriorColor;
  final Color? exteriorColorCode;
  final String? vehicleType;
  final ActiveCarInfoLocation? location;

  CarInfo({
    this.license,
    this.brandLogo,
    this.images,
    this.model,
    this.make,
    this.engine,
    this.vin,
    this.exteriorColor,
    this.exteriorColorCode,
    this.vehicleType,
    this.location,
  });

  factory CarInfo.fromJson(Map<String, dynamic> json) => CarInfo(
    license: json["license"],
    brandLogo: json["BrandLogo"],
    images: json["images"],
    model: json["model"],
    make: json["make"],
    engine: json["engine"] == null ? null : Engine.fromJson(json["engine"]),
    vin: json["vin"],
    exteriorColor: json["exteriorColor"],
    exteriorColorCode: hexToColor(json["exteriorColorCode"]),
    vehicleType: json["vehicleType"],
    location: json["location"] == null ? null : ActiveCarInfoLocation.fromJson(json["location"]),
  );
}
