import 'dart:convert';

FilterCarModel filterCarModelFromJson(String str) => FilterCarModel.fromJson(json.decode(str));

class FilterCarModel {
  final Meta? meta;
  final FilterCarModelData? data;

  FilterCarModel({
    this.meta,
    this.data,
  });

  factory FilterCarModel.fromJson(Map<String, dynamic> json) => FilterCarModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : FilterCarModelData.fromJson(json["data"]),
      );
}

class FilterCarModelData {
  final int? total;
  final DataData? data;

  FilterCarModelData({
    this.total,
    this.data,
  });

  factory FilterCarModelData.fromJson(Map<String, dynamic> json) => FilterCarModelData(
        total: json["total"],
        data: json["data"] == null ? null : DataData.fromJson(json["data"]),
      );
}

class DataData {
  final String? city;
  final String? catalogueName;
  final int? subscriptionCharge;
  final String? description;
  final bool? isDiscount;
  final bool? isTextInclude;
  final bool? isCents;
  final int? catalogueDiscount;
  final String? make;
  final String? brandLogo;
  final List<ExploreCar>? cars;

  DataData({
    this.city,
    this.catalogueName,
    this.subscriptionCharge,
    this.description,
    this.isDiscount,
    this.isTextInclude,
    this.isCents,
    this.catalogueDiscount,
    this.make,
    this.brandLogo,
    this.cars,
  });

  factory DataData.fromJson(Map<String, dynamic> json) => DataData(
        city: json["city"],
        catalogueName: json["catalogue_name"],
        subscriptionCharge: json["subscription_charge"],
        description: json["description"],
        isDiscount: json["isDiscount"],
        isTextInclude: json["isTextInclude"],
        isCents: json["isCents"],
        catalogueDiscount: json["catalogueDiscount"],
        make: json["make"],
        brandLogo: json["brandLogo"],
        cars: json["cars"] == null ? [] : List<ExploreCar>.from(json["cars"]!.map((x) => ExploreCar.fromJson(x))),
      );
}

class ExploreCar {
  final int? id;
  final String? images;
  final int? year;
  final String? make;
  final String? model;
  final String? brandLogo;
  final String? catalogueName;
  final Location? location;
  final int? tripCount;
  final int? subscriptionCharge;
  final bool? isDiscount;
  final bool? isTextInclude;
  final bool? isCents;
  final int? catalogueDiscount;
  final dynamic catalogueRating;

  ExploreCar({
    this.id,
    this.images,
    this.year,
    this.make,
    this.model,
    this.brandLogo,
    this.catalogueName,
    this.location,
    this.tripCount,
    this.subscriptionCharge,
    this.isDiscount,
    this.isTextInclude,
    this.isCents,
    this.catalogueDiscount,
    this.catalogueRating,
  });

  factory ExploreCar.fromJson(Map<String, dynamic> json) => ExploreCar(
        id: json["id"],
        images: json["images"],
        year: json["year"],
        make: json["make"],
        model: json["model"],
        brandLogo: json["brandLogo"],
        catalogueName: json["catalogue_name"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        tripCount: json["tripCount"],
        subscriptionCharge: json["subscription_charge"],
        isDiscount: json["isDiscount"],
        isTextInclude: json["isTextInclude"],
        isCents: json["isCents"],
        catalogueDiscount: json["catalogueDiscount"],
        catalogueRating: json["catalogueRating"],
      );
}

class Location {
  final int? id;
  final String? locationName;
  final String? address01;
  final String? address02;
  final String? postalCode;
  final LocationCity? locationCity;

  Location({
    this.id,
    this.locationName,
    this.address01,
    this.address02,
    this.postalCode,
    this.locationCity,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        locationName: json["locationName"],
        address01: json["address01"],
        address02: json["address02"],
        postalCode: json["postalCode"],
        locationCity: json["locationCity"] == null ? null : LocationCity.fromJson(json["locationCity"]),
      );
}

class LocationCity {
  final int? id;
  final String? city;
  final String? country;
  final String? stateOrProvince;

  LocationCity({
    this.id,
    this.city,
    this.country,
    this.stateOrProvince,
  });

  factory LocationCity.fromJson(Map<String, dynamic> json) => LocationCity(
        id: json["id"],
        city: json["city"],
        country: json["country"],
        stateOrProvince: json["stateOrProvince"],
      );
}

class Meta {
  final int? page;
  final dynamic limit;
  final int? total;

  Meta({
    this.page,
    this.limit,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
      );
}
