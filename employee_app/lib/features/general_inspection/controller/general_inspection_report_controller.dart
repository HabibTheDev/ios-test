import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_list.dart';

class GeneralInspectionReportController extends GetxController with GetSingleTickerProviderStateMixin {
  final isLoading = false.obs;
  late TabController tabController;
  RxInt selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: AppList.carHealthTabList.length, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onTabChanged(int index) => selectedTab.value = index;
}
