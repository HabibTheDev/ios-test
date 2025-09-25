import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

Notifications notificationsFromMap(Map<String, dynamic> data) => Notifications.fromJson(data);

class NotificationModel {
  final Meta? meta;
  final Data? data;

  NotificationModel({
    this.meta,
    this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  final List<Notifications>? notifications;
  final int? totalUnread;

  Data({
    this.notifications,
    this.totalUnread,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        notifications: json["notifications"] == null
            ? []
            : List<Notifications>.from(json["notifications"]!.map((x) => Notifications.fromJson(x))),
        totalUnread: json["totalUnread"],
      );
}

class Notifications {
  final int? id;
  final String? type;
  final String? title;
  final String? message;
  final int? refId;
  final String? refUrl;
  final RefObj? refObj;
  final dynamic fcmToken;
  final int? userId;
  final int? brandId;
  final bool? read;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Notifications({
    this.id,
    this.type,
    this.title,
    this.message,
    this.refId,
    this.refUrl,
    this.refObj,
    this.fcmToken,
    this.userId,
    this.brandId,
    this.read,
    this.createdAt,
    this.updatedAt,
  });

  factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        message: json["message"],
        refId: json["refId"],
        refUrl: json["refUrl"],
        refObj: json["refObj"] == null ? null : RefObj.fromJson(json["refObj"]),
        fcmToken: json["fcmToken"],
        userId: json["userId"],
        brandId: json["brandId"],
        read: json["read"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
      );

  Notifications copyWith({
    int? id,
    String? type,
    String? title,
    String? message,
    int? refId,
    String? refUrl,
    RefObj? refObj,
    dynamic fcmToken,
    int? userId,
    int? brandId,
    bool? read,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Notifications(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      message: message ?? this.message,
      refId: refId ?? this.refId,
      refUrl: refUrl ?? this.refUrl,
      refObj: refObj ?? this.refObj,
      fcmToken: fcmToken ?? this.fcmToken,
      userId: userId ?? this.userId,
      brandId: brandId ?? this.brandId,
      read: read ?? this.read,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class RefObj {
  final String? taskState;
  final String? taskType;

  RefObj({
    this.taskState,
    this.taskType,
  });

  factory RefObj.fromJson(Map<String, dynamic> json) => RefObj(
        taskState: json["taskState"],
        taskType: json["taskType"],
      );
}

class Meta {
  final int? page;
  final dynamic limit;
  final int? total;

  Meta({
    this.page,
    this.limit,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
      );
}
