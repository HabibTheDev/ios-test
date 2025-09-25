import 'dart:convert';

ProtectionPlanModel protectionPlanModelFromJson(String str) => ProtectionPlanModel.fromJson(json.decode(str));

class ProtectionPlanModel {
  final int? id;
  final bool? removeCents;
  final String? protectionPolicy;
  final bool? isActive;
  final int? catalogueId;
  final List<ProtectionPackageModel>? protectionPackageList;
  final NoProtectionPlans? noProtectionPlans;

  ProtectionPlanModel({
    this.id,
    this.removeCents,
    this.protectionPolicy,
    this.isActive,
    this.catalogueId,
    this.protectionPackageList,
    this.noProtectionPlans,
  });

  factory ProtectionPlanModel.fromJson(Map<String, dynamic> json) => ProtectionPlanModel(
        id: json["id"],
        removeCents: json["removeCents"],
        protectionPolicy: json["protectionPolicy"],
        isActive: json["isActive"],
        catalogueId: json["catalogue_id"],
        protectionPackageList: json["packages"] == null
            ? []
            : List<ProtectionPackageModel>.from(json["packages"]!.map((x) => ProtectionPackageModel.fromJson(x))),
        noProtectionPlans:
            json["NoProtectionPlans"] == null ? null : NoProtectionPlans.fromJson(json["NoProtectionPlans"]),
      );
}

class NoProtectionPlans {
  final int? id;
  final bool? allowCustomPackage;
  final int? protectionPlansId;
  final List<CustomProtectionModel>? customProtectionList;

  NoProtectionPlans({
    this.id,
    this.allowCustomPackage,
    this.protectionPlansId,
    this.customProtectionList,
  });

  factory NoProtectionPlans.fromJson(Map<String, dynamic> json) => NoProtectionPlans(
        id: json["id"],
        allowCustomPackage: json["allowCustomPackage"],
        protectionPlansId: json["protectionPlansId"],
        customProtectionList: json["coverages"] == null
            ? []
            : List<CustomProtectionModel>.from(json["coverages"]!.map((x) => CustomProtectionModel.fromJson(x))),
      );
}

class CustomProtectionModel {
  bool checkValue;
  final int? id;
  final String? coverageTitle;
  final double? coveragePrice;
  final String? description;
  final int? brandId;
  final dynamic protectionPackagePurchaseId;
  final dynamic protectionPackageId;

  CustomProtectionModel({
    required this.checkValue,
    this.id,
    this.coverageTitle,
    this.coveragePrice,
    this.description,
    this.brandId,
    this.protectionPackagePurchaseId,
    this.protectionPackageId,
  });

  factory CustomProtectionModel.fromJson(Map<String, dynamic> json) => CustomProtectionModel(
        checkValue: false,
        id: json["id"],
        coverageTitle: json["coverageTitle"],
        coveragePrice: json["coveragePrice"]?.toDouble(),
        description: json["description"],
        brandId: json["brandId"],
        protectionPackagePurchaseId: json["protectionPackagePurchaseId"],
        protectionPackageId: json["protectionPackageId"],
      );

  CustomProtectionModel copyWith({
    bool? checkValue,
    int? id,
    String? coverageTitle,
    double? coveragePrice,
    String? description,
    int? brandId,
    dynamic protectionPackagePurchaseId,
    dynamic protectionPackageId,
  }) {
    return CustomProtectionModel(
      checkValue: checkValue ?? this.checkValue,
      id: id ?? this.id,
      coverageTitle: coverageTitle ?? this.coverageTitle,
      coveragePrice: coveragePrice ?? this.coveragePrice,
      description: description ?? this.description,
      brandId: brandId ?? this.brandId,
      protectionPackagePurchaseId: protectionPackagePurchaseId ?? this.protectionPackagePurchaseId,
      protectionPackageId: protectionPackageId ?? this.protectionPackageId,
    );
  }
}

class ProtectionPackageModel {
  final int? id;
  final String? title;
  final bool? isActive;
  final double? packagePrice;
  final bool? isCustom;
  final bool? isDiscount;
  final int? subscriptionDiscount;
  final bool? isCents;
  final int? protectionPlanId;
  final dynamic totalPrice;
  final List<dynamic>? coverages;

  ProtectionPackageModel({
    this.id,
    this.title,
    this.isActive,
    this.packagePrice,
    this.isCustom,
    this.isDiscount,
    this.subscriptionDiscount,
    this.isCents,
    this.protectionPlanId,
    this.totalPrice,
    this.coverages,
  });

  factory ProtectionPackageModel.fromJson(Map<String, dynamic> json) => ProtectionPackageModel(
        id: json["id"],
        title: json["title"],
        isActive: json["isActive"],
        packagePrice: json["packagePrice"]?.toDouble(),
        isCustom: json["isCustom"],
        isDiscount: json["isDiscount"],
        subscriptionDiscount: json["subscriptionDiscount"],
        isCents: json["isCents"],
        protectionPlanId: json["protectionPlanId"],
        totalPrice: json["totalPrice"],
        coverages: json["coverages"] == null ? [] : List<dynamic>.from(json["coverages"]!.map((x) => x)),
      );
}
