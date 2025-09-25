import 'dart:convert';

TaskOverviewModel taskOverviewModelFromJson(String str) => TaskOverviewModel.fromJson(json.decode(str));

class TaskOverviewModel {
  final int? todayTasksCount;
  final int? inProgressTasksCount;
  final int? incompleteTasksCount;
  final int? todayCompletedTasksCount;
  final int? pendingTaskCount;
  final int? totalTasksCount;

  TaskOverviewModel({
    this.todayTasksCount,
    this.inProgressTasksCount,
    this.incompleteTasksCount,
    this.todayCompletedTasksCount,
    this.pendingTaskCount,
    this.totalTasksCount,
  });

  factory TaskOverviewModel.fromJson(Map<String, dynamic> json) => TaskOverviewModel(
    todayTasksCount: json["todayTasksCount"],
    inProgressTasksCount: json["inProgressTasksCount"],
    incompleteTasksCount: json["incompleteTasksCount"],
    todayCompletedTasksCount: json["todayCompletedTasksCount"],
    pendingTaskCount: json["pendingTaskCount"],
    totalTasksCount: json["totalTasksCount"],
  );
}
