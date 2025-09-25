// To parse this JSON data, do
//
//     final contractDetailsModel = contractDetailsModelFromJson(jsonString);

import 'dart:convert';

ContractDetailsModel contractDetailsModelFromJson(String str) => ContractDetailsModel.fromJson(json.decode(str));

String contractDetailsModelToJson(ContractDetailsModel data) => json.encode(data.toJson());

class ContractDetailsModel {
  final Customer? customer;
  final Brand? brand;
  final Catalogue? catalogue;
  final CarInfo? carInfo;
  final ContactPeriod? contactPeriod;
  final double? totalCharge;
  final int? subscriptionCharge;
  final double? mileageCharge;
  final double? protectionCharge;
  final int? noProtectionCharge;
  final int? extraCharges;
  final int? handoverCharge;
  final int? driverPlansCharge;
  final dynamic handoverDetails;
  final dynamic returnDetails;

  ContractDetailsModel({
    this.customer,
    this.brand,
    this.catalogue,
    this.carInfo,
    this.contactPeriod,
    this.totalCharge,
    this.subscriptionCharge,
    this.mileageCharge,
    this.protectionCharge,
    this.noProtectionCharge,
    this.extraCharges,
    this.handoverCharge,
    this.driverPlansCharge,
    this.handoverDetails,
    this.returnDetails,
  });

  factory ContractDetailsModel.fromJson(Map<String, dynamic> json) => ContractDetailsModel(
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        catalogue: json["Catalogue"] == null ? null : Catalogue.fromJson(json["Catalogue"]),
        carInfo: json["carInfo"] == null ? null : CarInfo.fromJson(json["carInfo"]),
        contactPeriod: json["contactPeriod"] == null ? null : ContactPeriod.fromJson(json["contactPeriod"]),
        totalCharge: json["totalCharge"]?.toDouble(),
        subscriptionCharge: json["subscriptionCharge"],
        mileageCharge: json["mileageCharge"]?.toDouble(),
        protectionCharge: json["protectionCharge"]?.toDouble(),
        noProtectionCharge: json["noProtectionCharge"],
        extraCharges: json["extraCharges"],
        handoverCharge: json["handoverCharge"],
        driverPlansCharge: json["driverPlansCharge"],
        handoverDetails: json["handoverDetails"],
        returnDetails: json["returnDetails"],
      );

  Map<String, dynamic> toJson() => {
        "customer": customer?.toJson(),
        "brand": brand?.toJson(),
        "Catalogue": catalogue?.toJson(),
        "carInfo": carInfo?.toJson(),
        "contactPeriod": contactPeriod?.toJson(),
        "totalCharge": totalCharge,
        "subscriptionCharge": subscriptionCharge,
        "mileageCharge": mileageCharge,
        "protectionCharge": protectionCharge,
        "noProtectionCharge": noProtectionCharge,
        "extraCharges": extraCharges,
        "handoverCharge": handoverCharge,
        "driverPlansCharge": driverPlansCharge,
        "handoverDetails": handoverDetails,
        "returnDetails": returnDetails,
      };
}

class Brand {
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
  final bool? isDeleted;
  final dynamic deletedAt;
  final List<dynamic>? blockCustomerApp;
  final List<String>? verifiedCustomer;
  final List<dynamic>? pendingVerification;
  final List<dynamic>? blockedcustomer;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isActiveDynamicPricing;

  Brand({
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
    this.isDeleted,
    this.deletedAt,
    this.blockCustomerApp,
    this.verifiedCustomer,
    this.pendingVerification,
    this.blockedcustomer,
    this.createdAt,
    this.updatedAt,
    this.isActiveDynamicPricing,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
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
        isDeleted: json["isDeleted"],
        deletedAt: json["deletedAt"],
        blockCustomerApp:
            json["blockCustomerApp"] == null ? [] : List<dynamic>.from(json["blockCustomerApp"]!.map((x) => x)),
        verifiedCustomer:
            json["verifiedCustomer"] == null ? [] : List<String>.from(json["verifiedCustomer"]!.map((x) => x)),
        pendingVerification:
            json["pendingVerification"] == null ? [] : List<dynamic>.from(json["pendingVerification"]!.map((x) => x)),
        blockedcustomer:
            json["blockedcustomer"] == null ? [] : List<dynamic>.from(json["blockedcustomer"]!.map((x) => x)),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        isActiveDynamicPricing: json["isActiveDynamicPricing"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "brandName": brandName,
        "businessType": businessType,
        "logo": logo,
        "country": country,
        "state": state,
        "city": city,
        "postalCode": postalCode,
        "address1": address1,
        "address2": address2,
        "isDeleted": isDeleted,
        "deletedAt": deletedAt,
        "blockCustomerApp": blockCustomerApp == null ? [] : List<dynamic>.from(blockCustomerApp!.map((x) => x)),
        "verifiedCustomer": verifiedCustomer == null ? [] : List<dynamic>.from(verifiedCustomer!.map((x) => x)),
        "pendingVerification":
            pendingVerification == null ? [] : List<dynamic>.from(pendingVerification!.map((x) => x)),
        "blockedcustomer": blockedcustomer == null ? [] : List<dynamic>.from(blockedcustomer!.map((x) => x)),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "isActiveDynamicPricing": isActiveDynamicPricing,
      };
}

class CarInfo {
  final String? make;
  final String? model;
  final String? vin;
  final String? images;
  final String? locationName;
  final String? license;
  final ConnectedCar? connectedCar;

  CarInfo({
    this.make,
    this.model,
    this.vin,
    this.images,
    this.locationName,
    this.license,
    this.connectedCar,
  });

  factory CarInfo.fromJson(Map<String, dynamic> json) => CarInfo(
        make: json["make"],
        model: json["model"],
        vin: json["vin"],
        images: json["images"],
        locationName: json["locationName"],
        license: json["license"],
        connectedCar: json["connectedCar"] == null ? null : ConnectedCar.fromJson(json["connectedCar"]),
      );

  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "vin": vin,
        "images": images,
        "locationName": locationName,
        "license": license,
        "connectedCar": connectedCar?.toJson(),
      };
}

class ConnectedCar {
  final int? id;
  final String? carId;
  final String? vin;
  final String? name;
  final String? engineType;
  final String? make;
  final double? odometer;
  final int? oil;
  final Fuel? fuel;
  final String? lockStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic location;

  ConnectedCar({
    this.id,
    this.carId,
    this.vin,
    this.name,
    this.engineType,
    this.make,
    this.odometer,
    this.oil,
    this.fuel,
    this.lockStatus,
    this.createdAt,
    this.updatedAt,
    this.location,
  });

  factory ConnectedCar.fromJson(Map<String, dynamic> json) => ConnectedCar(
        id: json["id"],
        carId: json["carId"],
        vin: json["vin"],
        name: json["name"],
        engineType: json["engineType"],
        make: json["make"],
        odometer: json["odometer"]?.toDouble(),
        oil: json["oil"],
        fuel: json["fuel"] == null ? null : Fuel.fromJson(json["fuel"]),
        lockStatus: json["lockStatus"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "carId": carId,
        "vin": vin,
        "name": name,
        "engineType": engineType,
        "make": make,
        "odometer": odometer,
        "oil": oil,
        "fuel": fuel?.toJson(),
        "lockStatus": lockStatus,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "location": location,
      };
}

class Fuel {
  final double? range;
  final double? amountRemaining;
  final double? percentRemaining;

  Fuel({
    this.range,
    this.amountRemaining,
    this.percentRemaining,
  });

  factory Fuel.fromJson(Map<String, dynamic> json) => Fuel(
        range: json["range"]?.toDouble(),
        amountRemaining: json["amountRemaining"]?.toDouble(),
        percentRemaining: json["percentRemaining"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "range": range,
        "amountRemaining": amountRemaining,
        "percentRemaining": percentRemaining,
      };
}

class Catalogue {
  final String? name;
  final SubscriptionPlan? subscriptionPlan;
  final ProtectionPlan? protectionPlan;
  final NoProtectionPlan? noProtectionPlan;
  final List<Extra>? extras;
  final String? feesAndDeposit;

  Catalogue({
    this.name,
    this.subscriptionPlan,
    this.protectionPlan,
    this.noProtectionPlan,
    this.extras,
    this.feesAndDeposit,
  });

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
        name: json["name"],
        subscriptionPlan: json["subscriptionPlan"] == null ? null : SubscriptionPlan.fromJson(json["subscriptionPlan"]),
        protectionPlan: json["protectionPlan"] == null ? null : ProtectionPlan.fromJson(json["protectionPlan"]),
        noProtectionPlan: json["noProtectionPlan"] == null ? null : NoProtectionPlan.fromJson(json["noProtectionPlan"]),
        extras: json["extras"] == null ? [] : List<Extra>.from(json["extras"]!.map((x) => Extra.fromJson(x))),
        feesAndDeposit: json["feesAndDeposit"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "subscriptionPlan": subscriptionPlan?.toJson(),
        "protectionPlan": protectionPlan?.toJson(),
        "noProtectionPlan": noProtectionPlan?.toJson(),
        "extras": extras == null ? [] : List<dynamic>.from(extras!.map((x) => x.toJson())),
        "feesAndDeposit": feesAndDeposit,
      };
}

class Extra {
  final String? title;
  final int? packagePrice;
  final int? totalCount;

  Extra({
    this.title,
    this.packagePrice,
    this.totalCount,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        title: json["title"],
        packagePrice: json["packagePrice"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "packagePrice": packagePrice,
        "totalCount": totalCount,
      };
}

class NoProtectionPlan {
  NoProtectionPlan();

  factory NoProtectionPlan.fromJson(Map<String, dynamic> json) => NoProtectionPlan();

  Map<String, dynamic> toJson() => {};
}

class ProtectionPlan {
  final String? title;
  final List<Coverage>? coverages;

  ProtectionPlan({
    this.title,
    this.coverages,
  });

  factory ProtectionPlan.fromJson(Map<String, dynamic> json) => ProtectionPlan(
        title: json["title"],
        coverages:
            json["coverages"] == null ? [] : List<Coverage>.from(json["coverages"]!.map((x) => Coverage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "coverages": coverages == null ? [] : List<dynamic>.from(coverages!.map((x) => x.toJson())),
      };
}

class Coverage {
  final String? title;
  final double? price;

  Coverage({
    this.title,
    this.price,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) => Coverage(
        title: json["title"],
        price: json["price"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "price": price,
      };
}

class SubscriptionPlan {
  final String? title;
  final int? includedMileage;
  final int? packagePrice;

  SubscriptionPlan({
    this.title,
    this.includedMileage,
    this.packagePrice,
  });

  factory SubscriptionPlan.fromJson(Map<String, dynamic> json) => SubscriptionPlan(
        title: json["title"],
        includedMileage: json["includedMileage"],
        packagePrice: json["packagePrice"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "includedMileage": includedMileage,
        "packagePrice": packagePrice,
      };
}

class ContactPeriod {
  final DateTime? purchaseDate;
  final dynamic endDate;

  ContactPeriod({
    this.purchaseDate,
    this.endDate,
  });

  factory ContactPeriod.fromJson(Map<String, dynamic> json) => ContactPeriod(
        purchaseDate: json["purchaseDate"] == null ? null : DateTime.parse(json["purchaseDate"]),
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "purchaseDate": purchaseDate?.toIso8601String(),
        "endDate": endDate,
      };
}

class Customer {
  final int? id;
  final String? name;
  final String? countryCode;
  final dynamic countryId;
  final String? phone;
  final String? email;
  final dynamic address;
  final dynamic cardNumber;
  final dynamic cardExpireDate;
  final dynamic zipCode;
  final String? images;
  final dynamic dateOfBirth;
  final dynamic gender;
  final int? userId;
  final List<int>? activeCar;
  final List<int>? completeCar;
  final List<int>? pendingCar;
  final List<int>? requestCar;
  final String? status;
  final String? usersId;
  final int? viewCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? passportId;
  final int? lisenceId;
  final int? brandId;

  Customer({
    this.id,
    this.name,
    this.countryCode,
    this.countryId,
    this.phone,
    this.email,
    this.address,
    this.cardNumber,
    this.cardExpireDate,
    this.zipCode,
    this.images,
    this.dateOfBirth,
    this.gender,
    this.userId,
    this.activeCar,
    this.completeCar,
    this.pendingCar,
    this.requestCar,
    this.status,
    this.usersId,
    this.viewCount,
    this.createdAt,
    this.updatedAt,
    this.passportId,
    this.lisenceId,
    this.brandId,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        countryCode: json["countryCode"],
        countryId: json["countryId"],
        phone: json["phone"],
        email: json["email"],
        address: json["address"],
        cardNumber: json["cardNumber"],
        cardExpireDate: json["cardExpireDate"],
        zipCode: json["zipCode"],
        images: json["images"],
        dateOfBirth: json["dateOfBirth"],
        gender: json["gender"],
        userId: json["userId"],
        activeCar: json["activeCar"] == null ? [] : List<int>.from(json["activeCar"]!.map((x) => x)),
        completeCar: json["completeCar"] == null ? [] : List<int>.from(json["completeCar"]!.map((x) => x)),
        pendingCar: json["pendingCar"] == null ? [] : List<int>.from(json["pendingCar"]!.map((x) => x)),
        requestCar: json["requestCar"] == null ? [] : List<int>.from(json["requestCar"]!.map((x) => x)),
        status: json["status"],
        usersId: json["usersId"],
        viewCount: json["viewCount"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        passportId: json["passportId"],
        lisenceId: json["lisenceId"],
        brandId: json["brandId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "countryCode": countryCode,
        "countryId": countryId,
        "phone": phone,
        "email": email,
        "address": address,
        "cardNumber": cardNumber,
        "cardExpireDate": cardExpireDate,
        "zipCode": zipCode,
        "images": images,
        "dateOfBirth": dateOfBirth,
        "gender": gender,
        "userId": userId,
        "activeCar": activeCar == null ? [] : List<dynamic>.from(activeCar!.map((x) => x)),
        "completeCar": completeCar == null ? [] : List<dynamic>.from(completeCar!.map((x) => x)),
        "pendingCar": pendingCar == null ? [] : List<dynamic>.from(pendingCar!.map((x) => x)),
        "requestCar": requestCar == null ? [] : List<dynamic>.from(requestCar!.map((x) => x)),
        "status": status,
        "usersId": usersId,
        "viewCount": viewCount,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "passportId": passportId,
        "lisenceId": lisenceId,
        "brandId": brandId,
      };
}
