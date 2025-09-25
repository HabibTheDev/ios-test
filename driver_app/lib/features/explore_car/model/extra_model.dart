import 'dart:convert';

List<ExtraModel> extraModelFromJson(String str) =>
    List<ExtraModel>.from(json.decode(str).map((x) => ExtraModel.fromJson(x)));

class ExtraModel {
  int quantity;
  final int? id;
  final String? title;
  final String? description;
  final int? maxUnits;
  final int? packagePrice;
  final bool? isActive;
  final bool? isFreeUnits;
  final dynamic freeUnits;
  final bool? isDiscount;
  final int? extrasDiscount;
  final bool? isCents;
  final int? extrasId;
  final dynamic discountedPrice;

  ExtraModel({
    required this.quantity,
    this.id,
    this.title,
    this.description,
    this.maxUnits,
    this.packagePrice,
    this.isActive,
    this.isFreeUnits,
    this.freeUnits,
    this.isDiscount,
    this.extrasDiscount,
    this.isCents,
    this.extrasId,
    this.discountedPrice,
  });

  factory ExtraModel.fromJson(Map<String, dynamic> json) => ExtraModel(
        quantity: 0,
        id: json["id"],
        title: json["title"],
        description: json["description"],
        maxUnits: json["maxUnits"],
        packagePrice: json["packagePrice"],
        isActive: json["isActive"],
        isFreeUnits: json["isFreeUnits"],
        freeUnits: json["freeUnits"],
        isDiscount: json["isDiscount"],
        extrasDiscount: json["extrasDiscount"],
        isCents: json["isCents"],
        extrasId: json["extrasId"],
        discountedPrice: json["discountedPrice"],
      );

  ExtraModel copyWith({
    int? quantity,
    int? id,
    String? title,
    String? description,
    int? maxUnits,
    int? packagePrice,
    bool? isActive,
    bool? isFreeUnits,
    dynamic freeUnits,
    bool? isDiscount,
    int? extrasDiscount,
    bool? isCents,
    int? extrasId,
    dynamic discountedPrice,
  }) {
    return ExtraModel(
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      maxUnits: maxUnits ?? this.maxUnits,
      packagePrice: packagePrice ?? this.packagePrice,
      isActive: isActive ?? this.isActive,
      isFreeUnits: isFreeUnits ?? this.isFreeUnits,
      freeUnits: freeUnits ?? this.freeUnits,
      isDiscount: isDiscount ?? this.isDiscount,
      extrasDiscount: extrasDiscount ?? this.extrasDiscount,
      isCents: isCents ?? this.isCents,
      extrasId: extrasId ?? this.extrasId,
      discountedPrice: discountedPrice ?? this.discountedPrice,
    );
  }
}
