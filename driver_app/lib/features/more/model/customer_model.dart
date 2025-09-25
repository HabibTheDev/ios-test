import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

class CustomerModel {
  final int? id;
  final String? fullName;
  final bool? verified;
  final Designation? designation;
  final Location? location;
  final Country? country;
  final String? phone;
  final String? email;
  final String? address;
  final String? gender;
  final DateTime? dateOfBirth;
  final dynamic photo;
  final bool? isActive;
  final bool? needVerification;
  final bool? licenseVerified;
  final License? license;
  final Passport? passport;

  CustomerModel({
    this.id,
    this.fullName,
    this.verified,
    this.designation,
    this.location,
    this.country,
    this.phone,
    this.email,
    this.address,
    this.gender,
    this.dateOfBirth,
    this.photo,
    this.isActive,
    this.needVerification,
    this.licenseVerified,
    this.license,
    this.passport,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        fullName: json["fullName"],
        verified: json["verified"],
        designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        country: json["country"] == null ? null : Country.fromJson(json["country"]),
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
        photo: json["photo"],
        isActive: json["isActive"],
        needVerification: json["needVerification"],
        licenseVerified: json["licenseVerified"],
        license: json["license"] == null ? null : License.fromJson(json["license"]),
        passport: json["passport"] == null ? null : Passport.fromJson(json["passport"]),
      );
}

class Country {
  final int? id;
  final String? country;
  final String? countryCode;
  final String? countryFlag;

  Country({
    this.id,
    this.country,
    this.countryCode,
    this.countryFlag,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        country: json["country"],
        countryCode: json["countryCode"],
        countryFlag: json["countryFlag"],
      );
}

class Designation {
  final String? title;
  final int? id;

  Designation({
    this.title,
    this.id,
  });

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        title: json["title"],
        id: json["id"],
      );
}

class License {
  final String? licenseNumber;
  final String? licenseClass;
  final String? expirationDate;
  final String? issuingCountry;
  final String? issuingProvince;
  final String? licenseFront;
  final String? licenseBack;

  License({
    this.licenseNumber,
    this.licenseClass,
    this.expirationDate,
    this.issuingCountry,
    this.issuingProvince,
    this.licenseFront,
    this.licenseBack,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
        licenseNumber: json["licenseNumber"],
        licenseClass: json["licenseClass"],
        expirationDate: json["expirationDate"],
        issuingCountry: json["issuingCountry"],
        issuingProvince: json["issuingProvince"],
        licenseFront: json["licenseFront"],
        licenseBack: json["licenseBack"],
      );
}

class Location {
  final String? locationName;
  final int? id;

  Location({
    this.locationName,
    this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        locationName: json["locationName"],
        id: json["id"],
      );
}

class Passport {
  final String? passportNo;
  final String? expirationDate;
  final String? type;
  final String? issuingProvince;
  final String? passportPhoto;

  Passport({
    this.passportNo,
    this.expirationDate,
    this.type,
    this.issuingProvince,
    this.passportPhoto,
  });

  factory Passport.fromJson(Map<String, dynamic> json) => Passport(
        passportNo: json["passportNo"],
        expirationDate: json["expirationDate"],
        type: json["type"],
        issuingProvince: json["issuingProvince"],
        passportPhoto: json["passportPhoto"],
      );
}
