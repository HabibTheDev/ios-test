import '../../../features/notification/model/notification_model.dart';

abstract class NotificationRepo {
  Future<NotificationModel?> getNotification({required int page, required int limit});
  Future<bool> deleteNotification({required int id});
  Future<bool> readNotification({required int id});
  Future<bool> markAllAsRead();
}
