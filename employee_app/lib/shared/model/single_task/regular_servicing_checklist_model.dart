import 'package:flutter/widgets.dart';

import '../../utils/app_toast.dart';

class RegularServicingChecklistModel {
  final String? checkListTitle;
  final List<CheckList>? checkList;

  RegularServicingChecklistModel({this.checkListTitle, this.checkList});

  static List<RegularServicingChecklistModel>? parseRegularRepairCheck(Map<String, dynamic> json) {
    try {
      final checkSendedList = json['checkSended'];
      final List<Map<String, dynamic>> checkMapList = [];
      final Set regularChecklistSet = {};

      // Add category title to a set
      for (var checkSended in checkSendedList) {
        final String? category =
            checkSended['category']?['category'] ?? checkSended['checkSendedCategory']?['category'];
        if (category != null) {
          regularChecklistSet.add(category);
        }
      }

      final List<String> regularServicingChecklist = List.from(regularChecklistSet);

      for (var checkTitle in regularServicingChecklist) {
        final List<Map<String, dynamic>> checkList = [];

        for (var checkSended in checkSendedList) {
          if (checkTitle.toLowerCase() ==
              (checkSended['category']?['category'] ?? checkSended['checkSendedCategory']?['category']).toLowerCase()) {
            checkList.add(checkSended);
          }
        }
        if (checkList.isNotEmpty) {
          checkMapList.add({"checkListTitle": checkTitle, "checkList": checkList});
        }
      }
      final result = List<RegularServicingChecklistModel>.from(
          checkMapList.map((x) => RegularServicingChecklistModel.fromJson(x)));
      if (result.isNotEmpty) return result;
    } catch (error) {
      showToast('Checklist parsing error');
      debugPrint(error.toString());
    }
    return null;
  }

  factory RegularServicingChecklistModel.fromJson(Map<String, dynamic> json) => RegularServicingChecklistModel(
        checkListTitle: json["checkListTitle"],
        checkList:
            json["checkList"] == null ? [] : List<CheckList>.from(json["checkList"]!.map((x) => CheckList.fromJson(x))),
      );
}

class CheckList {
  final int? availableCheckListId;
  final int? id;
  final String? title;
  final Category? category;
  bool isChecked;

  CheckList({this.availableCheckListId, this.id, this.title, this.category, this.isChecked = false});

  factory CheckList.fromJson(Map<String, dynamic> json) => CheckList(
        availableCheckListId: json["availableCheckListId"],
        id: json["id"],
        title: json["title"],
        category: Category.fromJson(json["category"] ?? json['checkSendedCategory']),
        isChecked: false,
      );
}

class Category {
  final int? id;
  final String? category;
  final int? brandId;
  final int? maintenanceId;

  Category({this.id, this.category, this.brandId, this.maintenanceId});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        category: json["category"],
        brandId: json["brandId"],
        maintenanceId: json["maintenanceId"],
      );
}
