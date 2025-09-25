import 'dart:convert';

EmployeeModel employeeModelFromJson(String str) => EmployeeModel.fromJson(json.decode(str));

class EmployeeModel {
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
  final String? photo;
  final bool? isActive;
  final bool? needVerification;
  final bool? licenseVerified;
  final License? license;
  final Passport? passport;

  EmployeeModel({
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

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
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
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Country({
    this.id,
    this.country,
    this.countryCode,
    this.countryFlag,
    this.createdAt,
    this.updatedAt,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json["id"],
        country: json["country"],
        countryCode: json["countryCode"],
        countryFlag: json["countryFlag"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );
}

class Designation {
  final String? title;
  final int? id;

  Designation({this.title, this.id});

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
        title: json["title"],
        id: json["id"],
      );
}

class License {
  final String? licenseNumber;
  final String? expirationDate;
  final List<String>? licenseImage;
  final LicenseData? licenseData;

  License({
    this.licenseNumber,
    this.expirationDate,
    this.licenseImage,
    this.licenseData,
  });

  factory License.fromJson(Map<String, dynamic> json) => License(
        licenseNumber: json["licenseNumber"],
        expirationDate: json["expirationDate"],
        licenseImage: json["licenseImage"] == null ? [] : List<String>.from(json["licenseImage"]!.map((x) => x)),
        licenseData: json["licenseData"] == null ? null : LicenseData.fromJson(json["licenseData"]),
      );
}

class LicenseData {
  final String? age;
  final String? dob;
  final String? sex;
  final String? eyes;
  final String? state;
  final String? height;
  final String? status;
  final String? address;
  final String? country;
  final String? lastName;
  final String? firstName;
  final String? issueDate;
  final String? sessionId;
  final String? restrictions;
  final String? licenseNumber;
  final String? documentNumber;
  final String? expirationDate;
  final String? licenseWarning01;
  final String? licenseWarning02;
  final String? drivingLicenseUrl;

  LicenseData({
    this.age,
    this.dob,
    this.sex,
    this.eyes,
    this.state,
    this.height,
    this.status,
    this.address,
    this.country,
    this.lastName,
    this.firstName,
    this.issueDate,
    this.sessionId,
    this.restrictions,
    this.licenseNumber,
    this.documentNumber,
    this.expirationDate,
    this.licenseWarning01,
    this.licenseWarning02,
    this.drivingLicenseUrl,
  });

  factory LicenseData.fromJson(Map<String, dynamic> json) => LicenseData(
        age: json["Age"],
        dob: json["DOB"],
        sex: json["Sex"],
        eyes: json["Eyes"],
        state: json["State"],
        height: json["Height"],
        status: json["Status"],
        address: json["Address"],
        country: json["Country"],
        lastName: json["Last_Name"],
        firstName: json["First_Name"],
        issueDate: json["Issue_Date"],
        sessionId: json["session_id"],
        restrictions: json["Restrictions"],
        licenseNumber: json["License_Number"],
        documentNumber: json["Document_Number"],
        expirationDate: json["Expiration_Date"],
        licenseWarning01: json["License_Warning_01"],
        licenseWarning02: json["License_Warning_02"],
        drivingLicenseUrl: json["driving_license_url"],
      );
}

class Location {
  final String? locationName;
  final int? id;

  Location({this.locationName, this.id});

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
