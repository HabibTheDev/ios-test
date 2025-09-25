import 'dart:convert';

List<VehicleModel> vehicleModelFromJson(String str) =>
    List<VehicleModel>.from(json.decode(str).map((x) => VehicleModel.fromJson(x)));

class VehicleModel {
  final int? contactId;
  final int? totalMileage;
  final int? currentMileage;
  final int? currentActiveCar;
  final int? currentRequestCar;
  final int? overMileage;
  final String? currentStatus;
  final String? status;
  final String? currentState;
  final String? contactStatus;
  final bool? isRevoked;
  final DateTime? purchaseDate;
  final DateTime? endDate;
  final String? monthlyFee;
  final bool? exchangeState;
  final List<AddinationalDriver>? addinationalDriver;
  final String? contactState;
  final CustomerPurchaseCar? customerPurchaseCar;
  final ActiveCarInfo? activeCarInfo;

  VehicleModel({
    this.contactId,
    this.totalMileage,
    this.currentMileage,
    this.currentActiveCar,
    this.currentRequestCar,
    this.overMileage,
    this.currentStatus,
    this.status,
    this.currentState,
    this.contactStatus,
    this.isRevoked,
    this.purchaseDate,
    this.endDate,
    this.monthlyFee,
    this.exchangeState,
    this.addinationalDriver,
    this.contactState,
    this.customerPurchaseCar,
    this.activeCarInfo,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        contactId: json["ContactID"],
        totalMileage: json["totalMileage"],
        currentMileage: json["currentMileage"],
        currentActiveCar: json["currentActiveCar"],
        currentRequestCar: json["currentRequestCar"],
        overMileage: json["overMileage"],
        currentStatus: json["currentStatus"],
        status: json["status"],
        currentState: json["currentState"],
        contactStatus: json["contactStatus"],
        isRevoked: json["isRevoked"],
        purchaseDate: json["purchaseDate"] == null ? null : DateTime.parse(json["purchaseDate"]),
        endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        monthlyFee: json["monthlyFee"],
        exchangeState: json["exchangeState"],
        addinationalDriver: json["addinationalDriver"] == null
            ? []
            : List<AddinationalDriver>.from(json["addinationalDriver"]!.map((x) => AddinationalDriver.fromJson(x))),
        contactState: json["contactState"],
        customerPurchaseCar:
            json["customerPurchaseCar"] == null ? null : CustomerPurchaseCar.fromJson(json["customerPurchaseCar"]),
        activeCarInfo: json["activeCarInfo"] == null ? null : ActiveCarInfo.fromJson(json["activeCarInfo"]),
      );
}

class ActiveCarInfo {
  final int? id;
  final String? vin;
  final String? model;
  final String? make;
  final int? year;
  final String? status;
  final String? carStatus;
  final String? images;
  final String? brandLogo;

  ActiveCarInfo({
    this.id,
    this.vin,
    this.model,
    this.make,
    this.year,
    this.status,
    this.carStatus,
    this.images,
    this.brandLogo,
  });

  factory ActiveCarInfo.fromJson(Map<String, dynamic> json) => ActiveCarInfo(
        id: json["id"],
        vin: json["vin"],
        model: json["model"],
        make: json["make"],
        year: json["year"],
        status: json["status"],
        carStatus: json["carStatus"],
        images: json["images"],
        brandLogo: json["BrandLogo"],
      );
}

class AddinationalDriver {
  final int? id;
  final String? accessType;
  final ActiveCarInfo? car;
  final int? carId;
  final String? status;
  final bool? isRevoked;
  final String? email;
  final DateTime? accessStart;
  final DateTime? accessEnd;
  final List<String>? days;
  final bool? isVerified;
  final String? usersId;

  AddinationalDriver({
    this.id,
    this.accessType,
    this.car,
    this.carId,
    this.status,
    this.isRevoked,
    this.email,
    this.accessStart,
    this.accessEnd,
    this.days,
    this.isVerified,
    this.usersId,
  });

  factory AddinationalDriver.fromJson(Map<String, dynamic> json) => AddinationalDriver(
        id: json["id"],
        accessType: json["accessType"],
        car: json["car"] == null ? null : ActiveCarInfo.fromJson(json["car"]),
        carId: json["carId"],
        status: json["status"],
        isRevoked: json["isRevoked"],
        email: json["email"],
        accessStart: json["accessStart"] == null ? null : DateTime.parse(json["accessStart"]),
        accessEnd: json["accessEnd"] == null ? null : DateTime.parse(json["accessEnd"]),
        days: json["days"] == null ? [] : List<String>.from(json["days"]!.map((x) => x)),
        isVerified: json["isVerified"],
        usersId: json["usersId"],
      );
}

class CustomerPurchaseCar {
  final String? catalogueName;
  final Catalogue? catalogue;
  final DriverPlansPurchase? driverPlansPurchase;
  final List<Extra>? extras;
  final Count? count;

  CustomerPurchaseCar({
    this.catalogueName,
    this.catalogue,
    this.driverPlansPurchase,
    this.extras,
    this.count,
  });

  factory CustomerPurchaseCar.fromJson(Map<String, dynamic> json) => CustomerPurchaseCar(
        catalogueName: json["catalogueName"],
        catalogue: json["Catalogue"] == null ? null : Catalogue.fromJson(json["Catalogue"]),
        driverPlansPurchase:
            json["DriverPlansPurchase"] == null ? null : DriverPlansPurchase.fromJson(json["DriverPlansPurchase"]),
        extras: json["extras"] == null ? [] : List<Extra>.from(json["extras"]!.map((x) => Extra.fromJson(x))),
        count: json["_count"] == null ? null : Count.fromJson(json["_count"]),
      );
}

class Catalogue {
  final Exchange? exchange;

  Catalogue({
    this.exchange,
  });

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
        exchange: json["exchange"] == null ? null : Exchange.fromJson(json["exchange"]),
      );
}

class Exchange {
  final int? monthlyExchange;

  Exchange({
    this.monthlyExchange,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) => Exchange(
        monthlyExchange: json["monthlyExchange"],
      );
}

class Count {
  final int? extras;

  Count({
    this.extras,
  });

  factory Count.fromJson(Map<String, dynamic> json) => Count(
        extras: json["extras"],
      );
}

class DriverPlansPurchase {
  final int? maxDriver;

  DriverPlansPurchase({
    this.maxDriver,
  });

  factory DriverPlansPurchase.fromJson(Map<String, dynamic> json) => DriverPlansPurchase(
        maxDriver: json["maxDriver"],
      );
}

class Extra {
  final int? id;
  final int? totalCount;

  Extra({
    this.id,
    this.totalCount,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        id: json["id"],
        totalCount: json["totalCount"],
      );
}
