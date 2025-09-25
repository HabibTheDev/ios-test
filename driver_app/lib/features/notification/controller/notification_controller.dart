import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/constants/app_string.dart';
import '../../../shared/services/remote/socket_service.dart';
import '../../../shared/utils/app_toast.dart';
import '../../../core/constants/api_endpoint.dart';
import '../../../shared/services/remote/notification_service.dart';
import '../../../shared/utils/enums.dart';
import '../model/notification_model.dart';

class NotificationController extends GetxController {
  NotificationController(this._service);
  final NotificationService _service;

  // variables
  final RxBool isLoading = true.obs;
  final RxBool markAllAsReadLoading = false.obs;
  bool deleteLoading = false;

  // Socket
  late IO.Socket socket;

  // Notification
  int page = 1;
  int totalPages = 1;
  RxInt unreadNotification = 0.obs;
  final RefreshController refreshController = RefreshController();
  final RxList<Notifications> notificationList = <Notifications>[].obs;

  @override
  void onInit() async {
    super.onInit();
    isLoading(true);

    await fetchNotifications();
    await SocketService.instance.initSocket();
    receiveNotificationEvent();
    isLoading(false);
  }

  // Receive notification socket event
  void receiveNotificationEvent() {
    socket = SocketService.instance.socket!;

    socket.on(ApiEndpoint.getNotificationEvent, (data) async {
      debugPrint('New notification received::::::::::::::: $data');
      // Update unread notification count
      unreadNotification.value++;
      // Show local notification
      if (data['type'] != NotificationType.employeeTask.value) {
        // FirebasePushApiService().showLocalNotification(
        //   id: data['id'],
        //   title: data['title'],
        //   body: data['message'],
        //   payload: jsonEncode(data),
        // );
        insertNewNotificationIntoList(data);
      }
    });
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
      final notificationModel = await _service.getNotification(page: page, limit: 20);
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
  Future<void> deleteNotification({required int id, required int index}) async {
    if (deleteLoading) {
      showToast(AppString.anotherProcessRunning);
      return;
    }
    deleteLoading = true;
    final result = await _service.deleteNotification(id: id);
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
  Future<void> markAllAsRead() async {
    if (markAllAsReadLoading.value) {
      showToast(AppString.anotherProcessRunning);
      return;
    }
    if (unreadNotification.value == 0) {
      showToast('No unread notification');
      return;
    }
    markAllAsReadLoading(true);
    final result = await _service.markAllAsRead();
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
    // // General
    // if (notification.refObj?.taskState == TaskStateEnum.defaultType.value) {
    //   Get.toNamed(
    //     RouterPaths.generalTask,
    //     arguments: {ArgumentsKey.taskId: notification.refId},
    //   );
    // }
    // // Entry Inspection
    // if (notification.refObj?.taskState == TaskStateEnum.entryInspection.value) {
    //   Get.toNamed(
    //     RouterPaths.entryInspection,
    //     arguments: {ArgumentsKey.taskId: notification.refId},
    //   );
    // }
    // // Handover
    // if (notification.refObj?.taskState == TaskStateEnum.handover.value) {
    //   Get.toNamed(
    //     RouterPaths.handover,
    //     arguments: {ArgumentsKey.taskId: notification.refId},
    //   );
    // }
    // // Exchange
    // if (notification.refObj?.taskState == TaskStateEnum.exchange.value) {
    //   Get.toNamed(
    //     RouterPaths.exchange,
    //     arguments: {ArgumentsKey.taskId: notification.refId},
    //   );
    // }
    // // Return
    // if (notification.refObj?.taskState == TaskStateEnum.returnTask.value) {
    //   Get.toNamed(RouterPaths.returnTask, arguments: {ArgumentsKey.taskId: notification.refId});
    // }
    // // Maintenance
    // if (notification.refObj?.taskState == TaskStateEnum.maintenance.value) {
    //   Get.toNamed(RouterPaths.maintenanceTask, arguments: {ArgumentsKey.taskId: notification.refId});
    // }
    // // Read notification
    // if (notification.read == false) {
    //   final result = await _service.readNotification(id: notification.id ?? 0);
    //   if (result) {
    //     notificationList[index] = notification.copyWith(read: true);
    //     unreadNotification.value--;
    //   }
    // }
  }
}
