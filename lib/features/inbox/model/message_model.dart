import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

class MessageModel {
  final Meta? meta;
  final Data? data;

  MessageModel({this.meta, this.data});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );
}

class Data {
  final List<Message>? messages;

  Data({this.messages});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        messages: json["messages"] == null
            ? []
            : List<Message>.from(
                json["messages"]!.map((x) => Message.fromJson(x))),
      );
}

class Message {
  final int? id;
  final int? conversationId;
  final String? message;
  final List<Attachment>? attachments;
  final bool? toAdmin;
  final DateTime? updatedAt;
  final DateTime? createdAt;

  Message({
    this.id,
    this.conversationId,
    this.message,
    this.attachments,
    this.toAdmin,
    this.updatedAt,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        conversationId: json["conversationId"],
        message: json["message"],
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        toAdmin: json["toAdmin"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );

  Message copyWith({
    int? id,
    int? conversationId,
    String? message,
    List<Attachment>? attachments,
    bool? toAdmin,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) {
    return Message(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      message: message ?? this.message,
      attachments: attachments ?? this.attachments,
      toAdmin: toAdmin ?? this.toAdmin,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class Attachment {
  final int? id;
  final String? url;
  final String? type;

  Attachment({this.id, this.url, this.type});

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        url: json["url"],
        type: json["type"],
      );
}

class Meta {
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPage;

  Meta({this.page, this.limit, this.total, this.totalPage});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        page: json["page"],
        limit: json["limit"],
        total: json["total"],
        totalPage: json["totalPage"],
      );
}
