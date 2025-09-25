import 'dart:convert';

List<CityModel> cityModelFromJson(String str) =>
    List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

class CityModel {
  final int? id;
  final String? city;
  final String? country;
  final String? stateOrProvince;
  final List<Location>? location;

  CityModel({
    this.id,
    this.city,
    this.country,
    this.stateOrProvince,
    this.location,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        city: json["city"],
        country: json["country"],
        stateOrProvince: json["stateOrProvince"],
        location:
            json["location"] == null ? [] : List<Location>.from(json["location"]!.map((x) => Location.fromJson(x))),
      );
}

class Location {
  final int? id;
  final String? locationName;
  final String? postalCode;
  final String? address01;
  final String? address02;

  Location({
    this.id,
    this.locationName,
    this.postalCode,
    this.address01,
    this.address02,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        locationName: json["locationName"],
        postalCode: json["postalCode"],
        address01: json["address01"],
        address02: json["address02"],
      );
}
