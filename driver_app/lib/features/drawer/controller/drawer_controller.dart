import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_list.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/repository/local/local_storage_repo.dart';
import '../../../shared/repository/remote/drawer_repo.dart';
import '../../../shared/services/remote/notification_service.dart';
import '../../../shared/services/service_locator.dart';

import '../../notification/controller/notification_controller.dart';

import '../model/brand_model.dart';
import '../model/drawer_model.dart';

class AppDrawerController extends GetxController {
  final _drawerService = ServiceLocator.get<DrawerRepo>();

  final RxBool isLoading = true.obs;
  final GlobalKey<ScaffoldState> drawerScaffoldKey = GlobalKey<ScaffoldState>();
  final Rx<DrawerModel> selectedItem = AppList.drawerItemList.first.obs;
  final Rxn<BrandModel> brandModel = Rxn();

  @override
  void onInit() async {
    super.onInit();
    Get.put(NotificationController(NotificationService()));
    await fetchBrandDetails();
    handlePush();
    isLoading(false);
  }

  // Handle push
  Future<void> handlePush() async {
    final Map<String, dynamic>? payload = await ServiceLocator.get<LocalStorageRepo>().getPushPayload();
    if (payload != null) {
      Get.toNamed(RouterPaths.notification);
      ServiceLocator.get<LocalStorageRepo>().clearPushPayload();
    }
  }

  // Drawer item onTap
  void drawerItemOnTap(DrawerModel model, {bool closeDrawer = true}) {
    if (model.drawerItemEnum != selectedItem.value.drawerItemEnum) {
      selectedItem.value = model;
    }
    if (closeDrawer) {
      drawerScaffoldKey.currentState?.closeEndDrawer();
    }
  }

  // Fetch brand details
  Future<void> fetchBrandDetails() async {
    final result = await _drawerService.getBrandDetails();
    if (result != null) {
      brandModel.value = result;
    }
    isLoading(false);
  }
}
