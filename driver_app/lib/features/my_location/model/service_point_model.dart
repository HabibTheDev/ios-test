import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

List<ServicePointModel> servicePointModelFromJson(String str) =>
    List<ServicePointModel>.from(json.decode(str).map((x) => ServicePointModel.fromJson(x)));

class ServicePointModel {
  final int? id;
  final String? locationName;
  final String? locationType;
  final String? description;
  final String? address;
  final String? longitude;
  final String? latitude;
  final int? brandId;
  final List<LatLng>? polylineCoordinates;
  final double? travelDistanceInKm;
  final String? travelTime;

  ServicePointModel(
      {this.id,
      this.locationName,
      this.locationType,
      this.description,
      this.address,
      this.longitude,
      this.latitude,
      this.brandId,
      this.polylineCoordinates,
      this.travelDistanceInKm,
      this.travelTime});

  factory ServicePointModel.fromJson(Map<String, dynamic> json) => ServicePointModel(
        id: json["id"],
        locationName: json["locationName"],
        locationType: json["locationType"],
        description: json["description"],
        address: json["address"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        brandId: json["brandId"],
        polylineCoordinates: [],
        travelDistanceInKm: 0.0,
        travelTime: '',
      );

  ServicePointModel copyWith({
    int? id,
    String? locationName,
    String? locationType,
    String? description,
    String? address,
    String? longitude,
    String? latitude,
    int? brandId,
    List<LatLng>? polylineCoordinates,
    double? travelDistanceInKm,
    String? travelTime,
  }) {
    return ServicePointModel(
      id: id ?? this.id,
      locationName: locationName ?? this.locationName,
      locationType: locationType ?? this.locationType,
      description: description ?? this.description,
      address: address ?? this.address,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      brandId: brandId ?? this.brandId,
      polylineCoordinates: polylineCoordinates ?? this.polylineCoordinates,
      travelDistanceInKm: travelDistanceInKm ?? this.travelDistanceInKm,
      travelTime: travelTime ?? this.travelTime,
    );
  }
}
