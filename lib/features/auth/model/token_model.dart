import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

class TokenModel {
  final String? accessToken;
  final String? refreshToken;

  TokenModel({this.accessToken, this.refreshToken});

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );
}
