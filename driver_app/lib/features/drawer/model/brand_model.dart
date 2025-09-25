import 'dart:convert';

BrandModel brandModelFromJson(String str) => BrandModel.fromJson(json.decode(str));

class BrandModel {
  final int? id;
  final String? email;
  final String? brandName;
  final String? businessType;
  final String? logo;
  final String? country;
  final String? state;
  final String? city;
  final String? postalCode;
  final String? address1;
  final String? address2;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BrandModel({
    this.id,
    this.email,
    this.brandName,
    this.businessType,
    this.logo,
    this.country,
    this.state,
    this.city,
    this.postalCode,
    this.address1,
    this.address2,
    this.createdAt,
    this.updatedAt,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) => BrandModel(
        id: json["id"],
        email: json["email"],
        brandName: json["brandName"],
        businessType: json["businessType"],
        logo: json["logo"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postalCode: json["postalCode"],
        address1: json["address1"],
        address2: json["address2"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );
}
