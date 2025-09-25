import 'dart:convert';

CheckoutDriverModel checkoutDriverModelFromJson(String str) => CheckoutDriverModel.fromJson(json.decode(str));

class CheckoutDriverModel {
  int quantity;
  final int? id;
  final int? minimumAge;
  final bool? driverConsent;
  final bool? allowExtraDriver;
  final int? maxDriver;
  final int? driverPrice;
  final bool? isDiscount;
  final int? driverDiscount;
  final int? discountedPrice;
  final bool? isFreeDriver;
  final int? freeDriverAmount;
  final bool? isCents;
  final int? catalogueId;

  final dynamic totalPrice;

  CheckoutDriverModel({
    required this.quantity,
    this.id,
    this.minimumAge,
    this.driverConsent,
    this.allowExtraDriver,
    this.maxDriver,
    this.driverPrice,
    this.isDiscount,
    this.driverDiscount,
    this.discountedPrice,
    this.isFreeDriver,
    this.freeDriverAmount,
    this.isCents,
    this.catalogueId,
    this.totalPrice,
  });

  factory CheckoutDriverModel.fromJson(Map<String, dynamic> json) => CheckoutDriverModel(
        quantity: 0,
        id: json["id"],
        minimumAge: json["minimumAge"],
        driverConsent: json["driverConsent"],
        allowExtraDriver: json["allowExtraDriver"],
        maxDriver: json["maxDriver"],
        driverPrice: json["driverPrice"],
        isDiscount: json["isDiscount"],
        driverDiscount: json["driverDiscount"],
        discountedPrice: json["discountedPrice"],
        isFreeDriver: json["isFreeDriver"],
        freeDriverAmount: json["freeDriverAmount"],
        isCents: json["isCents"],
        catalogueId: json["catalogue_id"],
        totalPrice: json["totalPrice"],
      );

  CheckoutDriverModel copyWith({
    int? quantity,
    int? id,
    int? minimumAge,
    bool? driverConsent,
    bool? allowExtraDriver,
    int? maxDriver,
    int? driverPrice,
    bool? isDiscount,
    int? driverDiscount,
    int? discountedPrice,
    bool? isFreeDriver,
    int? freeDriverAmount,
    bool? isCents,
    int? catalogueId,
    dynamic totalPrice,
  }) {
    return CheckoutDriverModel(
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
      minimumAge: minimumAge ?? this.minimumAge,
      driverConsent: driverConsent ?? this.driverConsent,
      allowExtraDriver: allowExtraDriver ?? this.allowExtraDriver,
      maxDriver: maxDriver ?? this.maxDriver,
      driverPrice: driverPrice ?? this.driverPrice,
      isDiscount: isDiscount ?? this.isDiscount,
      driverDiscount: driverDiscount ?? this.driverDiscount,
      discountedPrice: discountedPrice ?? this.discountedPrice,
      isFreeDriver: isFreeDriver ?? this.isFreeDriver,
      freeDriverAmount: freeDriverAmount ?? this.freeDriverAmount,
      isCents: isCents ?? this.isCents,
      catalogueId: catalogueId ?? this.catalogueId,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
