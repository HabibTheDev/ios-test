import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_new/pull_to_refresh.dart';

import '../../../core/l10n/app_localizations.dart';
import '../../../shared/repository/remote/notification_repo.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../core/constants/arguments_key.dart';
import '../../../core/router/router_paths.dart';
import '../../../shared/enums/enums.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  NotificationController({required this.notificationRepo});
  final NotificationRepo notificationRepo;

  // variables
  final RxBool isLoading = true.obs;
  final RxBool markAllAsReadLoading = false.obs;
  bool deleteLoading = false;

  // Notification
  int page = 1;
  int totalPages = 1;
  final RxInt unreadNotification = 0.obs;
  final RefreshController refreshController = RefreshController();
  final RxList<Notifications> notificationList = <Notifications>[].obs;

  @override
  void onInit() async {
    isLoading(true);
    await fetchNotifications();
    isLoading(false);

    super.onInit();
  }

  // Receive notification socket event
  void updateNotificationBySocket({required dynamic data}) {
    debugPrint('New notification received::::::::::::::: $data');
    try {
      if (data['type'] == NotificationType.employeeTask.value) {
        // Update unread notification count
        unreadNotification.value++;
        insertNewNotificationIntoList(data);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // Insert new notification into list
  void insertNewNotificationIntoList(dynamic data) {
    final mapData = data as Map<String, dynamic>;
    final Notifications newNotification = notificationsFromMap(mapData);
    notificationList.insert(0, newNotification);
  }

  Future<void> onLoading() async {
    await fetchNotifications();
    refreshController.loadComplete();
  }

  Future<void> onRefresh() async {
    page = 1;
    totalPages = 1;
    notificationList.clear();
    await fetchNotifications();
    refreshController.refreshCompleted();
  }

  // Fetch Notification
  Future<void> fetchNotifications() async {
    if (page <= totalPages) {
      final notificationModel = await notificationRepo.getNotification(page: page, limit: 20);
      if (notificationModel != null) {
        notificationList.addAll(notificationModel.data?.notifications ?? []);
        page++;
        totalPages = notificationModel.meta?.total ?? 1;
        unreadNotification.value = notificationModel.data?.totalUnread ?? 0;
      }
      debugPrint('Total Notifications: ${notificationList.length}');
    }
  }

  // Delete notification
  Future<void> deleteNotification({required int id, required int index, required AppLocalizations? locale}) async {
    if (deleteLoading) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    deleteLoading = true;
    final result = await notificationRepo.deleteNotification(id: id);
    if (result) {
      // update unread counter
      if (notificationList[index].read == false) {
        unreadNotification.value--;
      }
      notificationList.removeAt(index);
    }
    deleteLoading = false;
  }

  // Mark All As Read
  Future<void> markAllAsRead(AppLocalizations? locale) async {
    if (markAllAsReadLoading.value) {
      showToast('${locale?.anotherProcessRunning}');
      return;
    }
    if (unreadNotification.value == 0) {
      showToast('No unread notification');
      return;
    }
    markAllAsReadLoading(true);
    final result = await notificationRepo.markAllAsRead();
    if (result) {
      for (int i = 0; i < notificationList.length; i++) {
        notificationList[i] = notificationList[i].copyWith(read: true);
      }
      unreadNotification(0);
    }
    markAllAsReadLoading(false);
  }

  // Handle notification onTap
  Future<void> handleNotificationTap({required Notifications notification, required int index}) async {
    if (notification.refObj?.taskState == null) {
      showToast('Task revoked');
      return;
    }
    // General
    if (notification.refObj?.taskState == TaskStateEnum.defaultType.value) {
      await Get.toNamed(RouterPaths.generalTask, arguments: {ArgumentsKey.taskId: notification.refId});
    }
    // Entry Inspection
    if (notification.refObj?.taskState == TaskStateEnum.entryInspection.value) {
      await Get.toNamed(RouterPaths.entryInspection, arguments: {ArgumentsKey.taskId: notification.refId});
    }
    // General Inspection
    // if (notification.refObj?.taskState == TaskStateEnum.generalInspection.value) {
    //   Get.toNamed(
    //     RouterPaths.generalInspection,
    //     arguments: {ArgumentsKey.taskId: notification.refId},
    //   );
    // }
    // Handover
    if (notification.refObj?.taskState == TaskStateEnum.handover.value) {
      await Get.toNamed(RouterPaths.handover, arguments: {ArgumentsKey.taskId: notification.refId});
    }
    // Exchange
    if (notification.refObj?.taskState == TaskStateEnum.exchange.value) {
      await Get.toNamed(RouterPaths.exchange, arguments: {ArgumentsKey.taskId: notification.refId});
    }
    // Return
    if (notification.refObj?.taskState == TaskStateEnum.returnTask.value) {
      await Get.toNamed(RouterPaths.returnTask, arguments: {ArgumentsKey.taskId: notification.refId});
    }
    // Maintenance
    if (notification.refObj?.taskState == TaskStateEnum.maintenance.value) {
      await Get.toNamed(RouterPaths.maintenanceTask, arguments: {ArgumentsKey.taskId: notification.refId});
    }
    // Read notification
    if (notification.read == false) {
      final result = await notificationRepo.readNotification(id: notification.id ?? 0);
      if (result) {
        notificationList[index] = notification.copyWith(read: true);
        unreadNotification.value--;
      }
    }
  }
}
