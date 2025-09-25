import 'dart:convert';

JwtTokenModel jwtTokenModelFromJson(String str) =>
    JwtTokenModel.fromJson(json.decode(str));

class JwtTokenModel {
  final int? id;
  final String? email;
  final String? role;
  final dynamic profilePicture;
  final int? brandId;
  final bool? isBiometric;
  final int? iat;
  final int? exp;

  JwtTokenModel({
    this.id,
    this.email,
    this.role,
    this.profilePicture,
    this.brandId,
    this.isBiometric,
    this.iat,
    this.exp,
  });

  factory JwtTokenModel.fromJson(Map<String, dynamic> json) => JwtTokenModel(
        id: json["id"],
        email: json["email"],
        role: json["role"],
        profilePicture: json["profilePicture"],
        brandId: json["brand_id"],
        isBiometric: json["isBiometric"],
        iat: json["iat"],
        exp: json["exp"],
      );
}
