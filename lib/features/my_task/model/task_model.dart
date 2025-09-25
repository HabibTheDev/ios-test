import 'dart:convert';

List<TaskModel> taskModelFromJson(String str) =>
    List<TaskModel>.from(json.decode(str).map((x) => TaskModel.fromJson(x)));

class TaskModel {
  final int? id;
  final String? carMake;
  final String? carModel;
  final String? carType;
  final String? type;
  final String? state;
  final int? contactId;
  final String? title;
  final DateTime? startTaskDate;
  final DateTime? issueReportedDate;
  final DateTime? date;
  final String? issue;
  final String? priority;
  final String? status;
  final String? currentStatus;
  final int? completionRate;

  TaskModel({
    this.id,
    this.carMake,
    this.carModel,
    this.carType,
    this.type,
    this.state,
    this.contactId,
    this.title,
    this.startTaskDate,
    this.issueReportedDate,
    this.date,
    this.issue,
    this.priority,
    this.status,
    this.currentStatus,
    this.completionRate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    id: json["id"],
    carMake: json["carMake"],
    carModel: json["carModel"],
    carType: json["carType"],
    type: json["type"],
    state: json["state"],
    contactId: json["contactId"],
    title: json["title"],
    startTaskDate: json["startTaskDate"] == null ? null : DateTime.parse(json["startTaskDate"]),
    issueReportedDate: json["issueReportedDate"] == null ? null : DateTime.parse(json["issueReportedDate"]),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    issue: json["issue"],
    priority: json["priority"],
    status: json["status"],
    currentStatus: json["currentStatus"],
    completionRate: json["completionRate"],
  );
}
