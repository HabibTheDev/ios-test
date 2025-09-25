import 'dart:convert';

MileagePlanModel mileagePlanModelFromJson(String str) => MileagePlanModel.fromJson(json.decode(str));

class MileagePlanModel {
  final int? id;
  final String? mileagePolicy;
  final int? catalogueId;
  final List<MileagePackageModel>? mileagePackageList;

  MileagePlanModel({
    this.id,
    this.mileagePolicy,
    this.catalogueId,
    this.mileagePackageList,
  });

  factory MileagePlanModel.fromJson(Map<String, dynamic> json) => MileagePlanModel(
        id: json["id"],
        mileagePolicy: json["mileagePolicy"],
        catalogueId: json["catalogue_id"],
        mileagePackageList: json["packages"] == null
            ? []
            : List<MileagePackageModel>.from(json["packages"]!.map((x) => MileagePackageModel.fromJson(x))),
      );
}

class MileagePackageModel {
  final int? id;
  final String? title;
  final bool? isActive;
  final int? includedMileage;
  final double? extraMileageCharge;
  final int? packagePrice;
  final bool? packagePriceActive;
  final bool? isDiscount;
  final int? subscriptionDiscount;
  final bool? isCents;
  final int? totalPrice;
  final int? subscriptionPlanId;

  MileagePackageModel({
    this.id,
    this.title,
    this.isActive,
    this.includedMileage,
    this.extraMileageCharge,
    this.packagePrice,
    this.packagePriceActive,
    this.isDiscount,
    this.subscriptionDiscount,
    this.isCents,
    this.totalPrice,
    this.subscriptionPlanId,
  });

  factory MileagePackageModel.fromJson(Map<String, dynamic> json) => MileagePackageModel(
        id: json["id"],
        title: json["title"],
        isActive: json["isActive"],
        includedMileage: json["includedMileage"],
        extraMileageCharge: json["extraMileageCharge"]?.toDouble(),
        packagePrice: json["packagePrice"],
        packagePriceActive: json["packagePriceActive"],
        isDiscount: json["isDiscount"],
        subscriptionDiscount: json["subscriptionDiscount"],
        isCents: json["isCents"],
        totalPrice: json["totalPrice"],
        subscriptionPlanId: json["subscriptionPlanId"],
      );
}
