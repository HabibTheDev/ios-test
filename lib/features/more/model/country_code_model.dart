import 'dart:convert';

List<CountryCodeModel> countryCodeModelFromJson(String str) =>
    List<CountryCodeModel>.from(json.decode(str).map((x) => CountryCodeModel.fromJson(x)));

class CountryCodeModel {
  final int? id;
  final String? country;
  final String? countryCode;
  final String? countryShort;
  final String? countryFlag;
  final String? phoneCode;
  final bool? isSupported;

  CountryCodeModel({
    this.id,
    this.country,
    this.countryCode,
    this.countryShort,
    this.countryFlag,
    this.phoneCode,
    this.isSupported,
  });

  factory CountryCodeModel.fromJson(Map<String, dynamic> json) => CountryCodeModel(
        id: json["id"],
        country: json["country"],
        countryCode: json["countryCode"],
        countryShort: json["countryShort"],
        countryFlag: json["countryFlag"],
        phoneCode: json["phoneCode"],
        isSupported: json["isSupported"],
      );
}
