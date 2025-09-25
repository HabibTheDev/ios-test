import 'dart:convert';

ExploreCarDetailsModel exploreCarDetailsModelFromJson(String str) => ExploreCarDetailsModel.fromJson(json.decode(str));

class ExploreCarDetailsModel {
  final int? id;
  final String? vin;
  final String? make;
  final String? model;
  final int? year;
  final String? images;
  final String? brandLogo;
  final String? engine;
  final String? style;
  final String? exteriorColor;
  final String? interiorColor;
  final String? transmission;
  final String? fuelType;
  final String? trim;
  final String? bodyType;
  final int? noOfDoors;
  final int? noOfSeats;
  final List<String>? features;
  final Catalogue? catalogue;
  final Location? location;
  final double? odometer;
  final FaqSection? faqSection;
  final int? tripCount;
  final int? avgRating;

  ExploreCarDetailsModel({
    this.id,
    this.vin,
    this.make,
    this.model,
    this.year,
    this.images,
    this.brandLogo,
    this.engine,
    this.style,
    this.exteriorColor,
    this.interiorColor,
    this.transmission,
    this.fuelType,
    this.trim,
    this.bodyType,
    this.noOfDoors,
    this.noOfSeats,
    this.features,
    this.catalogue,
    this.location,
    this.odometer,
    this.faqSection,
    this.tripCount,
    this.avgRating,
  });

  factory ExploreCarDetailsModel.fromJson(Map<String, dynamic> json) => ExploreCarDetailsModel(
        id: json["id"],
        vin: json["vin"],
        make: json["make"],
        model: json["model"],
        year: json["year"],
        images: json["images"],
        brandLogo: json["BrandLogo"],
        engine: json["engine"],
        style: json["style"],
        exteriorColor: json["exteriorColor"],
        interiorColor: json["interiorColor"],
        transmission: json["transmission"],
        fuelType: json["fuelType"],
        trim: json["trim"],
        bodyType: json["bodyType"],
        noOfDoors: json["noOfDoors"],
        noOfSeats: json["noOfSeats"],
        features: json["features"] == null ? [] : List<String>.from(json["features"]!.map((x) => x)),
        catalogue: json["Catalogue"] == null ? null : Catalogue.fromJson(json["Catalogue"]),
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        odometer: json["odometer"]?.toDouble(),
        faqSection: json["faqSection"] == null ? null : FaqSection.fromJson(json["faqSection"]),
        tripCount: json["tripCount"],
        avgRating: json["avgRating"],
      );
}

class Catalogue {
  final int? id;
  final String? catalogueName;
  final String? description;
  final int? subscriptionCharge;
  final bool? isDiscount;
  final bool? isTextInclude;
  final bool? isCents;
  final int? catalougeDiscount;
  final List<CustomerFeedback>? customerFeedbacks;
  final FeesAndDeposit? feesAndDeposit;

  Catalogue({
    this.id,
    this.catalogueName,
    this.description,
    this.subscriptionCharge,
    this.isDiscount,
    this.isTextInclude,
    this.isCents,
    this.catalougeDiscount,
    this.customerFeedbacks,
    this.feesAndDeposit,
  });

  factory Catalogue.fromJson(Map<String, dynamic> json) => Catalogue(
        id: json["id"],
        catalogueName: json["catalogue_name"],
        description: json["description"],
        subscriptionCharge: json["subscription_charge"],
        isDiscount: json["isDiscount"],
        isTextInclude: json["isTextInclude"],
        isCents: json["isCents"],
        catalougeDiscount: json["catalougeDiscount"],
        customerFeedbacks: json["customerFeedbacks"] == null
            ? []
            : List<CustomerFeedback>.from(json["customerFeedbacks"]!.map((x) => CustomerFeedback.fromJson(x))),
        feesAndDeposit: json["feesAndDeposit"] == null ? null : FeesAndDeposit.fromJson(json["feesAndDeposit"]),
      );
}

class CustomerFeedback {
  final int? id;
  final int? rating;
  final String? message;
  final dynamic reply;
  final dynamic recommendation;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customer? customer;

  CustomerFeedback({
    this.id,
    this.rating,
    this.message,
    this.reply,
    this.recommendation,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  factory CustomerFeedback.fromJson(Map<String, dynamic> json) => CustomerFeedback(
        id: json["id"],
        rating: json["rating"],
        message: json["message"],
        reply: json["reply"],
        recommendation: json["recommendation"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      );
}

class Customer {
  final String? name;

  Customer({
    this.name,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        name: json["name"],
      );
}

class FeesAndDeposit {
  final int? securityDeposit;
  final bool? isEnrollmentFee;
  final int? totalFee;
  final bool? isCanceletaionFee;
  final int? minimumContact;
  final int? totalCancelFee;

  FeesAndDeposit({
    this.securityDeposit,
    this.isEnrollmentFee,
    this.totalFee,
    this.isCanceletaionFee,
    this.minimumContact,
    this.totalCancelFee,
  });

  factory FeesAndDeposit.fromJson(Map<String, dynamic> json) => FeesAndDeposit(
        securityDeposit: json["securityDeposit"],
        isEnrollmentFee: json["isEnrollmentFee"],
        totalFee: json["totalFee"],
        isCanceletaionFee: json["isCanceletaionFee"],
        minimumContact: json["minimumContact"],
        totalCancelFee: json["totalCancelFee"],
      );
}

class FaqSection {
  final int? id;
  final String? mainTitle;
  final String? subtitle;
  final bool? subtitleActive;
  final bool? isShown;
  final List<FaqQuestion>? faqQuestions;

  FaqSection({
    this.id,
    this.mainTitle,
    this.subtitle,
    this.subtitleActive,
    this.isShown,
    this.faqQuestions,
  });

  factory FaqSection.fromJson(Map<String, dynamic> json) => FaqSection(
        id: json["id"],
        mainTitle: json["main_title"],
        subtitle: json["subtitle"],
        subtitleActive: json["subtitleActive"],
        isShown: json["isShown"],
        faqQuestions: json["faqQuestions"] == null
            ? []
            : List<FaqQuestion>.from(json["faqQuestions"]!.map((x) => FaqQuestion.fromJson(x))),
      );
}

class FaqQuestion {
  final int? id;
  final String? question;
  final String? answer;
  final int? faqSectionId;

  FaqQuestion({
    this.id,
    this.question,
    this.answer,
    this.faqSectionId,
  });

  factory FaqQuestion.fromJson(Map<String, dynamic> json) => FaqQuestion(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
        faqSectionId: json["faqSectionId"],
      );
}

class Location {
  final int? id;
  final String? locationName;
  final String? description;
  final String? postalCode;
  final String? address01;
  final String? address02;
  final LocationCity? locationCity;

  Location({
    this.id,
    this.locationName,
    this.description,
    this.postalCode,
    this.address01,
    this.address02,
    this.locationCity,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        locationName: json["locationName"],
        description: json["description"],
        postalCode: json["postalCode"],
        address01: json["address01"],
        address02: json["address02"],
        locationCity: json["locationCity"] == null ? null : LocationCity.fromJson(json["locationCity"]),
      );
}

class LocationCity {
  final int? id;
  final String? city;
  final String? country;
  final String? stateOrProvince;
  final int? brandId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  LocationCity({
    this.id,
    this.city,
    this.country,
    this.stateOrProvince,
    this.brandId,
    this.createdAt,
    this.updatedAt,
  });

  factory LocationCity.fromJson(Map<String, dynamic> json) => LocationCity(
        id: json["id"],
        city: json["city"],
        country: json["country"],
        stateOrProvince: json["stateOrProvince"],
        brandId: json["brandId"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );
}
